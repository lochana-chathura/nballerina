import wso2/nballerina.bir;
import wso2/nballerina.print.wasm;
import wso2/nballerina.types as t;

const WASM_BOOLEAN = "i32";
const WASM_INT = "i64";
const WASM_FLOAT = "f64";
const WASM_VOID = "None";

enum UniformBaseRepr {
    BASE_REPR_INT,
    BASE_REPR_FLOAT,
    BASE_REPR_BOOLEAN
}

const BASE_REPR_VOID = "BASE_REPR_VOID";
const BASE_REPR_TAGGED = "BASE_REPR_TAGGED";
type BaseRepr UniformBaseRepr|BASE_REPR_TAGGED;
type RetBaseRepr BaseRepr|BASE_REPR_VOID;

type UniformRepr readonly & record {|
    UniformBaseRepr base;
    wasm:Type wasm;
    t:UniformTypeBitSet subtype?;
|};

type TaggedRepr readonly & record {|
    BASE_REPR_TAGGED base = BASE_REPR_TAGGED;
    t:UniformTypeBitSet subtype;
    wasm:Type wasm;
|};

// Maps boolean to i32
type BooleanRepr readonly & record {|
    BASE_REPR_BOOLEAN base = BASE_REPR_BOOLEAN;
    wasm:Type wasm = WASM_BOOLEAN;
|};

// Maps int to i64
type IntRepr readonly & record {|
    BASE_REPR_INT base = BASE_REPR_INT;
    wasm:Type wasm = WASM_INT;
|};

// Maps float to f64
type FloatRepr readonly & record {|
    BASE_REPR_FLOAT base = BASE_REPR_FLOAT;
    wasm:Type wasm = WASM_FLOAT;
|};

type Repr BooleanRepr|IntRepr|FloatRepr|TaggedRepr;

type VoidRepr readonly & record {|
    BASE_REPR_VOID base;
    wasm:Type wasm = "None";
|};

type RetRepr Repr|VoidRepr;

class Scaffold {
    private wasm:Module module;
    map<wasm:Expression[]> renderedRegion = {};
    int[] processedBlocks = [];
    final bir:BasicBlock[] blocks;
    final bir:Region[] regions;
    map<bir:Label[]> regionBlocks = {};
    bir:FunctionDefn defn;
    private Repr[] reprs = [];
    final t:SemType returnType;
    private final RetRepr retRepr;
    private string[] exceptionTags = [];
    private string[] addedExceptionTags = [];
    bir:Label[] brBlockLabels = [];
    bir:Label[] contBlockLabels = [];
    bir:Label[] regionsWithBr = [];
    private Context context = {};
    boolean hasPanic = false;
    int funcExceptionTags = 0;
    private t:Context typeContext;
    function init(wasm:Module module, bir:FunctionCode code, bir:FunctionDefn def, Context context, t:Context typeContext) {
        self.module = module;
        self.blocks = code.blocks;
        self.regions = code.regions.reverse();
        self.defn = def;
        self.returnType = def.signature.returnType;
        self.retRepr = semTypeRetRepr(self.returnType);
        self.typeContext = typeContext;
        self.initializeReprs(code.registers);
        self.context = context;
    }

    public function initializeReprs(bir:Register[] registers) {
        Repr[] reprs = [];
        foreach bir:Register reg in registers {
            Repr repr = semTypeRepr(reg.semType);
            reprs.push(repr);
        }
        self.reprs = reprs;
    }

    public function addExceptionTag(string tag, wasm:Type? kind = ()) {
        if self.context.exceptionTags.indexOf(tag) == () {
            self.module.addTag(tag, kind);
            self.module.addTagExport(tag, tag);
            self.context.exceptionTags.push(tag);
            self.funcExceptionTags += 1;
        }
    }

    public function getExceptionTags() returns int {
        return self.funcExceptionTags;
    }

    public function setSection(string val, int[] surrogate) returns string {
        StringRecord? rec = self.context.segments[val];
        if rec != () {
            return rec.global;
        }
        rec = {
            offset: self.context.offset,
            global: "bal$str" + self.context.segments.keys().length().toString(),
            length: val.toBytes().length(),
            surrogate: surrogate
        };
        self.context.segments[val] = <StringRecord>rec; 
        self.context.offset += val.toBytes().length();
        return (<StringRecord>rec).global.toString();
    }

    function getRepr(bir:Register r) returns Repr => self.reprs[r.number];

    function getRetRepr() returns RetRepr => self.retRepr;

    function addRuntimeModule(RuntimeModule module) {
        if self.context.runtimeModules.indexOf(module) == () {
            self.context.runtimeModules.push(module);
        } 
    }

    function setPanicBlock() {
        self.hasPanic = true;
    }

    function getTypeContext() returns t:Context => self.typeContext;

    function getBlocks() returns bir:BasicBlock[] => self.blocks;
    
    function getRegions() returns bir:Region[] => self.regions;
    
    function setProcessedBlock(bir:Label label) {
        self.processedBlocks.push(label);
    }

    function isBlockProcessed(bir:Label label) returns boolean {
        return self.processedBlocks.indexOf(label) != () ? true : false;
    }


}

final IntRepr REPR_INT = { };
final BooleanRepr REPR_BOOLEAN = { };
final FloatRepr REPR_FLOAT = { };

final TaggedRepr REPR_STRING = { wasm: "eqref", subtype: t:STRING };
final TaggedRepr REPR_NIL = { wasm: "eqref", subtype: t:NIL };
final TaggedRepr REPR_ANY = { wasm: "eqref" , subtype: t:ANY };
final TaggedRepr REPR_LIST_RW = { subtype: t:LIST_RW, wasm: { base: "List", initial: "null" } };
final TaggedRepr REPR_LIST = { subtype: t:LIST, wasm: { base: "List", initial: "null" } };
final TaggedRepr REPR_MAPPING_RW = { subtype: t:MAPPING_RW, wasm: { base: "Map", initial: "null" } };
final TaggedRepr REPR_MAPPING = { subtype: t:MAPPING, wasm: { base: "Map", initial: "null" } };
final TaggedRepr REPR_ERROR = { subtype: t:ERROR, wasm: { base: "Error", initial: "null" } };
final VoidRepr REPR_VOID = { base: BASE_REPR_VOID, wasm: WASM_VOID };

final readonly & record {|
    t:UniformTypeBitSet domain;
    Repr repr;
|}[] typeReprs = [
    { domain: t:FLOAT, repr: REPR_FLOAT },
    { domain: t:INT, repr: REPR_INT },
    { domain: t:BOOLEAN, repr: REPR_BOOLEAN },
    { domain: t:NIL, repr: REPR_NIL },
    { domain: t:ANY, repr: REPR_ANY },
    { domain: t:TOP, repr: REPR_ANY },
    { domain: t:MAPPING_RW, repr: REPR_MAPPING_RW },
    { domain: t:MAPPING, repr: REPR_MAPPING },
    { domain: t:LIST_RW, repr: REPR_LIST_RW },
    { domain: t:LIST, repr: REPR_LIST },
    { domain: t:STRING, repr: REPR_STRING }
];

function semTypeRetRepr(t:SemType ty) returns RetRepr {
    if ty === t:NIL {
        return REPR_VOID;
    }
    return semTypeRepr(ty);
}

function semTypeRepr(t:SemType ty) returns Repr {
    t:UniformTypeBitSet w = t:widenToUniformTypes(ty);
    foreach var tr in typeReprs {
        if w == tr.domain {
            return tr.repr;
        }
    }
    int supported = t:NIL|t:BOOLEAN|t:INT|t:FLOAT|t:STRING|t:LIST|t:MAPPING|t:ERROR;
    int maximized = w | supported;
    if maximized == t:TOP || (w & supported) == w {
        TaggedRepr repr = { base: BASE_REPR_TAGGED, subtype: w, wasm: "eqref" };
        return repr;
    }
    return REPR_NIL;
}

function semTypeReprWasm(t:SemType ty) returns wasm:Type {
    Repr repr = semTypeRepr(ty);
    return repr.wasm;
}

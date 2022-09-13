type A record {|
    int x;
    string y;
|};

// @type B[XorY] = IorSCell
// @type B[other] = NEVER
type B record {|
    string x;
    int y;
|};

// @type C[other] = BooleanCell
// @type C[XorY] = IorSCell
// @type C[XorYorOther] = IorSOrBCell
type C record {|
    string x;
    int y;
    float z;
    boolean...;
|};

type IorSCell &int|&string;
type IorSOrBCell IorSCell|&boolean;

const x = "x";
const z = "z";
const other = "other";
type XorY "x"|"y";
type NEVER &never;
type BooleanCell &boolean;
type FloatCell &float;

type XorYorOther XorY|other;

// @type AorB[x] = IorSCell
// @type AorB[XorY] = IorSCell
type AorB A|B;

// @type AorBorC[x] = IorSCell
// @type AorBorC[z] = FloatCell
// @type AorBorC[other] = BooleanCell
// @type AorBorC[XorYorOther] = IorSOrBCell
type AorBorC AorB|C;

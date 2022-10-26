// Implementation specific to basic type error.

public function errorDetail(Context cx, SemType detail) returns SemType {
    SubtypeData sd = bddIntersect(<BddNode>subtypeData(detail, BT_MAPPING), MAPPING_TOP_RO_BDD);
    if sd is boolean {
        if sd {
            return ERROR;
         }
        else {
            // XXX This should be reported as an error
            return NEVER;
        }
    }
    else {
        return basicSubtype(BT_ERROR, sd);
    }
}

// distinctId must be >= 0
public function errorDistinct(int distinctId) returns SemType {
    BddNode bdd = bddAtom(-distinctId - 1);
    return basicSubtype(BT_ERROR, bdd);
}


function errorSubtypeComplement(SubtypeData t) returns SubtypeData {
    // readonly & map<any|error> is the top subtype of the error type.
    // Simple bddComplement() would give complement w.r.t map<any|error>.
    // Therefore, intersecting bddComplement() result with readonly & map<any|error> here.
    return bddIntersect(bddComplement(<Bdd>t), MAPPING_TOP_RO_BDD);
}

function errorSubtypeIsEmpty(Context cx, SubtypeData t) returns boolean {
    Bdd b = <Bdd>t;
    // The goal of this is to ensure that errorSubtypeIsEmpty does
    // not get an empty posList, because it will interpret that
    // as map<any|error> rather than readonly & map<any|error>.   
    b = bddPosMaybeEmpty(b) ? bddIntersect(b, MAPPING_TOP_RO_BDD) : b;
    return memoSubtypeIsEmpty(cx, cx.mappingMemo, errorBddIsEmpty, b);
}

function errorBddIsEmpty(Context cx, Bdd b) returns boolean {
    return bddEveryPositive(cx, b, (), (), mappingFormulaIsEmpty);
}

final BasicTypeOps errorOps = {
    union: bddSubtypeUnion,
    intersect: bddSubtypeIntersect,
    diff: bddSubtypeDiff,
    complement: errorSubtypeComplement,
    isEmpty: errorSubtypeIsEmpty
};

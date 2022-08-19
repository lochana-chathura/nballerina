// Implementation specific to basic type table.

public function tableContaining(SemType memberType) returns SemType {
    Bdd bdd = <Bdd>subtypeData(memberType, UT_CELL);
    return createUniformSemType(UT_TABLE, bdd);
}

final UniformTypeOps tableOps = {
    union: bddSubtypeUnion,
    intersect: bddSubtypeIntersect,
    diff: bddSubtypeDiff,
    complement: bddSubtypeComplement,
    isEmpty: cellSubtypeIsEmpty
};

type M1 map<int>;

type M2 map<anydata>;

type R1 record {| int a; anydata...; |};

// @type M1 < R2
// @type R2 < M2
// @type R1 < R2
type R2 record {| int a?; anydata...; |};

// @type R2 <> R3
type R3 record {| int? a; anydata...; |};

// @type R4 < R2
type R4 record {| int a?; string b; anydata...; |};

type R5 record {| int a; string b; anydata...; |};

// @type R1 <> R6
// @type R6 < R2
// @type R4 < R6
// @type R5 < R6
// @type R6 < M2
type R6 record {| int a?; string b?; anydata...; |};

// @type R2 < R7
type R7 record {| int|string a?; anydata...; |};

// @type R8 <> R2
// @type R1 <> R8
// @type R8 < M2
type R8 record {| int|string a?; string|boolean b?; boolean c?; anydata...; |};

// @type R1 < R9
// @type R2 < R9
type R9 record {| int? a?; anydata...; |};

// @type R1 < R10
// @type R2 < R10
// @type R3 < R10
// @type R4 < R10
// @type R5 < R10
// @type R6 < R10
// @type R7 < R10
// @type R8 < R10
// @type R9 < R10
// @type M2 = R10
type R10 record {| anydata...; |};

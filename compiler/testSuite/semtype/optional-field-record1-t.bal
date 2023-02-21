type M1 map<int>;

type M2 map<anydata>;

type R1 record {| int a; |};

// @type R2 < M1
// @type R1 < R2
type R2 record {| int a?; |};

// @type R2 <> R3
type R3 record {| int? a; |};

// @type R4 <> R2
type R4 record {| int a?; string b; |};

type R5 record {| int a; string b; |};

// @type R5 < R6
// @type R2 < R6
// @type R1 < R6
// @type R4 < R6
// @type R6 < M2
type R6 record {| int a?; string b?; |};

// @type R2 < R7
type R7 record {| int|string a?; |};

// @type R2 < R8
// @type R1 < R8
// @type R8 < M2
type R8 record {| int|string a?; string|boolean b?; boolean c?; |};

// @type R1 < R9
// @type R2 < R9
type R9 record {| int? a?; |};

// @type R10 < R9
// @type R10 < R2
// @type R10 <> R1
type R10 record {| |};

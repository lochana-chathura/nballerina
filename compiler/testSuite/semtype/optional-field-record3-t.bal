type R11 record {| int a; |};
type R12 record {| int a; anydata...; |};

type R21 record {| int a?; |};
type R22 record {| int a?; anydata...; |};

type R31 record {| int? a; |};
type R32 record {| int? a; anydata...; |};

type R41 record {| int a?; string b; |};
type R42 record {| int a?; string b; anydata...; |};

type R51 record {| int a; string b; |};
type R52 record {| int a; string b; anydata...; |};

type R61 record {| int a?; string b?; |};
type R62 record {| int a?; string b?; anydata...; |};

type R71 record {| int|string a?; |};
type R72 record {| int|string a?; anydata...; |};

type R81 record {| int|string a?; string|boolean b?; boolean c?; |};
type R82 record {| int|string a?; string|boolean b?; boolean c?; anydata...; |};

type R91 record {| int? a?; |};
type R92 record {| int? a?; anydata...; |};

type R101 record {| |};
type R102 record {| anydata...; |};

// @type R11 < R12
// @type R21 < R22
// @type R31 < R32
// @type R41 < R42
// @type R51 < R52
// @type R61 < R62
// @type R71 < R72
// @type R81 < R82
// @type R91 < R92
// @type R101 < R102

// @type R11 < R22
// @type R12 <> R21
// @type R11 < R32
// @type R12 <> R31
// @type R11 <> R42
// @type R12 <> R41
// @type R11 <> R52
// @type R51 < R12 
// @type R11 < R62
// @type R12 <> R61

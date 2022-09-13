type B boolean;
type BCell &boolean;

// @type TF = B
type TF true|false;

// @type T < TF
type T true;

// @type F < B
type F false;

// @type I <> B
type I int;
type ICell &int;

type S string;
type N 2;
const ONE = 1;

// @type BL[1] = B
// @type BL[2] = B
// @type BL[I] = B
// @type BL[N] = B
// @type BL[ONE] = B
type BL boolean[]; 

// @type M[S] = BCell
type M map<boolean>;

type f1 "f1";
type f2 "f2";
const FOO = "f2";

// @type R[f1] = ICell 
// @type R[f2] = BCell
// @type R[FOO] = BCell
type R record {|
    int f1;
    boolean f2;
|};

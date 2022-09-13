type IBCell &int|&boolean;
type SBCell &string|&boolean;
type C string:Char;
type NonC string & !C;

// @type R[C] = IBCell
// @type R[NonC] = SBCell
type R record {|
    int a;
    int b;
    string fieldName;
    boolean...;
|};

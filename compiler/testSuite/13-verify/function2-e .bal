public function main() {
    int z = foo(1, "d"); // @error
}

function foo(int x, int y) returns int {
    return x;
}

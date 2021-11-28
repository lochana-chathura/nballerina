#include <math.h>
#include <assert.h>
#include "../balrt.h"
#include "../hash.h"

HASH_DEFINE_KEY;

void validatDecToFloat(const char *decStr, double val) {
    assert(_bal_decimal_to_float(_bal_decimal_const(decStr)) == val);
}

void testDecToFloat() {
    validatDecToFloat("1", 1);
    validatDecToFloat("1.000000000000000000000000000000000", 1);
    validatDecToFloat("1.1", 1.1);
    validatDecToFloat("9.0", 9);
    validatDecToFloat("9.1", 9.1);
    validatDecToFloat("9.999999999999999999999999999999999", 10.0);
    validatDecToFloat("9.99999999999999999999999999999999", 10.0);
    validatDecToFloat("9.9999999999999999999999999999999", 10.0);
    validatDecToFloat("10.00000000000000000000000000", 10.0);
    validatDecToFloat("10.00000000000000000000000001", 10.0);
    validatDecToFloat("10.00000000000000000000000001", 10.0);
    validatDecToFloat("99.99999999999999999999999999999999", 100.0);
    validatDecToFloat("1e2", 1e2);
    validatDecToFloat("1.9e2", 1.9e2);
    validatDecToFloat("9.999999999999999999999999999999999e100", 1.0e101);
    validatDecToFloat("9999999999999999999999999999999999e100", 1.0e134);
    validatDecToFloat("1e308", 1.0e308);
    validatDecToFloat("1.7976931348623158e+308", 1.7976931348623158e+308);
    validatDecToFloat("1.79769313486231571e+308", 1.79769313486231571e+308);
    validatDecToFloat("1.79769313486231570e+308", 1.79769313486231570e+308);
    validatDecToFloat("1.7976931348623156e+308", 1.7976931348623156e+308);
    validatDecToFloat("-1.7976931348623157e+308", -1.7976931348623157e+308);
    validatDecToFloat("-1.79769313486231571e308", -1.79769313486231571e308);
    validatDecToFloat("-1.7976931348623158e308", -1.7976931348623158e308);
    validatDecToFloat("-1.7976931348623156e+308", -1.7976931348623156e+308);
    validatDecToFloat("0", 0.0);
    validatDecToFloat("1e-322", 1e-322);
    validatDecToFloat("1e-323", 1e-323);
    validatDecToFloat("1e-324", 0.0);
    validatDecToFloat("-1e-324", 0.0);
    validatDecToFloat("1e-6143", 0.0);
    validatDecToFloat("-1e-6143", 0.0);
    validatDecToFloat("1e309", INFINITY);
    validatDecToFloat("1.7976931348623156e+309", INFINITY);
    validatDecToFloat("9.999999999999999999999999999999999E6144", INFINITY);
    validatDecToFloat("-1e309", -INFINITY);
    validatDecToFloat("-2e309", -INFINITY);
    validatDecToFloat("-9.999999999999999999999999999999999E6144", -INFINITY);
    validatDecToFloat("-1.7976931348623156e+309", -INFINITY);
}

int main() {
    testDecToFloat();
}
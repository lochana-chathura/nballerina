import ballerina/io;
public function main() {
    decimal d1 = 1d;
    decimal d2 = 1d;
    io:println(d1 + d2); // @output 2

    d1 = 1000d; 
    d2 = 1d;
    io:println(d1 + d2); // @output 1001

    d1 = 1234567890123456789012345678901234d; 
    d2 = 1234567890123456789012345678901231d;
    io:println(d1 + d2); // @output 2469135780246913578024691357802465

    d1 = 12345678901234567890123456789012341d; 
    d2 = 12345678901234567890123456789012312d;
    io:println(d1 + d2); // @output 2.469135780246913578024691357802465E+34

    d1 = 1234567890123456789012345678901234d; 
    d2 = 12345678901234567890123456789012312d;
    io:println(d1 + d2); // @output 1.358024679135802467913580246791354E+34

    d1 = 9.999999999999999999999999999999998E6144d; 
    d2 = 0.000000000000000000000000000000001E6144d;
    io:println(d1 + d2); // @output 9.999999999999999999999999999999999E+6144

    d1 = 9.999999999999999999999999999999995E6144d; 
    d2 = 0.000000000000000000000000000000002E6144d;
    io:println(d1 + d2); // @output 9.999999999999999999999999999999997E+6144

    d1 = -9.999999999999999999999999999999998E6144d; 
    d2 = -0.000000000000000000000000000000001E6144d;
    io:println(d1 + d2); // @output -9.999999999999999999999999999999999E+6144

    d1 = -9.999999999999999999999999999999999E6144d; 
    d2 = 0.000000000000000000000000000000001E6144d;
    io:println(d1 + d2); // @output -9.999999999999999999999999999999998E+6144

    d1 = 2E-6143d; 
    d2 = 1E-6143d;
    io:println(d1 + d2); // @output 3E-6143

    d1 = 0.000000000000000000000000000000001E-6110d; 
    d2 = 0.000000000000000000000000000000002E-6110d;
    io:println(d1 + d2); // @output 3E-6143

    d1 = 2E-6143d; 
    d2 = -1E-6143d;
    io:println(d1 + d2); // @output 1E-6143

    d1 = 9E-6143d; 
    d2 = 1E-6143d;
    io:println(d1 + d2); // @output 1.0E-6142
    
    d1 = 1E-6143d; 
    d2 = -1E-6143d;
    io:println(d1 + d2); // @output 0
}

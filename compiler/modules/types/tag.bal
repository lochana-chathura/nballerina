// Always immutable 
public const UT_NIL        = 0x00;
public const UT_BOOLEAN    = 0x01;
public const UT_INT        = 0x02;
public const UT_FLOAT      = 0x03;
public const UT_DECIMAL    = 0x04;
public const UT_STRING     = 0x05;
public const UT_ERROR      = 0x06;
public const UT_TYPEDESC   = 0x07;
public const UT_HANDLE     = 0x08;
public const UT_FUNCTION   = 0x09;

// Always mutable 
public const UT_FUTURE     = 0xA;
public const UT_STREAM     = 0xB;

// Selectively immutable
public const UT_LIST       = 0xC;
public const UT_MAPPING    = 0xD;
public const UT_TABLE      = 0xE;
public const UT_XML        = 0xF;
public const UT_OBJECT     = 0x10;
public const UT_CELL       = 0x11;

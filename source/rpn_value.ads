
package rpn_value is

    type Value (isInt: Boolean := True) is record
        case isInt is
            when True => int: Integer;
            when False => float: Long_Float;
        end case;
    end record;

    function To_Value (int: Integer) return Value;

    function To_Value (float: Long_Float) return Value;

    function From_String (str: String) return Value;

    function To_String (val: Value) return String;

    function To_Long_Float(val: Value) return Long_Float;

    function "+"(a, b: Value) return Value;

    function "-"(a, b: Value) return Value;

    function "*"(a, b: Value) return Value;

    function "/"(a, b: Value) return Value;

end rpn_value;

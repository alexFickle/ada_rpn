
package body rpn_value is

    function To_Value (int: Integer) return Value is
        val : Value(True);
    begin
        val.int := int;
        return val;
    end To_Value;

    function To_Value(float: Long_Float) return Value is
        val: Value(False);
    begin
        val.float := float;
        return val;
    end To_Value;

    function To_Value (str: String) return Value is
        int: Value(True);
        float: Value(False);
    begin
        int.int := Integer'Value(str);
        return int;
    exception when e: Constraint_Error =>
        float.float := Long_Float'Value(str);
        return float;
    end To_Value;

    function To_String (val: Value) return String is
    begin
        case val.isInt is
            when True => return Integer'Image(val.int);
            when False => return Long_Float'Image(val.float);
        end case;
    end To_String;

    function To_Long_Float(val: Value) return Long_Float is
    begin
        case val.isInt is
            when True => return Long_Float(val.int);
            when False => return val.float;
        end case;
    end To_Long_Float;

    function "+"(a, b: Value) return Value is
    begin
        if a.isInt and b.isInt then
            return To_Value(a.int + b.int);
        else
            return To_Value(To_Long_Float(a) + To_Long_Float(b));
        end if;
    end "+";

    function "-"(a, b: Value) return Value is
    begin
        if a.isInt and b.isInt then
            return To_Value(a.int - b.int);
        else
            return To_Value(To_Long_Float(a) - To_Long_Float(b));
        end if;
    end "-";

    function "*"(a, b: Value) return Value is
    begin
        if a.isInt and b.isInt then
            return To_Value(a.int * b.int);
        else
            return To_Value(To_Long_Float(a) * To_Long_Float(b));
        end if;
    end "*";

    function "/"(a, b: Value) return Value is
    begin
        return To_Value(To_Long_Float(a) / To_Long_Float(b));
    end "/";

end rpn_value;

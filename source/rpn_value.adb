with Ada.Numerics.Long_Elementary_Functions;

package body rpn_value is

    function To_Value (int : Integer) return Value is
    begin
        return (isInt => True, int => int);
    end To_Value;

    function To_Value (float : Long_Float) return Value is
    begin
        return (isInt => False, float => float);
    end To_Value;

    function To_Value (str : String) return Value is
    begin
        return (isInt => True, int => Integer'Value (str));
    exception
        when e : Constraint_Error =>
            return (isInt => False, float => Long_Float'Value (str));
    end To_Value;

    function To_String (val : Value) return String is
    begin
        case val.isInt is
            when True =>
                return Integer'Image (val.int);
            when False =>
                return Long_Float'Image (val.float);
        end case;
    end To_String;

    function To_Long_Float (val : Value) return Long_Float is
    begin
        case val.isInt is
            when True =>
                return Long_Float (val.int);
            when False =>
                return val.float;
        end case;
    end To_Long_Float;

    function "+" (a, b : Value) return Value is
    begin
        if a.isInt and b.isInt then
            return To_Value (a.int + b.int);
        else
            return To_Value (To_Long_Float (a) + To_Long_Float (b));
        end if;
    end "+";

    function "-" (a, b : Value) return Value is
    begin
        if a.isInt and b.isInt then
            return To_Value (a.int - b.int);
        else
            return To_Value (To_Long_Float (a) - To_Long_Float (b));
        end if;
    end "-";

    function "*" (a, b : Value) return Value is
    begin
        if a.isInt and b.isInt then
            return To_Value (a.int * b.int);
        else
            return To_Value (To_Long_Float (a) * To_Long_Float (b));
        end if;
    end "*";

    function "/" (a, b : Value) return Value is
    begin
        return To_Value (To_Long_Float (a) / To_Long_Float (b));
    end "/";

    function "**" (a, b : Value) return Value is
        use Ada.Numerics.Long_Elementary_Functions;
    begin
        if a.isInt and then b.isInt and then b.int >= 0 then
            return To_Value (a.int**b.int);
        else
            return To_Value (To_Long_Float (a)**To_Long_Float (b));
        end if;
    end "**";

end rpn_value;

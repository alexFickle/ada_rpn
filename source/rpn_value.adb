with Ada.Numerics.Long_Elementary_Functions;

package body RPN_Value is

    function To_Value (Int : Integer) return Value is
    begin
        return (Is_Int => True, Int => Int);
    end To_Value;

    function To_Value (Float : Long_Float) return Value is
    begin
        return (Is_Int => False, Float => Float);
    end To_Value;

    function To_Value (Str : String) return Value is
    begin
        return (Is_Int => True, Int => Integer'Value (Str));
    exception
        when e : Constraint_Error =>
            return (Is_Int => False, Float => Long_Float'Value (Str));
    end To_Value;

    function To_String (Val : Value) return String is
    begin
        case Val.Is_Int is
            when True =>
                return Integer'Image (Val.Int);
            when False =>
                return Long_Float'Image (Val.Float);
        end case;
    end To_String;

    function To_Long_Float (Val : Value) return Long_Float is
    begin
        case Val.Is_Int is
            when True =>
                return Long_Float (Val.Int);
            when False =>
                return Val.Float;
        end case;
    end To_Long_Float;

    function "+" (A, B : Value) return Value is
    begin
        if A.Is_Int and B.Is_Int then
            return To_Value (A.Int + B.Int);
        else
            return To_Value (To_Long_Float (A) + To_Long_Float (B));
        end if;
    end "+";

    function "-" (A, B : Value) return Value is
    begin
        if A.Is_Int and B.Is_Int then
            return To_Value (A.Int - B.Int);
        else
            return To_Value (To_Long_Float (A) - To_Long_Float (B));
        end if;
    end "-";

    function "*" (A, B : Value) return Value is
    begin
        if A.Is_Int and B.Is_Int then
            return To_Value (A.Int * B.Int);
        else
            return To_Value (To_Long_Float (A) * To_Long_Float (B));
        end if;
    end "*";

    function "/" (A, B : Value) return Value is
    begin
        return To_Value (To_Long_Float (A) / To_Long_Float (B));
    end "/";

    function "**" (A, B : Value) return Value is
        use Ada.Numerics.Long_Elementary_Functions;
    begin
        if A.Is_Int and then B.Is_Int and then B.Int >= 0 then
            return To_Value (A.Int**B.Int);
        else
            return To_Value (To_Long_Float (A)**To_Long_Float (B));
        end if;
    end "**";

    function Truncating_Divide (A, B : Value) return Value is
    begin
        if A.Is_Int and B.Is_Int then
            return To_Value (A.Int / B.Int);
        else
            return To_Value (Integer (To_Long_Float (A) / To_Long_Float (B)));
        end if;
    end Truncating_Divide;

end RPN_Value;

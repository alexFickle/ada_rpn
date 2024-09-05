package rpn_value is

    type Value is private;

    function To_Value (Int : Integer) return Value;

    function To_Value (Float : Long_Float) return Value;

    function To_Value (Str : String) return Value;

    function To_String (Val : Value) return String;

    function To_Long_Float (Val : Value) return Long_Float;

    function "+" (A, B : Value) return Value;

    function "-" (A, B : Value) return Value;

    function "*" (A, B : Value) return Value;

    function "/" (A, B : Value) return Value;

    function "**" (A, B : Value) return Value;

    function Truncating_Divide (A, B : Value) return Value;

private
    type Value (Is_Int : Boolean := True) is record
        case Is_Int is
            when True =>
                Int : Integer;
            when False =>
                Float : Long_Float;
        end case;
    end record;

end rpn_value;

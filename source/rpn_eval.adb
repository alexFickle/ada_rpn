with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Containers.Vectors; use Ada.Containers;
use Ada;

with rpn_value; use rpn_value;
with rpn_var_map;

function rpn_eval (Str : String; Var_Map : rpn_var_map.Map) return Value is

    package Value_Vectors is new Containers.Vectors
       (Index_Type => Natural, Element_Type => Value);
    use Value_Vectors;

    procedure Pop_Two (Vec : in out Vector; A : out Value; B : out Value) is
    begin
        B := Vec.Last_Element;
        Vec.Delete_Last;
        A := Vec.Last_Element;
        Vec.Delete_Last;
    exception
        when E : Constraint_Error =>
            raise Constraint_Error
               with "invalid RPN equation, binary operator missing operands";
    end Pop_Two;

    function Eval_Operand
       (Str : String; Var_Map : rpn_var_map.Map) return Value
    is
    begin
        return To_Value (Str);
    exception
        when E : Constraint_Error =>
            if Var_Map.Contains (Str) then
                return Var_Map (Str);
            end if;
            raise Constraint_Error
               with "invalid RPN equation, failed to parse token: " & Str;
    end Eval_Operand;

    Pos   : Natural := Str'First;
    First : Positive;
    Last  : Natural;
    Vec   : Vector;

    Whitespace : constant Strings.Maps.Character_Set :=
       Strings.Maps.To_Set (' ');

begin
    while Pos in Str'Range loop
        Strings.Fixed.Find_Token
           (Source => Str, Set => Whitespace, From => Pos,
            Test   => Strings.Outside, First => First, Last => Last);
        exit when Last = 0;
        declare
            A, B   : Value;
            Substr : String := Str (First .. Last);
        begin
            Pos := Last + 1;
            if Substr = "+" then
                Pop_Two (Vec, A, B);
                Vec.Append (A + B);
            elsif Substr = "-" then
                Pop_Two (Vec, A, B);
                Vec.Append (A - B);
            elsif Substr = "*" then
                Pop_Two (Vec, A, B);
                Vec.Append (A * B);
            elsif Substr = "/" then
                Pop_Two (Vec, A, B);
                Vec.Append (A / B);
            elsif Substr = "**" then
                Pop_Two (Vec, A, B);
                Vec.Append (A**B);
            elsif Substr = "//" then
                Pop_Two (Vec, A, B);
                Vec.Append (Truncating_Divide (A, B));
            else
                Vec.Append (Eval_Operand (Substr, Var_Map));
            end if;
        end;
    end loop;

    if Vec.Length /= 1 then
        raise Constraint_Error
           with "invalid RPN equation, failed to evaluate to single value";
    end if;

    return Vec.Last_Element;

end rpn_eval;

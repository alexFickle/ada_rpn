with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Containers.Vectors; use Ada.Containers;
use Ada;

with rpn_value; use rpn_value;
with rpn_var_map;

function rpn_eval (str : String; var_map : rpn_var_map.Map) return Value is

    package Value_Vectors is new Containers.Vectors
       (Index_Type => Natural, Element_Type => Value);
    use Value_Vectors;

    procedure pop_two (vec : in out Vector; a : out Value; b : out Value) is
    begin
        b := vec.Last_Element;
        vec.Delete_Last;
        a := vec.Last_Element;
        vec.Delete_Last;
    exception
        when E : Constraint_Error =>
            raise Constraint_Error
               with "invalid RPN equation, binary operator missing operands";
    end pop_two;

    function eval_operand
       (str : String; var_map : rpn_var_map.Map) return Value
    is
    begin
        return To_Value (str);
    exception
        when E : Constraint_Error =>
            if var_map.Contains (str) then
                return var_map (str);
            end if;
            raise Constraint_Error
               with "invalid RPN equation, failed to parse token: " & str;
    end eval_operand;

    pos   : Natural := 1;
    first : Positive;
    last  : Natural;
    vec   : Vector;

    whitespace : constant Strings.Maps.Character_Set :=
       Strings.Maps.To_Set (' ');

begin
    while pos in str'Range loop
        Strings.Fixed.Find_Token
           (Source => str, Set => whitespace, From => pos,
            Test   => Strings.Outside, First => first, Last => last);
        exit when last = 0;
        declare
            a, b   : Value;
            substr : String := str (first .. last);
        begin
            pos := last + 1;
            if substr = "+" then
                pop_two (vec, a, b);
                vec.Append (a + b);
            elsif substr = "-" then
                pop_two (vec, a, b);
                vec.Append (a - b);
            elsif substr = "*" then
                pop_two (vec, a, b);
                vec.Append (a * b);
            elsif substr = "/" then
                pop_two (vec, a, b);
                vec.Append (a / b);
            elsif substr = "**" then
                pop_two(vec, a, b);
                vec.Append(a ** b);
            elsif substr = "//" then
                pop_two(vec, a, b);
                vec.Append(Truncating_Divide(a, b));
            else
                vec.Append (eval_operand (substr, var_map));
            end if;
        end;
    end loop;

    if vec.Length /= 1 then
        raise Constraint_Error
           with "invalid RPN equation, failed to evaluate to single value";
    end if;

    return vec.Last_Element;

end rpn_eval;

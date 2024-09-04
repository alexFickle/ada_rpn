with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Containers.Vectors;
use Ada;
use Ada.Containers;

with rpn_value; use rpn_value;

function rpn_eval (str: String) return Value is

    package Value_Vectors is new
        Containers.Vectors(
            Index_Type   => Natural,
            Element_Type => Value
        );
    use Value_Vectors;

    procedure pop_two(vec: in out Vector; a: out Value; b: out Value) is
    begin
        b := vec.Last_Element;
        vec.Delete_Last;
        a := vec.Last_Element;
        vec.Delete_Last;
    exception
        when E : Constraint_Error =>
            raise Constraint_Error with
                "invalid RPN equation, binary operator missing operands";
    end;

    pos : Natural := 1;
    first: Positive;
    last: Natural;
    vec: Vector;

    whitespace : constant Strings.Maps.Character_Set := Strings.Maps.To_Set(' ');

begin
    while pos in str'Range loop
        Strings.Fixed.Find_Token(
            Source => str,
            Set => whitespace,
            From => pos,
            Test => Strings.Outside,
            First => first,
            Last => last
        );
            exit when last = 0;
            declare
                a, b: Value;
                substr: String := str (first .. last);
            begin
                pos := last + 1;
                if substr = "+" then
                    pop_two(vec, a, b);
                    vec.Append(Add(a, b));
                elsif substr = "-" then
                    pop_two(vec, a, b);
                    vec.Append(Sub(a, b));
                elsif substr = "*" then
                    pop_two(vec, a, b);
                    vec.Append(Mult(a, b));
                elsif substr = "/" then
                    pop_two(vec, a, b);
                    vec.Append(Div(a, b));
                else
                    begin
                        vec.Append(From_String(substr));
                    exception when E : Constraint_Error =>
                        raise Constraint_Error with
                            "invalid RPN equation, failed to parse token: " & substr;
                    end;
                end if;
            end;
    end loop;

    if vec.Length /= 1 then
        raise Constraint_Error with
            "invalid RPN equation, failed to evaluate to single value";
    end if;

    return vec.Last_Element;

end;

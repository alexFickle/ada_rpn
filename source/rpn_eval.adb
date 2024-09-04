with Ada.Strings.Fixed;
with Ada.Strings.Maps;
with Ada.Containers.Vectors;
use Ada;
use Ada.Containers;

function rpn_eval (str: String) return Integer is

    package Integer_Vectors is new
        Containers.Vectors(
            Index_Type   => Natural,
            Element_Type => Integer
        );
    use Integer_Vectors;

    procedure pop_two(vec: in out Vector; a: out Integer; b: out Integer) is
    begin
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
    end;

    pos : Natural := 1;
    first: Positive;
    last: Natural;
    vec: Vector;

    whitespace : constant Strings.Maps.Character_Set := Strings.Maps.To_Set (' ');

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
                a, b: Integer;
                substr: String := str (first .. last);
            begin
                if substr = "+" then
                    pop_two(vec, a, b);
                    vec.Append(a + b);
                elsif substr = "-" then
                    pop_two(vec, a, b);
                    vec.Append(a - b);
                elsif substr = "*" then
                    pop_two(vec, a, b);
                    vec.Append(a * b);
                elsif substr = "/" then
                    pop_two(vec, a, b);
                    vec.Append(a / b);
                else
                    begin
                        vec.Append(Integer'Value(substr));
                    exception when E : Constraint_Error =>
                        raise Constraint_Error with
                            "invalid RPN equation, failed to parse token: " & substr;
                    end;
                end if;
            end;
                pos := last + 1;
    end loop;

    if vec.Length /= 1 then
        raise Constraint_Error with
            "invalid RPN equation, failed to evaluate to single value";
    end if;

    return vec.Last_Element;

end;

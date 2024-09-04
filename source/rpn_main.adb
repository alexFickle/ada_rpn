with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

with rpn_eval;
with rpn_value; use rpn_value;

procedure rpn_main is
    result : Value;
begin
    Put_Line ("Enter equation or press Enter to quit");
    loop
        declare
            str : String := Get_Line;
        begin
            exit when str = "";
            result := rpn_eval (str);
            Put_Line (To_String (result));
        exception
            when e : Constraint_Error =>
                Put_Line ("error: " & Exception_Message (e));
        end;
    end loop;
end rpn_main;

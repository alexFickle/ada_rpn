with Ada.Text_IO;
with Ada.Exceptions; use Ada;

with rpn_eval;
with rpn_value; use rpn_value;

procedure rpn_main is
    result : Value;
begin
    Text_IO.Put_Line ("Enter equation or press Enter to quit");
    loop
        declare
            str : String := Text_IO.Get_Line;
        begin
            exit when str = "";
            result := rpn_eval (str);
            Text_IO.Put_Line (To_String (result));
        exception
            when e : Constraint_Error =>
                Text_IO.Put_Line
                   ("error: " & Exceptions.Exception_Message (e));
        end;
    end loop;
end rpn_main;

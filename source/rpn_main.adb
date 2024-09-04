with Ada.Text_IO;
with Ada.Exceptions;
use Ada;

with rpn_eval;

procedure rpn_main is
    result: Integer;
begin
    Text_IO.Put_Line("Enter equation or press Enter to quit");
    loop
        declare
            str: String := Text_IO.Get_Line;
        begin
            exit when str = "";
            result := rpn_eval(str);
            Text_IO.Put_Line(Integer'Image(result));
        exception when e : Constraint_Error =>
            Text_IO.Put_Line(Exceptions.Exception_Message(e));
        end;
    end loop;
end;

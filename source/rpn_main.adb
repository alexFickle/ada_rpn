with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Numerics;

with rpn_eval;
with rpn_value; use rpn_value;
with rpn_var_map;

procedure rpn_main is
    result  : Value;
    var_map : rpn_var_map.Map;
begin
    var_map.Include ("pi", To_Value (Ada.Numerics.Pi));
    var_map.Include ("e", To_Value (Ada.Numerics.e));

    Put_Line ("Enter equation or press Enter to quit");
    loop
        declare
            str : String := Get_Line;
        begin
            exit when str = "";
            result := rpn_eval (str, var_map);
            Put_Line (To_String (result));
        exception
            when e : Constraint_Error =>
                Put_Line ("error: " & Exception_Message (e));
        end;
    end loop;
end rpn_main;

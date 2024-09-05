with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics;

with handle_line;
with rpn_value; use rpn_value;
with rpn_var_map;

procedure rpn_main is
    var_map : rpn_var_map.Map;
begin
    var_map.Include ("pi", To_Value (Ada.Numerics.Pi));
    var_map.Include ("e", To_Value (Ada.Numerics.e));

    Put_Line ("Enter equation or press Enter to quit");
    loop
        declare
            str : constant String := Get_Line;
        begin
            exit when handle_line (str, var_map);
        end;
    end loop;
end rpn_main;

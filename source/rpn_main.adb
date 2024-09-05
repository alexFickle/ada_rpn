with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics;

with handle_line;
with rpn_value; use rpn_value;
with rpn_var_map;

procedure rpn_main is
    Var_Map : rpn_var_map.Map;
begin
    Var_Map.Include ("pi", To_Value (Ada.Numerics.Pi));
    Var_Map.Include ("e", To_Value (Ada.Numerics.e));

    Put_Line ("Enter equation or press Enter to quit");
    loop
        declare
            Str : constant String := Get_Line;
        begin
            exit when handle_line (Str, Var_Map);
        end;
    end loop;
end rpn_main;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics;

with Handle_Line;
with RPN_Value; use RPN_Value;
with Variable_Map;

procedure Main is
    Var_Map : Variable_Map.Map;
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
end Main;

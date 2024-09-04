with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Numerics;

with rpn_eval;
with rpn_value; use rpn_value;
with rpn_var_map;
with binding_parser;

procedure rpn_main is
    result  : Value;
    var_map : rpn_var_map.Map;
begin
    var_map.Include ("pi", To_Value (Ada.Numerics.Pi));
    var_map.Include ("e", To_Value (Ada.Numerics.e));

    Put_Line ("Enter equation or press Enter to quit");
    loop
        declare
            str          : constant String       := Get_Line;
            parse_result : binding_parser.Result := binding_parser.parse (str);
            name         : constant String       :=
               str (parse_result.name.s .. parse_result.name.e);
            expr         : constant String       :=
               str (parse_result.expr.s .. parse_result.expr.e);
        begin
            exit when expr = "";
            result := rpn_eval (expr, var_map);
            Put_Line (To_String (result));
            if name'Length = 0 then
                var_map.Include ("_", result);
            else
                var_map.Include (name, result);
            end if;
        exception
            when e : Constraint_Error =>
                Put_Line ("error: " & Exception_Message (e));
        end;
    end loop;
end rpn_main;

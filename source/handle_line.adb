with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

with rpn_value; use rpn_value;
with rpn_var_map;
with rpn_eval;
with binding_parser;

function handle_line
   (line : String; var_map : in out rpn_var_map.Map) return Boolean
is
    result       : Value;
    parse_result : binding_parser.Result := binding_parser.parse (line);
    name         : constant String       :=
       line (parse_result.name.s .. parse_result.name.e);
    expr         : constant String       :=
       line (parse_result.expr.s .. parse_result.expr.e);
begin
    if expr = "" then
        return True;
    end if;

    result := rpn_eval (expr, var_map);
    Put_Line (To_String (result));

    if name'Length = 0 then
        var_map.Include ("_", result);
    else
        var_map.Include (name, result);
    end if;
    return False;

exception
    when e : Constraint_Error =>
        Put_Line ("error: " & Exception_Message (e));
        return False;
end handle_line;

with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

with rpn_value; use rpn_value;
with rpn_var_map;
with rpn_eval;
with binding_parser;

function Handle_Line
   (Line : String; Var_Map : in out rpn_var_map.Map) return Boolean
is
    Result       : Value;
    Parse_Result : binding_parser.Result := binding_parser.Parse (Line);
    Name         : constant String       :=
       Line (Parse_Result.Name.S .. Parse_Result.Name.E);
    Expr         : constant String       :=
       Line (Parse_Result.Expr.S .. Parse_Result.Expr.E);
begin
    if Expr = "" then
        return True;
    end if;

    Result := rpn_eval (Expr, Var_Map);
    Put_Line (To_String (Result));

    if Name'Length = 0 then
        Var_Map.Include ("_", Result);
    else
        Var_Map.Include (Name, Result);
    end if;
    return False;

exception
    when E : Constraint_Error =>
        Put_Line ("error: " & Exception_Message (E));
        return False;
end Handle_Line;

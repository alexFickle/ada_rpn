with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

with Values; use Values;
with Variable_Map;
with Eval;
with Binding_Parser;

function Handle_Line
   (Line : String; Var_Map : in out Variable_Map.Map) return Boolean
is
    Result       : Value;
    Parse_Result : Binding_Parser.Result := Binding_Parser.Parse (Line);
    Name         : constant String       :=
       Line (Parse_Result.Name.S .. Parse_Result.Name.E);
    Expr         : constant String       :=
       Line (Parse_Result.Expr.S .. Parse_Result.Expr.E);
begin
    if Expr = "" then
        return True;
    end if;

    Result := Eval (Expr, Var_Map);
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

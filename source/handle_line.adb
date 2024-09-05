with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions;

with Values; use Values;
with Variable_Map;
with Eval;
with Binding_Parser;

function Handle_Line
   (Line : String; Var_Map : in out Variable_Map.Map) return Boolean
is
    Result : Value;
    Parsed : constant Binding_Parser.Result := Binding_Parser.Parse (Line);
begin
    if Parsed.Expr = "" then
        return True;
    end if;

    Result := Eval (Parsed.Expr, Var_Map);
    Put_Line (To_String (Result));

    if Parsed.Name'Length = 0 then
        Var_Map.Include ("_", Result);
    else
        Var_Map.Include (Parsed.Name, Result);
    end if;
    return False;

exception
    when E : Constraint_Error =>
        Put_Line ("error: " & Ada.Exceptions.Exception_Message (E));
        return False;
end Handle_Line;

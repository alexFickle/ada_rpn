package Binding_Parser is

    type Result (Name_Length : Natural; Expr_Length : Natural) is record
        Name : String (1 .. Name_Length);
        Expr : String (1 .. Expr_Length);
    end record;

    function Parse (Str : String) return Result;

end Binding_Parser;

package binding_parser is

    type String_Span is record
        S : Natural := 1;
        E : Natural := 0;
    end record;

    type Result is record
        Name : String_Span;
        Expr : String_Span;
    end record;

    function Parse (Str : String) return Result;

end binding_parser;

package binding_parser is

    type StringSpan is record
        s : Natural := 1;
        e : Natural := 0;
    end record;

    type Result is record
        name : StringSpan;
        expr : StringSpan;
    end record;

    function parse (str : String) return Result;

end binding_parser;

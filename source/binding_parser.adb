with Ada.Strings.Fixed;

package body binding_parser is

    procedure strip_space (str : String; span : in out StringSpan) is
        index : Natural := span.s;
    begin
        -- strip leading whitespace
        while index in span.s .. span.e loop
            exit when not (str (index) = ' ');
            index := index + 1;
        end loop;

        if not (index in span.s .. span.e) then
            -- was all whitespace, give an empty span
            span := (str'First, 0);
            return;
        end if;

        span.s := index;

        -- strip trailing whitespace
        index := span.e;
        while str (index) = ' ' loop
            index := index - 1;
        end loop;

        span.e := index;

    end strip_space;

    function parse (str : String) return Result is
        index      : Natural;
        assignment : constant String := ":=";
        name       : StringSpan;
        expr       : StringSpan;
    begin
        index :=
           Ada.Strings.Fixed.Index
              (Source => str, Pattern => assignment, From => 1);
        if index = 0 then
            expr := (str'First, str'Last);
            strip_space (str, expr);
        else
            name := (str'First, index - 1);
            expr := (index + 2, str'Last);
            strip_space (str, name);
            strip_space (str, expr);
        end if;

        return (name, expr);

    end parse;

end binding_parser;

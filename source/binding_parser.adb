with Ada.Strings.Fixed;

package body Binding_Parser is

    procedure Strip_Space (Str : String; Span : in out String_Span) is
        Index : Natural := Span.S;
    begin
        -- strip leading whitespace
        while Index in Span.S .. Span.E loop
            exit when not (Str (Index) = ' ');
            Index := Index + 1;
        end loop;

        if not (Index in Span.S .. Span.E) then
            -- was all whitespace, give an empty Span
            Span := (Str'First, 0);
            return;
        end if;

        Span.S := Index;

        -- strip trailing whitespace
        Index := Span.E;
        while Str (Index) = ' ' loop
            Index := Index - 1;
        end loop;

        Span.E := Index;

    end Strip_Space;

    function Parse (Str : String) return Result is
        Index : Natural;
        Name  : String_Span;
        Expr  : String_Span;
    begin
        Index :=
           Ada.Strings.Fixed.Index (Source => Str, Pattern => ":=", From => 1);
        if Index = 0 then
            Expr := (Str'First, Str'Last);
            Strip_Space (Str, Expr);
        else
            Name := (Str'First, Index - 1);
            Expr := (Index + 2, Str'Last);
            Strip_Space (Str, Name);
            Strip_Space (Str, Expr);
        end if;

        return (Name, Expr);

    end Parse;

end Binding_Parser;

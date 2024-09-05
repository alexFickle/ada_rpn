with Ada.Strings.Fixed;

package body Binding_Parser is

    type String_Span is record
        S : Natural := 1;
        E : Natural := 0;
    end record;

    function Length (Span : String_Span) return Natural is
    begin
        if Span.E < Span.S then
            return 0;
        else
            return (Span.E - Span.S) + 1;
        end if;
    end Length;

    function To_Sub_String (Str : String; Span : String_Span) return String is
    begin
        return Str (Span.S .. Span.E);
    end To_Sub_String;

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

        return
           (Length (Name), Length (Expr), To_Sub_String (Str, Name),
            To_Sub_String (Str, Expr));

    end Parse;

end Binding_Parser;

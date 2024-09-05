with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;

with rpn_value; use rpn_value;

package Variable_Map is new Ada.Containers.Indefinite_Hashed_Maps
 (Key_Type => String, Element_Type => Value, Hash => Ada.Strings.Hash,
  Equivalent_Keys => "=");

with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;

with Values; use Values;

package Variable_Map is new Ada.Containers.Indefinite_Hashed_Maps
  (Key_Type => String, Element_Type => Value, Hash => Ada.Strings.Hash,
   Equivalent_Keys => "=");

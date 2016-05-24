with Unsigned_Types, Dio192defs, IO_Ports, Turnouts;
use Unsigned_Types;
package body turnout_driver is

   Turnout_Drive_Array : array (Raildefs.Turnout_Idx range 0..2) of Unsigned_8;
   Tn_Drives : Unsigned_8;

   --------------
   -- Set_Turn --
   --------------

   procedure Set_Turn (T : in Raildefs.Turnout_Id) is
      use Raildefs, Dio192defs;
      Index      : Turnout_Idx := Turnout_Idx((T-1)/8);
      Value      : Unsigned_8;
      Turn_Pos   : Raildefs.Turnout_Id;
   begin
      Turn_Pos := T;
      if (T>16) then
         Turn_Pos := T-8;
      end if;

      if (T>8) then
         Turn_Pos := Turn_Pos-8;
      end if;
      Value := Unsigned_8(2**(Integer(Turn_Pos)-1));
      Tn_Drives := Turnout_Drive_Array(Index);
      Value := Value OR Tn_Drives;
      Turnout_Drive_Array(Index) := Value;
      IO_Ports.Write_IO_Port(Turnout_Drive_Addr(Index), Turnout_Drive_Array(Index));

      --new stuff
      Turnouts.Set_Turnout_State(T, Turned);
   end Set_Turn;

   ------------------
   -- Set_Straight --
   ------------------

   procedure Set_Straight (T : in Raildefs.Turnout_Id) is
      use Raildefs, Dio192defs;
      Index      : Turnout_Idx := Turnout_Idx((T-1)/8);
      Value      : Unsigned_8;
      Turn_Pos   : Raildefs.Turnout_Id;
   begin
      Turn_Pos := T;
      if (Turn_Pos>16) then
         Turn_Pos := Turn_Pos-8;
      end if;

      if (Turn_Pos>8) then
         Turn_Pos := Turn_Pos-8;
      end if;
      Value := NOT Unsigned_8(2**(Integer(Turn_Pos)-1));
      Tn_Drives := Turnout_Drive_Array(Index);
      Value := Value AND Tn_Drives;
      Turnout_Drive_Array(Index) := Value;
      IO_Ports.Write_IO_Port(Turnout_Drive_Addr(Index), Turnout_Drive_Array(Index));

      --new stuff
      Turnouts.Set_Turnout_State(T, Straight);
   end Set_Straight;

end turnout_driver;

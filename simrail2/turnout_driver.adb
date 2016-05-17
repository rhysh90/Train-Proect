with Unsigned_Types, Dio192defs, IO_Ports;
use Unsigned_Types;
package body turnout_driver is

   protected type Lock is
      entry Acquire;
      procedure Release;
   private
      Available : Boolean := True;
   end Lock;

   protected body Lock is
      entry Acquire when Available is
      begin
         Available := False;
      end Acquire;

      procedure Release is
      begin
         Available := True;
      end Release;
   end Lock;


   S : Lock;
   Turnout_Drive_Array : array (Raildefs.Turnout_Idx range 0..2) of Unsigned_8;
   Tn_Drives : Unsigned_8;

   --------------
   -- Set_Turn --
   --------------

   procedure Set_Turn (T : in Raildefs.Turnout_Id) is
      use Raildefs, Dio192defs;
      Index      : Turnout_Idx := Turnout_Idx((T-1)/8);
      Value      : Unsigned_8 := Unsigned_8(2**(Integer(T rem 8)-1));
   begin
      S.Acquire;
      Tn_Drives := Turnout_Drive_Array(Index);
      Value := Value OR Tn_Drives;
      Turnout_Drive_Array(Index) := Value;
      IO_Ports.Write_IO_Port(Turnout_Drive_Addr(Index), Turnout_Drive_Array(Index));
      S.Release;
   end Set_Turn;

   ------------------
   -- Set_Straight --
   ------------------

   procedure Set_Straight (T : in Raildefs.Turnout_Id) is
      use Raildefs, Dio192defs;
      Index      : Turnout_Idx := Turnout_Idx((T-1)/8);
      Value      : Unsigned_8 := NOT Unsigned_8(2**(Integer(T rem 8)-1));
   begin
      S.Acquire;
      Tn_Drives := Turnout_Drive_Array(Index);
      Value := Value AND Tn_Drives;
      Turnout_Drive_Array(Index) := Value;
      IO_Ports.Write_IO_Port(Turnout_Drive_Addr(Index), Turnout_Drive_Array(Index));
      S.Release;
   end Set_Straight;

end turnout_driver;

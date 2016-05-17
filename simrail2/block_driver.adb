with Unsigned_Types, Dio192defs, IO_Ports;
use Unsigned_Types;
package body block_driver is

   Block_Reg_Array : array (Raildefs.Block_Idx range 0..11) of Unsigned_8;
   Block_Regs : Unsigned_8;

   -------------
   -- Set_Cab --
   -------------

   procedure Set_Cab (B : in Raildefs.Block_Id; Cab : in Raildefs.Cab_Type) is
   use Raildefs, Dio192defs;
      Index      : Raildefs.Block_Idx := (B - 1) / 2; -- which register we are writing to
      Nibble     : Raildefs.Block_Idx := B mod 2;   -- which nibble we are writing to
      Value      : Unsigned_8 := Unsigned_8(Cab);
   begin
      Block_Regs := Block_Reg_Array(Index);
      --if nibble is 0 we are writing to the lo part, otherwise we write to hi part
      If Nibble /= 0 then
         Value := Unsigned_Types.Shift_Left(Value, 4);
         Block_Regs := Block_Regs AND 2#10001111#;
      Else
         Block_Regs := Block_Regs AND 2#11111000#;
      End if;
      Value := Value OR Block_Regs;
      Block_Reg_Array(Index) := Value;
      IO_Ports.Write_IO_Port(Block_Addr(Index), Block_Reg_Array(Index));
   end Set_Cab;

   ------------------
   -- Set_Polarity --
   ------------------

   procedure Set_Polarity (B   : in Raildefs.Block_Id; Pol : in Raildefs.Polarity_Type)is
  use Raildefs, Dio192defs;
      Index      : Raildefs.Block_Idx := (B - 1) / 2; -- which register we are writing to
      Nibble     : Raildefs.Block_Idx := B mod 2;   -- which nibble we are writing to
      Value      : Unsigned_8;
   begin
      Block_Regs := Block_Reg_Array(Index);
      --if nibble is 0 we are writing to the lo part, otherwise we write to hi part
      If Pol = Normal_Pol Then
         Value := 2#00000000#;
      Else
         Value := 2#00001000#;
      End if;
      If Nibble /= 0 then
         Value := Unsigned_Types.Shift_Left(Value, 4);
         Block_Regs := Block_Regs AND 2#01111111#;
      Else
         Block_Regs := Block_Regs AND 2#11110111#;
      End if;
      Value := Value OR Block_Regs;
      Block_Reg_Array(Index) := Value;
      IO_Ports.Write_IO_Port(Block_Addr(Index), Block_Reg_Array(Index));
   end Set_Polarity;

   --------------------------
   -- Set_Cab_And_Polarity --
   --------------------------

   procedure Set_Cab_And_Polarity (B : in Raildefs.Block_Id; Cab : in Raildefs.Cab_Type;
                                   Pol : in Raildefs.Polarity_Type) is
   begin
      Set_Cab(B, Cab);
      Set_Polarity(B, Pol);
   end Set_Cab_And_Polarity;

end block_driver;

with Unsigned_Types, Dio192defs, IO_Ports, Blocks, Raildefs;
use Unsigned_Types;

---------------------------- Block_Driver ------------------------
-- This package provides an interface to drive the block registers.
-- Given appropriate inputs into its procedures, block driver will then
-- perform a write to an IO port; working out the address and bits
-- to write which correspond to the input.
------------------------------------------------------------------
package body block_driver is

   Block_Reg_Array : array (Raildefs.Block_Idx range 0..11) of Unsigned_8;
   Block_Regs : Unsigned_8;

   -------- Set_Cab ---------------------------------------------
   -- Writes to the block registers to set a Cab on a Block,
   -- the address and the bits we write are determined from the input
   -- parameters
   --
   -- param B : in Block_Id	-The block to set a cab on
   -- param Cab : in Cab_Type	-The cab to set on the block
   --------------------------------------------------------------
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

      --new
      if Integer(Cab) = 0 then
         Blocks.Set_Block_State(B,false);
      else
         Blocks.Set_Block_State(B, true);
      end if;

   end Set_Cab;

   -------- Set_Polarity -----------------------------------------
   -- Writes to the block registers to set the polarity of a block,
   -- the address and the bits we write are determined from the input
   -- parameters
   --
   -- param B : in Block_Id		-The block to set a cab on
   -- param Pol : in Polarity_Type	-The polarity to set the block to
   ---------------------------------------------------------------
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

   -------- Set_Cab_And_Polarity ----------------------------------
   -- Calls Set_Cab and Set_Polarity procedures and passes them the
   -- parameters B, Cab, and Pol.
   --
   -- param B : in Block_Id		-The block to set a cab on
   -- param Cab : in Cab_Type           -The cab to set on the block
   -- param Pol : in Polarity_Type	-The polarity to set the block to
   ---------------------------------------------------------------
   procedure Set_Cab_And_Polarity (B : in Raildefs.Block_Id; Cab : in Raildefs.Cab_Type;
                                   Pol : in Raildefs.Polarity_Type) is
   begin
      Set_Cab(B, Cab);
      Set_Polarity(B, Pol);
   end Set_Cab_And_Polarity;

end block_driver;

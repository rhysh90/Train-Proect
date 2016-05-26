with Unsigned_Types, Das08defs, IO_Ports;
use Unsigned_Types;

---------------------------- Sound_Manager ------------------------
-- This package provides an interface to drive the sound registers.
-- Given appropriate inputs into its procedures, block driver will then
-- perform a write to an IO port; working out the bits
-- to write which correspond to the input.
------------------------------------------------------------------
package body Sound_Manager is

   Sound_Byte : Unsigned_8 := 2#00000000#; --start with all bells and horns off

   -------- Sound_Horn ---------------------------------------------
   -- Writes to the sound register to toggle a train's horn,
   -- bits we write are determined from the input parameters
   --
   -- param Cab : in Cab_Type	-The cab (train) to toggle horn on
   --------------------------------------------------------------
   procedure Sound_Horn (Cab : in Raildefs.Cab_Type) is
      use Das08defs;
      Value      : Unsigned_8 := Unsigned_8(2**((Integer(Cab)*2)-2));
   begin
      Sound_Byte := Sound_Byte XOR Value;
      IO_Ports.Write_IO_Port(Pa_Addr, Sound_Byte);
   end Sound_Horn;

   -------- Sound_Bell ---------------------------------------------
   -- Writes to the sound register to toggle a train's bell,
   -- bits we write are determined from the input parameters
   --
   -- param Cab : in Cab_Type	-The cab (train) to toggle bell on
   --------------------------------------------------------------
   procedure Sound_Bell (Cab : in Raildefs.Cab_Type) is
      use Das08defs;
      Value      : Unsigned_8 := Unsigned_8(2**((Integer(Cab)*2)-1));
   begin
      Sound_Byte := Sound_Byte XOR Value;
      IO_Ports.Write_IO_Port(Pa_Addr, Sound_Byte);
   end Sound_Bell;

end Sound_Manager;

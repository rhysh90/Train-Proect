with Unsigned_Types, Dda06defs, IO_Ports;
use Unsigned_Types;

---------------------------- Dac_Driver -------------------------
-- This package provides an interface to drive the dac register.
-- Given appropriate inputs into its procedure, dac driver will then
-- perform a write to an IO port; working out the address and bits
-- to write which correspond to the input.
------------------------------------------------------------------
package body dac_driver is

   -------- Set_Voltage ---------------------------------------------
   -- Writes to the dac registers to set a Voltage on a DAC,
   -- the bits we write are determined from the input
   -- parameter value
   --
   -- param D : in Dac_Id		-The DAC we are writing to
   -- param Value : in Unsigned_8	-The voltage value we are writing
   ------------------------------------------------------------------
   procedure Set_Voltage(D : in Raildefs.Dac_Id; Value : in Unsigned_Types.Unsigned_8) is
   use Dda06defs;
   Val_lo : Unsigned_8;
   Val_hi : Unsigned_8;
      begin
      Val_lo := Unsigned_Types.Shift_Left(Value, 3);
      Val_hi := Unsigned_Types.Shift_Right(Value, 5) OR 2#00001000#;

      Io_Ports.Write_Io_Port (Dalo_Addr(D),Val_lo);
      Io_Ports.Write_Io_Port (Dahi_Addr(D),Val_hi);
   end Set_Voltage;
end dac_driver;

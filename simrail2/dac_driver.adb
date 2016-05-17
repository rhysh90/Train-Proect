with Unsigned_Types, Dda06defs, IO_Ports;
use Unsigned_Types;
package body dac_driver is

   -----------------
   -- Set_Voltage --
   -----------------

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

with Unsigned_Types, Das08defs, IO_Ports;
use Unsigned_Types;

package body Sound_Manager is

   Sound_Byte : Unsigned_8 := 2#00000000#; --start with all bells and horns off

   procedure Sound_Horn (Cab : in Raildefs.Cab_Type) is
      use Das08defs;
      Value      : Unsigned_8 := Unsigned_8(2**((Integer(Cab)*2)-2));
   begin
      Sound_Byte := Sound_Byte XOR Value;
      IO_Ports.Write_IO_Port(Pa_Addr, Sound_Byte);
   end Sound_Horn;

   procedure Sound_Bell (Cab : in Raildefs.Cab_Type) is
      use Das08defs;
      Value      : Unsigned_8 := Unsigned_8(2**((Integer(Cab)*2)-1));
   begin
      Sound_Byte := Sound_Byte XOR Value;
      IO_Ports.Write_IO_Port(Pa_Addr, Sound_Byte);
   end Sound_Bell;

end Sound_Manager;

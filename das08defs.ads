-- Das08defs
-- This Package contains the definitions of register addresses
-- and bit assignments for the DAS08/Jr Card

-- Author : Matthew Hannah, Rhys Hill

--
with Unsigned_Types;

package Das08defs is

   use Unsigned_Types;

   ----- Register I/O Addresses. ---------------------------------------------

   Base_Address : constant := 16#310#;
   Adlo_Addr	: constant := Base_Address + 0;
   Adhi_Addr    : constant := Base_Address + 1;
   Cs_Addr	: constant := Base_Address + 2;
   Pa_Addr	: constant := Base_Address + 3;

end Das08defs;

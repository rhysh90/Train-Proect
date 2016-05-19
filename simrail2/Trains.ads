-- Train : an representation of a train within the simulator
-- It contains the trains desired route and its current position
-- Rhys Hill, Matt Hannah, Swinburne Univ Tech. orig 19-May-16
with Projdefs, Ada.Text_Io, Exec_Load, Ada.Real_Time, Ada.Float_Text_IO;
use Projdefs, Ada.Real_Time;
package Trains is
	type Train is tagged
		record
                  Last_Sensor_Hit : Integer;
      		end record;

   procedure update_Last_Hit(Value: in Integer);

end Trains;

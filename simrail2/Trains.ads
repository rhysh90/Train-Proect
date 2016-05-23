with Projdefs;
use Projdefs;

package Trains is

   type Train is tagged private;

   type Route is array(1..20) of Request_Type;

   function Make (Sensor_Front : Integer; Sensor_Back : Integer) return Train;

   function Get_Sensor_Front ( T : in Train ) return Integer;

   function Get_Sensor_Back ( T : in Train ) return Integer;

   procedure Set_Sensor_Front ( T : out Train;  Sensor : Integer);

   procedure Set_Sensor_Back ( T : out Train;  Sensor : Integer);

   procedure Hit_Sensor ( T : out Train; Sensor_Hit : Integer);

   procedure Set_Route ( T : out Train; Sensors : Route);


private
   type Train is tagged
      record
         Sensor_Front : Integer;
         Sensor_Back  : Integer;
         Sensors_In_Route : Route;
         Sensor_Next : Integer;
         Route_Marker : Integer;
      end record;

end Trains;



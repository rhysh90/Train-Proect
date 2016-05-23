with Projdefs;
use Projdefs;

package Trains is

   type Train is tagged private;

   type Train_Access is access Train;

   type Route is array(1..20) of Request_Type;

   function Make (Sensor_Front : Integer; Sensor_Back : Integer) return Train_Access;

   function Get_Sensor_Front ( T : Train ) return Integer;

   function Get_Sensor_Back ( T : Train ) return Integer;

   procedure Set_Sensor_Front ( T : out Train;  Sensor : Integer);

   procedure Set_Sensor_Back ( T : out Train;  Sensor : Integer);

   procedure Set_Route ( T : out Train; Sensors : Route);

   procedure Hit_Sensor ( T : in out Train; Sensor_Hit : Integer);

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



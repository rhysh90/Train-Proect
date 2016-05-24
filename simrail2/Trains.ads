with Projdefs;
use Projdefs;

generic package Trains is

   type Route is array(1..20) of Request_Type;

   procedure Set_Route ( Sensors : Route);

   procedure Hit_Sensor ( Sensor_Hit : Integer);

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



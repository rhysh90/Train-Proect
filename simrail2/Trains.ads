with Projdefs, Raildefs;
use Projdefs, Raildefs;

generic package Trains is

   type Route is array(1..35) of Request_Type;

   procedure Set_Route ( Sensors : Route);

   procedure Set_Cab ( Cab : Cab_Type );

   procedure Set_Heading ( Heading : Polarity_Type);

   procedure Hit_Sensor ( Sensor_Hit : Integer);

private
   type Train is tagged
      record
         Sensor_Front : Integer;
         Sensor_Back  : Integer;
         Sensors_In_Route : Route;
         Sensor_Next : Integer;
         Route_Marker : Integer;
         Heading : Polarity_Type;
         Cab : Cab_Type;
      end record;

end Trains;



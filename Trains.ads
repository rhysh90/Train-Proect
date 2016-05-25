with Projdefs, Raildefs;
use Projdefs, Raildefs;

generic package Trains is

   type Route is array(1..35) of Request_Type;

   procedure Set_Route ( Sensors : Route; Sensors_Reverse : Route);

   procedure Set_Cab ( Cab : Cab_Type );

   procedure Set_Heading ( Heading : Polarity_Type);

   procedure Set_Facing ( Facing : Polarity_Type);

   function Get_Heading return POlarity_Type;

   procedure Hit_Sensor ( Sensor_Hit : Integer);

   procedure Next_Route_Sensor ( Sensor : Integer);

   procedure Process_Special_State ( Sensor : Integer );

   procedure Wait_For_Block (Block : in Integer);

   procedure Process_Front_Hit (Sensor : in Integer);

   procedure Process_Back_Hit (Sensor : in Integer);

private
   type Train is tagged
      record
         Sensor_Front : Integer;
         Sensor_Back  : Integer;
         On_Sensor_Front : Integer;
         On_Sensor_Back : Integer;
         Sensors_In_Route : Route;
         Sensors_In_Route_Reverse : Route;
         Sensor_Next : Integer;
         Route_Marker : Integer;
         Route_Marker_Back : Integer;
         Heading : Polarity_Type;
         Facing : Polarity_Type;
         Cab : Cab_Type;
      end record;

end Trains;



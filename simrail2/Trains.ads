package Trains is

   type Train is tagged private;

   function Make (Sensor_Front : Integer; Sensor_Back : Integer) return Train;

   function Get_Sensor_Front ( T : in Train ) return Integer;

   function Get_Sensor_Back ( T : in Train ) return Integer;

private
   type Train is tagged
      record
         Sensor_Front : Integer;
         Sensor_Back  : Integer;
      end record;

end Trains;



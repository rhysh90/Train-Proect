package Trains is

   type Train is tagged private;

   function Make (Sensor_Front : Integer; Sensor_Back : Integer) return Train;

private
   type Train is tagged
      record
         Sensor_Front : Integer;
         Sensor_Back  : Integer;
      end record;

end Trains;

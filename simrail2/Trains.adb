package body Trains is

   ----------
   -- Make --
   ----------

   function Make
     (Sensor_Front : Integer;
      Sensor_Back : Integer)
      return Train
   is
      T : Train;
   begin
      T.Sensor_Front := Sensor_Front;
      T.Sensor_Back := Sensor_Back;
      return T;
   end Make;

end Trains;

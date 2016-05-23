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

   ----------------------
   -- Get Sensor Front --
   ----------------------

   function Get_Sensor_Front ( T : Train ) return Integer is
   begin
      return T.Sensor_Front;
   end Get_Sensor_Front;

   ---------------------
   -- Get Sensor Back --
   ---------------------

   function Get_Sensor_Back ( T : Train ) return Integer is
   begin
      return T.Sensor_Back;
   end Get_Sensor_Back;

end Trains;

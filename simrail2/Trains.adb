package body Trains is

   protected type Lock is
      entry Acquire;
      procedure Release;
   private
      Available : Boolean := True;
   end Lock;

   protected body Lock is
      entry Acquire when Available is
      begin
         Available := False;
      end Acquire;

      procedure Release is
      begin
         Available := True;
      end Release;
   end Lock;

   S : Lock;

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
   value : Integer;
   begin
      S.Acquire;
      value := T.Sensor_Front;
      S.Release;
      return value;
   end Get_Sensor_Front;

   ---------------------
   -- Get Sensor Back --
   ---------------------

   function Get_Sensor_Back ( T : Train ) return Integer is
   value : Integer;
   begin
      S.Acquire;
      value := T.Sensor_Back;
      S.Release;
      return value;
   end Get_Sensor_Back;

   ---------------------
   --   Hit Sensor    --
   ---------------------

   function Hit_Sensor ( T : Train; Sensor_Hit : Integer) return Boolean is
   begin
      -- work out whether front or back and set
      return true;
   end Hit_Sensor;

end Trains;

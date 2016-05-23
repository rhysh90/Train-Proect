with Ada.Integer_Text_IO, Ada.Text_IO;

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
   -- Set Sensor Back --
   ---------------------

   procedure Set_Sensor_Back ( T : out Train;  Sensor : Integer) is
   begin
      S.Acquire;
      T.Sensor_Back := Sensor;
      S.Release;
   end Set_Sensor_Back;

   ---------------------
   -- Set Sensor Back --
   ---------------------

   procedure Set_Sensor_Front ( T : out Train;  Sensor : Integer) is
   begin
      S.Acquire;
      T.Sensor_Front := Sensor;
      S.Release;
   end Set_Sensor_Front;

   ---------------------
   --   Hit Sensor    --
   ---------------------

   procedure Hit_Sensor ( T : in out Train; Sensor_Hit : Integer) is
   begin
      -- work out whether front or back and set
      S.Acquire;
      --Ada.Integer_Text_IO.Put(T.Sensors_In_Route(T.Route_Marker));
      Ada.Integer_Text_IO.Put(T.Route_Marker);

      --if (T.Sensors_In_Route(T.Route_Marker) = Sensor_Hit) then
         T.Sensor_Front := Sensor_Hit;
         T.Route_Marker := T.Route_Marker + 1;
         Ada.Text_IO.Put_Line("Train got Sensor Event");
       -- end if;

     S.Release;

   end Hit_Sensor;

   ---------------------
   --    Set Route    --
   ---------------------

   procedure Set_Route ( T : out Train; Sensors : Route) is
   begin
      S.Acquire;
      T.Sensors_In_Route := Sensors;
      T.Route_Marker := 1;
      S.Release;

   end Set_Route;

end Trains;

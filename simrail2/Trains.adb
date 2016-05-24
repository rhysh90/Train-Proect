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

   BuffSize : constant := 3;

   type Circular_Buffer is array (1..BuffSize) of Request_Type;

   protected Buffer is

      entry Add(Request : in Request_Type);
      entry Remove(Request : out Request_Type);
   private
      Item : Request_Type;

      --Circular Buffer
      Items : Circular_Buffer;
      Iin : Integer := 1;
      Jout : Integer := 1;
      Count : Natural := 0;

   end Buffer;

   task Worker_Thread;

   protected body Buffer is

      entry Add(Request : in Request_Type) when Count < BuffSize is
      begin
         Items(Iin) := Request;
         Iin := Iin mod BuffSize + 1;
         Count := Count + 1;
      end Add;

      entry Remove(Request : out Request_Type) when Count > 0 is
      begin
         Request := Items(jout);
         Jout := Jout mod BuffSize + 1;
         Count := Count - 1;
      end Remove;
   end Buffer;

   ----------
   -- Make --
   ----------

   function Make
     (Sensor_Front : Integer; Sensor_Back : Integer) return Train_Access is
      T : Train_Access := new Train;
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
      --S.Acquire;
      --Ada.Integer_Text_IO.Put(T.Sensors_In_Route(T.Route_Marker));
      --T.Route_Marker := T.Route_Marker + 1;
      --Ada.Integer_Text_IO.Put(T.Sensor_Front);

      --if (T.Sensors_In_Route(T.Route_Marker) = Sensor_Hit) then
      --   T.Sensor_Front := Sensor_Hit;
      --   T.Route_Marker := T.Route_Marker + 1;
      --   Ada.Text_IO.Put_Line("");
      --   Ada.Text_IO.Put_Line("Train got Sensor Event");
      --   Ada.Text_IO.Put_Line("");
      --end if;

      --S.Release;
      Buffer.Add(Sensor_Hit);

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

   procedure Process_Sensor_Event(Request : in Request_Type) is
   begin
      --TODO
      -- check is this mine,
      -- update route marker
      -- carry out claiming blocks and turnouts
      Ada.Text_Io.Put_Line(" Sensor " & Request'Img & " was hit");
   end Process_Sensor_Event;

   task body Worker_Thread is
      Req : Request_Type ;
   begin
      loop
         Buffer.Remove(Req);
         Process_Sensor_Event(Req);
      end loop;
   end Worker_Thread;

end Trains;

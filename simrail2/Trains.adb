with Ada.Integer_Text_IO, Ada.Text_IO, Turnouts, raildefs; use raildefs, Turnouts;

package body Trains is

   Train_Info : Train;

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

   ---------------------
   --   Hit Sensor    --
   ---------------------

   procedure Hit_Sensor ( Sensor_Hit : Integer) is
   begin
       Buffer.Add(Sensor_Hit);
   end Hit_Sensor;

   ---------------------
   --    Set Route    --
   ---------------------

   procedure Set_Route ( Sensors : Route) is
   begin
      S.Acquire;
      Train_Info.Sensors_In_Route := Sensors;
      Train_Info.Route_Marker := 1;
      S.Release;
   end Set_Route;

   procedure Process_Sensor_Event(Request : in Request_Type) is

      --TEST
      state : Turnout_Pos;

   begin
      --TODO
      -- check is this mine,
      -- update route marker
      -- carry out claiming blocks and turnouts
      if (Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = Request) then
         Ada.Text_Io.Put_Line(" Sensor " & Request'Img & " was hit");
         Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
         state := Turnouts.Get_Turnout_State(Get_Turnout(Request));
         if (state = Straight) then
            Ada.Text_IO.Put_Line("TURNOUT IS STRAIGHT");
         else
            Ada.Text_IO.Put_Line("TURNOUT IS TURNED");
         end if;

      end if;
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

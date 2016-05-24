with Ada.Integer_Text_IO, Ada.Text_IO, Turnouts, raildefs, Blocks, Turnout_Driver, Block_Driver;
use raildefs, Turnouts, Blocks;

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
      Train_Info.Route_Marker_Back := 1;
      Train_Info.On_Sensor := 0;
      S.Release;
   end Set_Route;

   ---------------------
   --    Set Cab      --
   ---------------------

   procedure Set_Cab ( Cab : Cab_Type) is
   begin
      S.Acquire;
      Train_Info.Cab := Cab;
      S.Release;
   end Set_Cab;

   -----------------------
   --    Set Heading    --
   -----------------------

   procedure Set_Heading ( Heading : Polarity_Type ) is
   begin
      S.Acquire;
      Train_Info.Heading := Heading;
      S.Release;
   end Set_Heading;

   --------------------------------
   --    Process_Sensor_Event    --
   --------------------------------

   procedure Process_Sensor_Event(Request : in Request_Type) is

      state : Turnout_Pos;
   begin
      S.Acquire;
      if (Train_Info.On_Sensor = Request) then
         Train_Info.On_Sensor := 0;

      --Check if sensor hit was before a turnout and if that turnout is a part of your route
      elsif (Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = Request) then
         Train_Info.On_Sensor := Request;
         Ada.Text_Io.Put_Line(" Sensor " & Request'Img & " was hit by the FRONT");
         Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
         if (Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = 1) then
            Train_Info.Route_Marker := 1;
         elsif (Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = 2) then
               --Straight the next turnout
	       state := Turnouts.Get_Turnout_State(Get_Turnout(Request));
               if (state = Turned) then
                  Turnout_Driver.Set_Straight(Get_Turnout(Request));
                  Ada.Text_IO.Put_Line("TURNOUT IS NOW STRAIGHT do some timing here, stop the train for abit");
               else
                  Ada.Text_IO.Put_Line("TURNOUT IS ALREADY STRAIGHT");
               end if;
               Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
         elsif (Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = 3) then
               --Turn the next turnout
		state := Turnouts.Get_Turnout_State(Get_Turnout(Request));
                if (state = Turned) then
                     Turnout_Driver.Set_Turn(Get_Turnout(Request));
                     Ada.Text_IO.Put_Line("TURNOUT IS NOW TURNED do some timing here, stop the train for abit");
                else
                     Ada.Text_IO.Put_Line("TURNOUT IS ALREADY TURNED");
                end if;
                Train_Info.Route_Marker := Train_Info.Route_Marker + 1;

         end if;

         -- check if we need to acquire blocks, if so grab them depending on sensor and turnout
         if Train_Info.Heading = Normal_Pol then
            case Request is
               when 35 => --we already own block 12
                  --grab block 13 if turnout 12 is straight
                  if Turnouts.Get_Turnout_State(12) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(13, Train_Info.Cab, Train_Info.Heading);
                  --grab block 22 if turnout 12 is turned
                  elsif Turnouts.Get_Turnout_State(12) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(22, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 37 => --we already own block 13
                  --grab block 14 if turnout 13 is straight
	          if Turnouts.Get_Turnout_State(13) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(14, Train_Info.Cab, Train_Info.Heading);
                  --grab block 7 if turnout 13 is turned
                  elsif Turnouts.Get_Turnout_State(13) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(7, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 39 => --we already own block 14
                  --grab block 15
                  Block_Driver.Set_Cab_And_Polarity(15, Train_Info.Cab, Train_Info.Heading);

               when 41 => --we already own block 15
                  --grab block 16
                  Block_Driver.Set_Cab_And_Polarity(16, Train_Info.Cab, Train_Info.Heading);

               when 45 => --we already own block 16
                  --grab block 17 if turnout 16 is straight
                  if Turnouts.Get_Turnout_State(16) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(17, Train_Info.Cab, Train_Info.Heading);
                  --grab block 22 if turnout 16 is turned
                  elsif Turnouts.Get_Turnout_State(16) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(22, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 47 => --we already own block 17
                  --grab block 18 if turnout 17 is straight
                  if Turnouts.Get_Turnout_State(17) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(18, Train_Info.Cab, Train_Info.Heading);
                  --grab block 10 if turnout 17 is turned
                  elsif Turnouts.Get_Turnout_State(17) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(10, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 49 => --we already own block 18
                  --grab block 19
                  Block_Driver.Set_Cab_And_Polarity(19, Train_Info.Cab, Train_Info.Heading);

               when 19 => --we already own block 19
                  --grab block 12
                  Block_Driver.Set_Cab_And_Polarity(12, Train_Info.Cab, Train_Info.Heading);

               when others =>
                  null;
            end case;
         else
            --Reverse POlarity
            null;
         end if;

      elsif (Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back) = Request) then
         Train_Info.On_Sensor := Request;
         Ada.Text_Io.Put_Line(" Sensor " & Request'Img & " was hit by the BACK");
         Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
         if (Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back) = 1) then
            Train_Info.Route_Marker_Back := 1;
	 elsif (Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back) = 2) then
            Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
         elsif (Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back) = 3) then
            Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
         end if;
      end if;

      S.Release;
   end Process_Sensor_Event;

   -------------------
   -- Worker_Thread --
   -------------------

   task body Worker_Thread is
      Req : Request_Type ;
   begin
      loop
         Buffer.Remove(Req);
         Process_Sensor_Event(Req);
      end loop;
   end Worker_Thread;

end Trains;

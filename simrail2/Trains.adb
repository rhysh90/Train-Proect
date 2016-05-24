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
                     --CHECK THE BLOCK UR GOING TO MAKE SURE IT IS NOT OWNED
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
            case Request is
               when 23 => --we already own block 12
                  --grab block 19
                  Block_Driver.Set_Cab_And_Polarity(19, Train_Info.Cab, Train_Info.Heading);

               when 51 => --we already own block 19
                  --grab block 18 if turnout 19 is straight
                  if Turnouts.Get_Turnout_State(19) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(18, Train_Info.Cab, Train_Info.Heading);
                  --grab block 23 if turnout 19 is turned
                  elsif Turnouts.Get_Turnout_State(19) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(23, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 49 => --we already own block 18
                  --grab block 17 if turnout 18 is straight
                  if Turnouts.Get_Turnout_State(19) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(17, Train_Info.Cab, Train_Info.Heading);
                  --grab block 9 if turnout 18 is turned
                  elsif Turnouts.Get_Turnout_State(19) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(9, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 47 => --we already own block 17
                  --grab block 16
                  Block_Driver.Set_Cab_And_Polarity(16, Train_Info.Cab, Train_Info.Heading);

               when 43 => --we already own block 16
                  --grab block 15
                  Block_Driver.Set_Cab_And_Polarity(15, Train_Info.Cab, Train_Info.Heading);

               when 41 => --we already own block 15
                  --grab block 23 if turnout 15 is straight
                  if Turnouts.Get_Turnout_State(15) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(23, Train_Info.Cab, Train_Info.Heading);
                  --grab block 14 if turnout 15 is turned
                  elsif Turnouts.Get_Turnout_State(15) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(14, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 39 => --we already own block 14
                  --grab block 13
                  Block_Driver.Set_Cab_And_Polarity(13, Train_Info.Cab, Train_Info.Heading);

               when 37 => --we already own block 13
                  --grab block 12
                  Block_Driver.Set_Cab_And_Polarity(12, Train_Info.Cab, Train_Info.Heading);

               when others =>
                  null;

            end case;
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

          -- check if we need to acquire blocks, if so grab them depending on sensor and turnout
         if Train_Info.Heading = Normal_Pol then
            case Request is
               when 37 => --we owned block 12, turn it off
                  Block_Driver.Set_Cab_And_Polarity(12, 0, Train_Info.Heading);
               when 39 =>
                  --if turnout 14 is straight we owned block 13
	          if Turnouts.Get_Turnout_State(14) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(13, 0, Train_Info.Heading);
                  --if turnout 14 is turned we owned block 6
                  elsif Turnouts.Get_Turnout_State(14) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(6, 0, Train_Info.Heading);
                  end if;

               when 41 =>
                  --if turnout 15 is straight we owned block 14
	          if Turnouts.Get_Turnout_State(15) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(14, 0, Train_Info.Heading);
                  --if turnout 15 is turned we owned block 23
                  elsif Turnouts.Get_Turnout_State(15) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(23, 0, Train_Info.Heading);
                  end if;

               when 43 => --we owned block 15 turn it off
                  Block_Driver.Set_Cab_And_Polarity(15, 0, Train_Info.Heading);

               when 48 | 47 => --we owned block 16 turn it off
                  Block_Driver.Set_Cab_And_Polarity(16, 0, Train_Info.Heading);

               when 49 =>
                  --if turnout 18 is straight we owned block 17
	          if Turnouts.Get_Turnout_State(18) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(17, 0, Train_Info.Heading);
                  --if turnout 18 is turned we owned block 9
                  elsif Turnouts.Get_Turnout_State(18) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(9, 0, Train_Info.Heading);
                  end if;

               when 51 =>
                  --if turnout 19 is straight we owned block 18
	          if Turnouts.Get_Turnout_State(15) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(18, 0, Train_Info.Heading);
                  --if turnout 19 is turned we owned block 23
                  elsif Turnouts.Get_Turnout_State(15) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(23, 0, Train_Info.Heading);
                  end if;

               when 21 => --we owned block 19 turn it off
                    Block_Driver.Set_Cab_And_Polarity(19, 0, Train_Info.Heading);

               when others =>
                  null;
            end case;
         else
            --Reverse POlarity
            null;
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

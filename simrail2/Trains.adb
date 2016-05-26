with Ada.Integer_Text_IO, Ada.Text_IO, Turnouts, raildefs, Blocks, Turnout_Driver, Block_Driver;
with dac_driver, Exec_Load, Unsigned_Types;
use raildefs, Turnouts, Blocks, Unsigned_Types;

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

   procedure Set_Route ( Sensors : Route; Sensors_Reverse : Route) is
   begin
      S.Acquire;
      Train_Info.Sensors_In_Route := Sensors;
      Train_Info.Sensors_In_Route_Reverse := Sensors_Reverse;
      Train_Info.Route_Marker := 1;
      Train_Info.Route_Marker_Back := 1;
      Train_Info.On_Sensor_Front := 0;
      Train_Info.On_Sensor_Back := 0;
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

   -----------------------
   --    Set Facing     --
   -----------------------

   procedure Set_Facing ( Facing : Polarity_Type ) is
   begin
      S.Acquire;
      Train_Info.Facing := Facing;
      S.Release;
   end Set_Facing;

   -----------------------
   --    Get Heading    --
   -----------------------

   function Get_Heading return POlarity_Type is
      Heading : Polarity_Type;
   begin
      S.Acquire;
      Heading := Train_Info.Heading;
      S.Release;
      return Heading;
   end Get_Heading;

   --------------------------------
   --    Process_Sensor_Event    --
   --------------------------------

   procedure Process_Sensor_Event(Request : in Request_Type) is
   begin
      S.Acquire;
      if (Train_Info.On_Sensor_Front = Request) then
         Train_Info.On_Sensor_Front := 0;
         Ada.Text_IO.Put_Line("OFF SENSOR FRONT");
         Ada.Text_IO.Put_Line("");
      elsif (Train_Info.On_Sensor_Back = Request) then
         Train_Info.On_Sensor_Back := 0;
         Ada.Text_IO.Put_Line("OFF SENSOR BACK");
         Ada.Text_IO.Put_Line("");
      else
         Next_Route_Sensor(Integer(Request));
      end if;
      S.Release;
   end Process_Sensor_Event;


   --ONLY SHOULD GET CALLED WHEN A LOCK HAS ALREADY BEEN ACQUIRED--
   procedure Next_Route_Sensor ( Sensor : Integer ) is
   begin
      if Train_Info.Heading = Normal_Pol then
         if Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = Sensor then --LEADING SENSOR HIT
            Ada.Text_IO.Put_Line("");
            Ada.Text_IO.Put_Line("ON SENSOR FRONT");
            Train_Info.On_Sensor_Front := Sensor;
            Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
            Process_Special_State(Sensor);
            --FRONT SENSOR HIT
            Process_Front_Hit(Sensor);
            Ada.Integer_Text_IO.Put(Train_Info.Sensors_In_Route(Train_Info.Route_Marker));
            Ada.Text_IO.Put_Line(" IS NEXT FRONT SENSOR");
         elsif Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back) = Sensor then --TRAILING SENSOR HIT
            Ada.Text_IO.Put_Line("");
            Ada.Text_IO.Put_Line("ON SENSOR BACK");
            Train_Info.On_Sensor_Back := Sensor;
            Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
            --CHECK IF SPECIAL STATE NEXT IF SO DISREGARD
            if Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back) = 2 then
               Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
            elsif Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back) = 3 then
               Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
            elsif Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back) = 1 then
               Train_Info.Route_Marker_Back := 1;
            end if;
            --BACK SENSOR HIT
            Process_Back_Hit(Sensor);
            Ada.Integer_Text_IO.Put(Train_Info.Sensors_In_Route(Train_Info.Route_Marker_Back));
            Ada.Text_IO.Put_Line(" IS NEXT BACK SENSOR");
         end if;
      else
         if Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker_Back) = Sensor then --LEADING SENSOR HIT
            Ada.Text_IO.Put_Line("");
            Ada.Text_IO.Put_Line("ON SENSOR BACK");
            Train_Info.On_Sensor_Back := Sensor;
            Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
            Process_Special_State(Sensor);
            --BACK SENSOR HIT
            Process_Back_Hit(Sensor);
            Ada.Integer_Text_IO.Put(Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker_Back));
            Ada.Text_IO.Put_Line(" IS NEXT BACK SENSOR");
         elsif Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker) = Sensor then --TRAILING SENSOR HIT
            Ada.Text_IO.Put_Line("");
            Ada.Text_IO.Put_Line("ON SENSOR FRONT");
            Train_Info.On_Sensor_Front := Sensor;
            Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
            --CHECK IF SPECIAL STATE NEXT IF SO DISREGARD
            if Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker) = 2 then
               Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
            elsif Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker) = 3 then
               Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
            elsif Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker) = 1 then
               Train_Info.Route_Marker := 1;
            end if;
            --FRONT SENSOR HIT
            Process_Front_Hit(Sensor);
            Ada.Integer_Text_IO.Put(Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker));
            Ada.Text_IO.Put_Line(" IS NEXT FRONT SENSOR");
         end if;
      end if;
   end Next_Route_Sensor;


   procedure Process_Special_State ( Sensor : Integer ) is
      state : Turnout_Pos;
   begin
      if (Train_Info.Heading = Normal_Pol) then
         if (Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = 1) then
            Train_Info.Route_Marker := 1;
         elsif (Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = 2) then
            --Straight the next turnout
	    state := Turnouts.Get_Turnout_State(Get_Turnout(Sensor, Train_Info.Heading, Train_Info.Facing));
            if (state = Turned) then
               Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), 2#00000000#);
               Turnouts.Set_Turnout_State(Get_Turnout(Sensor, Train_Info.Heading, Train_Info.Facing), Straight);
               Ada.Text_IO.Put_Line("WAIT FOR TURNOUT TO BE CHANGED");
                  Exec_Load.Eat(6.0); --Wait for set time; the time taken to change a turn
                  Ada.Text_IO.Put_Line("TURNOUT IS NOW STRAIGHT");
                  Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), Unsigned_8((Character'pos ('9') - 48) * 27));
               --NEW CODE--
            end if;
            Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
         elsif (Train_Info.Sensors_In_Route(Train_Info.Route_Marker) = 3) then
            --Turn the next turnout
   	    state := Turnouts.Get_Turnout_State(Get_Turnout(Sensor, Train_Info.Heading, Train_Info.Facing));
            if (state = Straight) then
              --NEW CODE--
               Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), 2#00000000#);
               Turnouts.Set_Turnout_State(Get_Turnout(Sensor, Train_Info.Heading, Train_Info.Facing), Turned);
               Ada.Text_IO.Put_Line("WAIT FOR TURNOUT TO BE CHANGED");
               Exec_Load.Eat(6.0); --Wait for set time; the time taken to change a turn
               Ada.Text_IO.Put_Line("TURNOUT IS NOW TURNED");
               Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), Unsigned_8((Character'pos ('9') - 48) * 27));
                --NEW CODE--
            end if;
            Train_Info.Route_Marker := Train_Info.Route_Marker + 1;
         end if;
      else
         if (Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker_Back) = 1) then
            Train_Info.Route_Marker_Back := 1;
         elsif (Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker_Back) = 2) then
            --Straight the next turnout
	    state := Turnouts.Get_Turnout_State(Get_Turnout(Sensor, Train_Info.Heading, Train_Info.Facing));
            if (state = Turned) then
               --NEW CODE--
                  Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), 2#00000000#);
               --Turnout_Driver.Set_Straight(Get_Turnout(Request));
               Turnouts.Set_Turnout_State(Get_Turnout(Sensor, Train_Info.Heading, Train_Info.Facing), Straight);
               Ada.Text_IO.Put_Line("WAIT FOR TURNOUT TO BE CHANGED");
                  Exec_Load.Eat(6.0); --Wait for set time; the time taken to change a turn
                  Ada.Text_IO.Put_Line("TURNOUT IS NOW STRAIGHT");
                  Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), Unsigned_8((Character'pos ('9') - 48) * 27));
               --NEW CODE--
            end if;
            Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
         elsif (Train_Info.Sensors_In_Route_Reverse(Train_Info.Route_Marker_Back) = 3) then
            --Turn the next turnout
   	    state := Turnouts.Get_Turnout_State(Get_Turnout(Sensor, Train_Info.Heading, Train_Info.Facing));
            if (state = Straight) then
              --NEW CODE--
                  Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), 2#00000000#);
               --Turnout_Driver.Set_Turn(Get_Turnout(Request));
               Turnouts.Set_Turnout_State(Get_Turnout(Sensor, Train_Info.Heading, Train_Info.Facing), Turned);
               Ada.Text_IO.Put_Line("WAIT FOR TURNOUT TO BE CHANGED");
               Exec_Load.Eat(6.0); --Wait for set time; the time taken to change a turn
               Ada.Text_IO.Put_Line("TURNOUT IS NOW TURNED");
               Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), Unsigned_8((Character'pos ('9') - 48) * 27));
                --NEW CODE--
            end if;
            Train_Info.Route_Marker_Back := Train_Info.Route_Marker_Back + 1;
         end if;
      end if;

   end Process_Special_State;

   procedure Wait_For_Block (Block : in Integer) is
      Block_Free : Boolean;
   begin
      Block_Free := Blocks.Get_Block_State(Block_Idx(Block));

      while (Block_Free) loop
         Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), 2#00000000#);
         Ada.Text_IO.Put_Line(" WAITING FOR BLOCK TO BE FREE");
         Exec_Load.Eat(1.0);
         Block_Free := Blocks.Get_Block_State(Block_Idx(Block));
         if (Block_Free = false) then
            Dac_Driver.Set_Voltage(Dac_Id(Train_Info.Cab), Unsigned_8((Character'pos ('9') - 48) * 27));
         end if;
      end loop;
   end Wait_For_Block;

      procedure Process_Front_Hit (Sensor : in Integer) is
   begin
      if Train_Info.Heading = Normal_Pol then
         --Get Blocks--
         case Sensor is
               when 35 => --we already own block 12
                  --grab block 13 if turnout 12 is straight
                  if Turnouts.Get_Turnout_State(12) = Straight then
                     Wait_For_Block(13);
                     Block_Driver.Set_Cab_And_Polarity(13, Train_Info.Cab, Train_Info.Heading);
                  --grab block 22 if turnout 12 is turned
                  elsif Turnouts.Get_Turnout_State(12) = Turned then
                     Wait_For_Block(22);
                     Block_Driver.Set_Cab_And_Polarity(22, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 37 => --we already own block 13
                  --grab block 14 if turnout 13 is straight
	          if Turnouts.Get_Turnout_State(13) = Straight then
                     Wait_For_Block(14);
                     Block_Driver.Set_Cab_And_Polarity(14, Train_Info.Cab, Train_Info.Heading);
                  --grab block 7 if turnout 13 is turned
                  elsif Turnouts.Get_Turnout_State(13) = Turned then
                     Wait_For_Block(7);
                     Block_Driver.Set_Cab_And_Polarity(7, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 39 => --we already own block 14
                  --grab block 15
                  Wait_For_Block(15);
                  Block_Driver.Set_Cab_And_Polarity(15, Train_Info.Cab, Train_Info.Heading);

               when 41 => --we already own block 15
                  --grab block 16
                  If Train_info.Facing = Normal_Pol then
                     Wait_For_Block(16);
                     Block_Driver.Set_Cab_And_Polarity(16, Train_Info.Cab, Train_Info.Heading);
                  else
                     --grab block 14 if turnout 15 is straight
                     if Turnouts.Get_Turnout_State(15) = Straight then
                        Wait_For_Block(14);
                        Block_Driver.Set_Cab_And_Polarity(14, Train_Info.Cab, Reverse_Pol);
                     --grab block 23 if turnout 15 is turned
                     elsif Turnouts.Get_Turnout_State(15) = Turned then
                        Wait_For_Block(23);
                        Block_Driver.Set_Cab_And_Polarity(23, Train_Info.Cab, Reverse_Pol);
                     end if;
                  end if;

               when 43 =>
                  If Train_info.Facing = Reverse_Pol then
                     Wait_For_Block(15);
                     Block_Driver.Set_Cab_And_Polarity(15, Train_Info.Cab, Reverse_Pol);
                  end if;

               when 45 => --we already own block 16
                  --grab block 17 if turnout 16 is straight
                  If Train_info.Facing = Normal_Pol then
                     if Turnouts.Get_Turnout_State(16) = Straight then
                        Wait_For_Block(17);
                        Block_Driver.Set_Cab_And_Polarity(17, Train_Info.Cab, Train_Info.Heading);
                     --grab block 22 if turnout 16 is turned
                     elsif Turnouts.Get_Turnout_State(16) = Turned then
                        Wait_For_Block(22);
                        Block_Driver.Set_Cab_And_Polarity(22, Train_Info.Cab, Train_Info.Heading);
                     end if;
                  end if;

               when 47 => --we already own block 17
                  --grab block 18 if turnout 17 is straight
                  if Turnouts.Get_Turnout_State(17) = Straight then
                     Wait_For_Block(18);
                     Block_Driver.Set_Cab_And_Polarity(18, Train_Info.Cab, Train_Info.Heading);
                  --grab block 10 if turnout 17 is turned
                  elsif Turnouts.Get_Turnout_State(17) = Turned then
                     Wait_For_Block(10);
                     Block_Driver.Set_Cab_And_Polarity(10, Train_Info.Cab, Train_Info.Heading);
                  end if;


               when 49 => --we already own block 18
                  --grab block 19
                  Wait_For_Block(19);
                  Block_Driver.Set_Cab_And_Polarity(19, Train_Info.Cab, Train_Info.Heading);

               when 19 => --we already own block 19
                  --grab block 12
                  Wait_For_Block(12);
                  Block_Driver.Set_Cab_And_Polarity(12, Train_Info.Cab, Train_Info.Heading);

               when 48 => --we already own block 22
                  --grab block 16
                  If Train_info.Facing = Normal_Pol then
                     Train_info.Facing := Reverse_Pol;
                     Wait_For_Block(16);
                     Block_Driver.Set_Cab_And_Polarity(16, Train_Info.Cab, Reverse_Pol);
                  end if;

               when 53 =>
                  If Train_info.Facing = Reverse_Pol then
                     Train_info.Facing := Normal_Pol;
                     Wait_For_Block(19);
                     Block_Driver.Set_Cab_And_Polarity(19, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when others =>
                  null;
            end case;
      else
         --Release Blocks--
         case Sensor is
               when 21 => --we owned block 12 turn it off
                  Block_Driver.Set_Cab_And_Polarity(12, 0, Train_Info.Heading);

               when 49 => --we owned block 19 turn it off
                  Block_Driver.Set_Cab_And_Polarity(19, 0, Train_Info.Heading);

               when 47 =>
                  --if turnout 17 is straight we owned block 18
	          if Turnouts.Get_Turnout_State(17) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(18, 0, Train_Info.Heading);
                  --if turnout 17 is turned we owned block 10
                  elsif Turnouts.Get_Turnout_State(17) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(10, 0, Train_Info.Heading);
                  end if;

               when 45 =>
                  if Train_Info.Facing = Normal_Pol then
                     --if turnout 16 is straight we owned block 17
	             if Turnouts.Get_Turnout_State(16) = Straight then
                        Block_Driver.Set_Cab_And_Polarity(17, 0, Train_Info.Heading);
                     --if turnout 16 is turned we owned block 22
                     elsif Turnouts.Get_Turnout_State(16) = Turned then
                        Block_Driver.Set_Cab_And_Polarity(22, 0, Train_Info.Heading);
                     end if;
                  else
                     Train_Info.Facing := Normal_Pol; --THIS NEEDS TO BE CHANGED IF WE IMPLEMENT
                     --BACK FACING AND FRONT FACING (THIS IS NEEDED TO EXTEND THE PROGRAM FUNCTIONALITY)
                  end if;

               when 43 => --we owned block 16 turn it off
                  If Train_Info.Facing = Normal_Pol then
                     Block_Driver.Set_Cab_And_Polarity(16, 0, Train_Info.Heading);
                  else
                     Block_Driver.Set_Cab_And_Polarity(15, 0, Train_Info.Heading);
                  end if;

               when 39 => --we owned block 15 turn it off
                  Block_Driver.Set_Cab_And_Polarity(15, 0, Train_Info.Heading);

               when 37 =>
                  --if turnout 13 is straight we owned block 14 and block 13
	          if Turnouts.Get_Turnout_State(13) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(14, 0, Train_Info.Heading);
                  --if turnout 13 is turned we owned block 22
                  elsif Turnouts.Get_Turnout_State(13) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(7, 0, Train_Info.Heading);
                  end if;

               when 35 =>
                  --if turnout 12 is straight we owned block 13
	          if Turnouts.Get_Turnout_State(12) = Straight then
                     Block_Driver.Set_Cab_And_Polarity(13, 0, Train_Info.Heading);
                  --if turnout 12 is turned we owned block 22
                  elsif Turnouts.Get_Turnout_State(12) = Turned then
                     Block_Driver.Set_Cab_And_Polarity(22, 0, Train_Info.Heading);
                  end if;

               when 41 =>
                  if Train_Info.Facing = Reverse_Pol then
                     if Turnouts.Get_Turnout_State(15) = Straight then
                        Block_Driver.Set_Cab_And_Polarity(14, 0, Train_Info.Heading);
                     elsif Turnouts.Get_Turnout_State(15) = Turned then
                        Block_Driver.Set_Cab_And_Polarity(23, 0, Train_Info.Heading);
                     end if;
                  end if;

               when 53 =>
                  if Train_Info.Facing = Reverse_Pol then
                     Block_Driver.Set_Cab_And_Polarity(19, 0, Train_Info.Heading);
                  end if;

               when 48 =>
                  if Train_Info.Facing = Normal_Pol then
                     Block_Driver.Set_Cab_And_Polarity(16, 0, Train_Info.Heading);
                  end if;

               when others =>
                  null;
            end case;
      end if;
   end Process_Front_Hit;

   procedure Process_Back_Hit (Sensor : in Integer) is
   begin
      if Train_Info.Heading = Normal_Pol then
         --Release Blocks--
         case Sensor is
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
                  if Train_Info.Facing = Normal_Pol then
                     --if turnout 15 is straight we owned block 14
	             if Turnouts.Get_Turnout_State(15) = Straight then
                        Block_Driver.Set_Cab_And_Polarity(14, 0, Train_Info.Heading);
                     --if turnout 15 is turned we owned block 23
                     elsif Turnouts.Get_Turnout_State(15) = Turned then
                        Block_Driver.Set_Cab_And_Polarity(23, 0, Train_Info.Heading);
                     end if;
                  end if;

               when 43 =>
                  If Train_Info.Facing = Normal_Pol then
                     Block_Driver.Set_Cab_And_Polarity(15, 0, Train_Info.Heading);
                  else
                     Block_Driver.Set_Cab_And_Polarity(16, 0, Train_Info.Heading);
                  end if;

               when 48 | 47 => --we owned block 16 turn it off
                  If Train_info.Facing = Normal_Pol then
                     Block_Driver.Set_Cab_And_Polarity(16, 0, Train_Info.Heading);
                  end if;

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

               when 58 =>
                  If Train_Info.Facing = Normal_Pol then
                     Block_Driver.Set_Cab_And_Polarity(12, 0, Train_Info.Heading);
                  end if;

               when 45 =>
                  If Train_Info.Facing = Reverse_Pol then
                     if Turnouts.Get_Turnout_State(16) = Straight then
                        Block_Driver.Set_Cab_And_Polarity(17, 0, Train_Info.Heading);
                     elsif Turnouts.Get_Turnout_State(16) = Turned then
                        Block_Driver.Set_Cab_And_Polarity(22, 0, Train_Info.Heading);
                     end if;
                  end if;

               when 63 =>
                  If Train_Info.Facing = Reverse_Pol then
                     Block_Driver.Set_Cab_And_Polarity(15, 0, Train_Info.Heading);
                  end if;

               when others =>
                  null;
            end case;
      else
         --Get Blocks--
         case Sensor is
               when 23 => --we already own block 12
                  --grab block 19
                  Wait_For_Block(19);
                  Block_Driver.Set_Cab_And_Polarity(19, Train_Info.Cab, Train_Info.Heading);

               when 51 => --we already own block 19
                  --grab block 18 if turnout 19 is straight
                  if Turnouts.Get_Turnout_State(19) = Straight then
                     Wait_For_Block(18);
                     Block_Driver.Set_Cab_And_Polarity(18, Train_Info.Cab, Train_Info.Heading);
                  --grab block 23 if turnout 19 is turned
                  elsif Turnouts.Get_Turnout_State(19) = Turned then
                     if Train_Info.Facing = Normal_Pol then
                        Train_Info.Facing := Reverse_Pol;
                        Wait_For_Block(23);
                        Block_Driver.Set_Cab_And_Polarity(23, Train_Info.Cab, Normal_Pol);
                     end if;
                  end if;

               when 49 => --we already own block 18
                  --grab block 17 if turnout 18 is straight
                  if Turnouts.Get_Turnout_State(19) = Straight then
                     Wait_For_Block(17);
                     Block_Driver.Set_Cab_And_Polarity(17, Train_Info.Cab, Train_Info.Heading);
                  --grab block 9 if turnout 18 is turned
                  elsif Turnouts.Get_Turnout_State(19) = Turned then
                     Wait_For_Block(9);
                     Block_Driver.Set_Cab_And_Polarity(9, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when 47 => --we already own block 17
                  --grab block 16
                  Wait_For_Block(16);
                  Block_Driver.Set_Cab_And_Polarity(16, Train_Info.Cab, Train_Info.Heading);

               when 43 => --we already own block 16
                  if Train_Info.Facing = Normal_Pol then
                     Wait_For_Block(15);
                     Block_Driver.Set_Cab_And_Polarity(15, Train_Info.Cab, Train_Info.Heading);
                  else
                     Wait_For_Block(16);
                     Block_Driver.Set_Cab_And_Polarity(16, Train_Info.Cab, Normal_Pol);
                  end if;

               when 41 => --we already own block 15
                  if Train_Info.Facing = Normal_Pol then
                     --grab block 14 if turnout 15 is straight
                     if Turnouts.Get_Turnout_State(15) = Straight then
                        Wait_For_Block(14);
                        Block_Driver.Set_Cab_And_Polarity(14, Train_Info.Cab, Train_Info.Heading);
                     --grab block 23 if turnout 15 is turned
                     elsif Turnouts.Get_Turnout_State(15) = Turned then
                        Wait_For_Block(23);
                        Block_Driver.Set_Cab_And_Polarity(23, Train_Info.Cab, Train_Info.Heading);
                     end if;
                  end if;

               when 39 => --we already own block 14
                  --grab block 13
                  Wait_For_Block(13);
                  Block_Driver.Set_Cab_And_Polarity(13, Train_Info.Cab, Train_Info.Heading);

               when 37 => --we already own block 13
                  --grab block 12
                  Wait_For_Block(12);
                  Block_Driver.Set_Cab_And_Polarity(12, Train_Info.Cab, Train_Info.Heading);

               when 63 =>
                  If Train_Info.Facing = Reverse_Pol then
                     Wait_For_Block(15);
                     Block_Driver.Set_Cab_And_Polarity(15, Train_Info.Cab, Normal_Pol);
                  end if;

               when 45 =>
                  If Train_Info.Facing = Reverse_Pol then
                     if Turnouts.Get_Turnout_State(16) = Straight then
                        Wait_For_Block(17);
                        Block_Driver.Set_Cab_And_Polarity(17, Train_Info.Cab, Train_Info.Heading);
                     --grab block 23 if turnout 15 is turned
                     elsif Turnouts.Get_Turnout_State(16) = Turned then
                        Wait_For_Block(22);
                        Block_Driver.Set_Cab_And_Polarity(22, Train_Info.Cab, Train_Info.Heading);
                     end if;
                  end if;

               when 58 =>
                  If Train_Info.Facing = Normal_Pol then
                     Wait_For_Block(12);
                     Block_Driver.Set_Cab_And_Polarity(12, Train_Info.Cab, Train_Info.Heading);
                  end if;

               when others =>
                  null;

            end case;
      end if;
   end Process_Back_Hit;

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

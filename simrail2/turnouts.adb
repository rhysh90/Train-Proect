with Ada.Text_IO, Ada.Integer_Text_IO, turnout_driver;


---------------------------------   Turnouts    -----------------------------------------------
-- The Turnouts package provides a virtualisation of the turnouts which exist in the train
-- set. It is responsible for managing the position of all the turnouts and call the
-- Turnout_Driver members.
--
-----------------------------------------------------------------------------------------------

package body Turnouts is

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


   ----------------   Get_Turnout_State    ---------------------------------------------
   -- Returns what position a given turnout is in. This can
   -- be straight or turned. Its contains some special
   -- considerations for turnouts which share an entry.
   --
   -- param T : in Turnout_Id	- The Id of the turnout whose position is being checked
   -- return Turnout_Pos
   --------------------------------------------------------------------------------------

   function Get_Turnout_State (T : in Turnout_Id) return Turnout_Pos is
      Pos : Turnout_Pos;
   begin
      S.Acquire;
      Pos := Turnout(T);
      -- Special Considerations for turnouts which share an entry point sensor --
         if (T = 13) then
         	if (Turnout(13) = Turned or else Turnout(14) = Turned) then
            		Pos := Turned;
            	end if;
         elsif (T = 14) then
            	if (Turnout(13) = Turned or else Turnout(14) = Turned) then
            		Pos := Turned;
           	 end if;
         elsif (T = 17) then
            	if (Turnout(17) = Turned or else Turnout(18) = Turned) then
            		Pos := Turned;
            	end if;
         elsif (T = 18) then
            	if (Turnout(17) = Turned or else Turnout(18) = Turned) then
            		Pos := Turned;
            	end if;
         end if;
      S.Release;
      return Pos;
   end Get_Turnout_State;


   -------------------   Get_Turnout    -----------------------------------------
   -- Returns what turnout is ahead of the given the train
   -- depending on the direction the train is travelling
   -- and whether the front or back of the train is leading
   --
   -- param T : in Integer   - The number of the sensor just hit
   -- param Heading : in Polarity_Type	  - The trains heading
   -- param Facing : in Polarity_Type    - Which end of the train is leading
   -- return Turnout_Id
   ------------------------------------------------------------------------------

   function Get_Turnout(T : in Integer; Heading : in Polarity_Type; Facing : in Polarity_Type) return Turnout_Id is
      Turnout : Turnout_Id;
   begin
      S.Acquire;
      --Turnout := Turnout_At_Sensor(T);
      if (Heading = Normal_Pol) then
         if (Facing = Normal_Pol) then
      	    case T is
               when 35 => Turnout := Turnout_Id(12);
               when 37 => Turnout := Turnout_Id(13);
               when 39 => Turnout := Turnout_Id(15);
               when 45 => Turnout := Turnout_Id(16);
               when 47 => Turnout := Turnout_Id(17);
               when 48 => Turnout := Turnout_Id(16);
               when 49 => Turnout := Turnout_Id(19);
               when 53 => Turnout := Turnout_Id(19);
               when others => null;
           end case;
         else
            case T is
               when 41 => Turnout := Turnout_Id(15);
               when 53 => Turnout := Turnout_Id(19);
               when others => null;
            end case;
         end if;

      else
         if (Facing = Normal_Pol) then
            case T is
               when 58 => Turnout := Turnout_Id(12);
               when 51 => Turnout := Turnout_Id(19);
               when 49 => Turnout := Turnout_Id(18);
               when 47 => Turnout := Turnout_Id(16);
               when 41 => Turnout := Turnout_Id(15);
               when 39 => Turnout := Turnout_Id(14);
               when 37 => Turnout := Turnout_Id(12);
               when 63 => Turnout := Turnout_Id(15);
               when others => null;
            end case;
         else
            case T is
               when 63 => Turnout := Turnout_Id(15);
               when 45 => Turnout := Turnout_Id(16);
               --when 58 => Turnout :=
               when others => null;
            end case;
         end if;
      end if;
      S.Release;
      return Turnout;
   end Get_Turnout;


   ----------------   Set_Turnout_State    -----------------------------------------------
   -- Set the position of a given turnout to a given
   -- position. Contains some special consideration for
   -- sensors which share an entry.
   --
   -- param T : in Turnout_Id     - The Id of the sensor to be changed
   -- param State : in Turnout_Pos	 - The position the turnout should be changed to
   ---------------------------------------------------------------------------------------

   procedure Set_Turnout_State (T : in Turnout_Id; State : in Turnout_Pos) is
   begin
      S.Acquire;
      if (State = Straight) then
         turnout_driver.Set_Straight(T);
         -- Special Considerations for turnouts which share an entry point sensor --
         if (T = 13) then
            turnout_driver.Set_Straight(Turnout_Id(14));
            Turnout(14) := State;
         elsif (T = 14) then
            turnout_driver.Set_Straight(Turnout_Id(13));
            Turnout(13) := State;
         elsif (T = 17) then
            turnout_driver.Set_Straight(Turnout_Id(18));
            Turnout(18) := State;
         elsif (T = 18) then
            turnout_driver.Set_Straight(Turnout_Id(17));
            Turnout(17) := State;
         end if;
      else
        turnout_driver.Set_Turn(T);
      end if;

      Turnout(T) := State;
      Ada.Integer_Text_IO.Put(Integer(T));
      Ada.Text_IO.Put_Line(" TURNOUT SET");
      S.Release;
   end Set_Turnout_State;


   ----------------------   Init    -------------------------
   -- Sets up the turnout at sensor array
   --
   -----------------------------------------------------------

   procedure Init is
   begin
      S.Acquire;
      for i in 1..19 loop
         Turnout(Turnout_Id(i)) := Straight;
      end loop;
      for i in 1..64 loop
         Turnout_At_Sensor(i) := No_Turnout;
      end loop;

      --SET UP THE TURNOUT AT SENSOR ARRAY--
      --this will return a turnout depending on what
      --sensor was hit

      --Turnout 1
      Turnout_At_Sensor(1) := Turnout_Id(1);
      Turnout_At_Sensor(18) := Turnout_Id(1);
      Turnout_At_Sensor(46) := Turnout_Id(1);
      Turnout_At_Sensor(64) := Turnout_Id(1);

      --Turnout 2
      Turnout_At_Sensor(4) := Turnout_Id(2);
      Turnout_At_Sensor(10) := Turnout_Id(2);
      Turnout_At_Sensor(12) := Turnout_Id(2);

      --Turnout 3
      Turnout_At_Sensor(6) := Turnout_Id(3);
      Turnout_At_Sensor(12) := Turnout_Id(3);
      Turnout_At_Sensor(14) := Turnout_Id(3);

      --Turnout 4
      Turnout_At_Sensor(8) := Turnout_Id(4);
      Turnout_At_Sensor(14) := Turnout_Id(4);
      Turnout_At_Sensor(16) := Turnout_Id(4);

      --Turnout 5
      Turnout_At_Sensor(16) := Turnout_Id(5);
      Turnout_At_Sensor(24) := Turnout_Id(5);
      Turnout_At_Sensor(26) := Turnout_Id(5);

      --Turnout 6
      Turnout_At_Sensor(34) := Turnout_Id(6);
      Turnout_At_Sensor(36) := Turnout_Id(6);
      Turnout_At_Sensor(39) := Turnout_Id(6);

      --Turnout 7
      Turnout_At_Sensor(34) := Turnout_Id(7);
      Turnout_At_Sensor(36) := Turnout_Id(7);
      Turnout_At_Sensor(37) := Turnout_Id(7);

      --Turnout 8
      Turnout_At_Sensor(38) := Turnout_Id(8);
      Turnout_At_Sensor(40) := Turnout_Id(8);
      Turnout_At_Sensor(60) := Turnout_Id(8);

      --Turnout 9
      Turnout_At_Sensor(42) := Turnout_Id(9);
      Turnout_At_Sensor(44) := Turnout_Id(9);
      Turnout_At_Sensor(49) := Turnout_Id(9);

      --Turnout 10
      Turnout_At_Sensor(42) := Turnout_Id(10);
      Turnout_At_Sensor(44) := Turnout_Id(10);
      Turnout_At_Sensor(47) := Turnout_Id(10);

      --Turnout 11
      Turnout_At_Sensor(1) := Turnout_Id(11);
      Turnout_At_Sensor(18) := Turnout_Id(11);
      Turnout_At_Sensor(46) := Turnout_Id(11);
      Turnout_At_Sensor(64) := Turnout_Id(11);

      --Turnout 12
      Turnout_At_Sensor(35) := Turnout_Id(12);
      Turnout_At_Sensor(37) := Turnout_Id(12);
      Turnout_At_Sensor(58) := Turnout_Id(12);

      --Turnout 13
      Turnout_At_Sensor(36) := Turnout_Id(13);
      Turnout_At_Sensor(37) := Turnout_Id(13);
      Turnout_At_Sensor(39) := Turnout_Id(13);

      --Turnout 14
      Turnout_At_Sensor(34) := Turnout_Id(14);
      Turnout_At_Sensor(37) := Turnout_Id(14);
      Turnout_At_Sensor(39) := Turnout_Id(14);

      --Turnout 15
      Turnout_At_Sensor(39) := Turnout_Id(15);
      Turnout_At_Sensor(41) := Turnout_Id(15);
      Turnout_At_Sensor(63) := Turnout_Id(15);

      --Turnout 16
      Turnout_At_Sensor(45) := Turnout_Id(16);
      Turnout_At_Sensor(47) := Turnout_Id(16);
      Turnout_At_Sensor(48) := Turnout_Id(16);

      --Turnout 17
      Turnout_At_Sensor(44) := Turnout_Id(17);
      Turnout_At_Sensor(47) := Turnout_Id(17);
      Turnout_At_Sensor(49) := Turnout_Id(17);

      --Turnout 18
      Turnout_At_Sensor(42) := Turnout_Id(18);
      Turnout_At_Sensor(47) := Turnout_Id(18);
      Turnout_At_Sensor(49) := Turnout_Id(18);

      --Turnout 19
      Turnout_At_Sensor(49) := Turnout_Id(19);
      Turnout_At_Sensor(51) := Turnout_Id(19);
      Turnout_At_Sensor(53) := Turnout_Id(19);

      S.Release;
   end Init;

end Turnouts;

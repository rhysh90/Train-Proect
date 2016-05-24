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

   -----------------------
   -- Get_Turnout_State --
   -----------------------

   function Get_Turnout_State (T : in Turnout_Id) return Turnout_Pos is
      Pos : Turnout_Pos;
   begin
      S.Acquire;
      Pos := Turnout(T);
      S.Release;
      return Pos;
   end Get_Turnout_State;

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

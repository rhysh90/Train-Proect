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
      S.Release;
   end Init;

end Turnouts;

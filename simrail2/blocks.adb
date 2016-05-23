package body Blocks is

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

   ---------------------
   -- Get_Block_State --
   ---------------------

   function Get_Block_State (B : in Block_Id) return Boolean is
   	State : Boolean;
   begin
      S.Acquire;
      State := Block(B);
      S.Release;
      return State;
   end Get_Block_State;

   procedure Init is
   begin
      S.Acquire;
      for i in 1..24 loop
         Block(Block_Id(i)) := false;
      end loop;
      Block(1) := true;
      Block(2) := true;
      Block(12) := true;
      S.Release;
   end Init;

end Blocks;

with Raildefs; use Raildefs;
with Ada.Integer_Text_IO;
with Ada.Text_IO;

---------------------------------   Blocks    ------------------------------------
-- The Blocks package provides a virtualisation of the blocks which exist in the train
-- set. It is responsible for managing the state of the blocks
----------------------------------------------------------------------------------
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

   ----------------   Get_Block_State    ---------------------------------------------
   -- Returns the state of a block; whether or not a given block is occupied or not.
   --
   -- param B : in Block_Id	- The Id of the block whose state is being checked
   -- return State : Boolean
   ----------------------------------------------------------------------------------
   function Get_Block_State (B : in Block_Id) return Boolean is
   	State : Boolean;
   begin
      S.Acquire;
      State := Block(B);
      S.Release;
      return State;
   end Get_Block_State;

   ----------------   Set_Block_State    -------------------------------------
   -- Sets the state of a block
   --
   -- param B : in Block_Id	- The Id of the block whose state is being set
   -- param State : Boolean	- The state of the block
   ---------------------------------------------------------------------------
   procedure Set_Block_State (B : in Block_Id; State : in Boolean) is
   begin
      S.Acquire;
      Block(B) := State;
      Ada.Integer_Text_IO.Put(Integer(B));
      if State /= true then
         Ada.Text_IO.Put_Line(" BLOCK REMOVED");
      else
         Ada.Text_IO.Put_Line(" BLOCK TAKEN");
      end if;
      S.Release;
   end Set_Block_State;

   ----------------   Init    -------------------------------------------------
   -- Sets the state of a block
   ----------------------------------------------------------------------------
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

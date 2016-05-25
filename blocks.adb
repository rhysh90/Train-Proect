with Raildefs; use Raildefs;
with Ada.Integer_Text_IO;
with Ada.Text_IO;

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

   --------------
   -- Get_Block--
   --------------
   --STILL NEED TO DO THIS
   function Get_Block ( Sensor : in Integer; P : in Polarity_Type) return Block_Id is
      Block : Block_Id := 1;
      begin
         S.Acquire;
         if P = Normal_Pol then
         --Block := Block_After_Sensor_Normal(Sensor);
         null;
         else
         --Block := Block_After_Sensor_Reverse(Sensor);
         null;
         end if;
         S.Release;
         return Block;
      end Get_Block;

   --------------------
   -- Set_Block_State--
   --------------------
   procedure Set_Block_State (B : in Block_Id; State : in Boolean) is
   begin
      S.Acquire;
      Block(B) := State;
      Ada.Integer_Text_IO.Put(Integer(B));
      if Integer(B) = 0 then
         Ada.Text_IO.Put_Line(" BLOCK REMOVED");
      else
         Ada.Text_IO.Put_Line(" BLOCK TAKEN");
      end if;
      S.Release;
   end Set_Block_State;


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

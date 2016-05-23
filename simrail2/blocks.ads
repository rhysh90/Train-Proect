with raildefs; use raildefs;

package Blocks is

   type Blocks_Array is array (Block_Id) of Boolean;

   function Get_Block_State(B : in Block_Id) return Boolean;

   procedure Init;

private
   Block : Blocks_Array;

end Blocks;

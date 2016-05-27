with raildefs; use raildefs;

package Blocks is

   type Block_Sensor_Loc is array (Integer range 1..64) of Block_Idx;

   type Blocks_Array is array (Block_Id) of Boolean;

   function Get_Block_State(B : in Block_Id) return Boolean;

   procedure Set_Block_State (B : in Block_Id; State : in Boolean);

   procedure Init;

private
   Block : Blocks_Array;

   Block_At_Sensor_Normal : Block_Sensor_Loc;

   Block_At_Sensor_Reverse : Block_Sensor_Loc;

end Blocks;

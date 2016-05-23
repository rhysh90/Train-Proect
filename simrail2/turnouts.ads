with raildefs; use raildefs;

package Turnouts is

   type Turnout_Array is array (Turnout_Id) of Turnout_Pos;

   function Get_Turnout_State(T : in Turnout_Id) return Turnout_Pos;

   procedure Init;

private
   Turnout : Turnout_Array;

end Turnouts;

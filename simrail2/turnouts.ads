with raildefs; use raildefs;

package Turnouts is

   type Turnout_Sensor_Loc is array (Integer range 1..64) of Turnout_Idx;

   type Turnout_Array is array (Turnout_Id) of Turnout_Pos;

   function Get_Turnout_State(T : in Turnout_Id) return Turnout_Pos;

   function Get_Turnout(T : in Integer; Heading : in Polarity_Type; Facing : in Polarity_Type) return Turnout_Id;

   procedure Set_Turnout_State (T : in Turnout_Id; State : in Turnout_Pos);

   procedure Init;

private
   Turnout : Turnout_Array;

   Turnout_At_Sensor : Turnout_Sensor_Loc;

end Turnouts;

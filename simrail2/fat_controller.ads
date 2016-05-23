-- Fat Controller --
-- Keeps track of each trains position --
with Projdefs, Trains;  use Projdefs, Trains;
package Fat_Controller is

   procedure Pass_Event(Request: in Request_Type);

   procedure Init (T1 : in out Train_Access; T2 : in out Train_Access; T3 : in out Train_Access);


end Fat_Controller;

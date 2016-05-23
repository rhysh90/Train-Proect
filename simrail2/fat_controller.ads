-- Fat Controller --
-- Keeps track of each trains position --
with Projdefs, Trains;  use Projdefs, Trains;
package Fat_Controller is

   procedure Pass_Event(Request: in Request_Type);

   procedure Init (T1 : in out Train; T2 : in out Train; T3 : in out Train);

end Fat_Controller;

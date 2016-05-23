-- Fat Controller --
-- Keeps track of each trains position --
with Projdefs, Trains;  use Projdefs, Trains;
package Fat_Controller is

   procedure Start(Request: in Request_Type);

   procedure Init (T1 : in Train; T2 : in Train; T3 : in Train);

end Fat_Controller;

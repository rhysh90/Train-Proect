-- Fat Controller --
-- Keeps track of each trains position --
with Projdefs;  use Projdefs;
package Fat_Controller is

   procedure Pass_Event(Request: in Request_Type);

   procedure Init;

end Fat_Controller;

-- Fat Controller --
-- Keeps track of each trains position --
with Projdefs, Raildefs;  use Projdefs, Raildefs;
package Fat_Controller is

   procedure Pass_Event(Request: in Request_Type);

   procedure Reverse_Direction(Train : in Integer);

   procedure Start_Oval(Train : in Integer; Heading : in Polarity_Type);

   procedure Start_Figure_Eight(Train : in Integer; Heading : in Polarity_Type);

   procedure Init;

end Fat_Controller;

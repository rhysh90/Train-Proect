-- Widget : an example Sporadic for RTP lecture
-- It has single-item buffer and a worker that delays 1 second.
-- R K Allen, Swinburne Univ Tech.  orig 25-Mar-01 revised 13-May-03
with Projdefs, Ada.Text_Io;
use Projdefs;
package body Widget is

   protected Buffer is
      procedure Start(
         Request: in Request_Type);

      entry Wait_Start(
         Request: out Request_Type;
         Over_Run : out Boolean );
   private
      Item : Request_Type;
      Item_Available,
         Too_Fast : Boolean := False;
   end Buffer;
   ---
   task Worker_Thread;
   ------------  

   procedure Start(
         Request: in Request_Type) is
   begin
      Buffer.Start(Request);
   end Start;

   --------- 
   protected body Buffer is
      procedure Start(
            Request: in Request_Type) is
      begin
         if Item_Available then
            Too_Fast := True;
         else
            Item_Available := True;
         end if;
         Item := Request;  -- ignore old
      end Start;

      entry Wait_Start(
            Request: out Request_Type;
            Over_Run : out Boolean )
            when Item_Available is
      begin
         Request := Item;
         Over_Run := Too_Fast;
         Item_Available := False;
         Too_Fast := False;
      end Wait_Start;
   end Buffer;

   ------- 
   task body Worker_Thread is
      Req : Request_Type ;
      Oops : Boolean;
   begin
      loop
         Buffer.Wait_Start(Request=>Req, Over_Run=>Oops);
         Ada.Text_Io.Put_Line(" Req=" & Req'Img
                                & " Over_Run=" & Oops'Img);
         delay 1.0;
         -- NB the above delay statement is for test/demo ONLY.
         -- Normal sporadics do NOT have delays in their bodies.
         -- The relative time intervals between here and the test harness
         -- are simply to demonstrate one or more over-run occurrences.
      end loop;
   end Worker_Thread;

end Widget;
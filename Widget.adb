-- Widget : an example Sporadic for RTP lecture
-- It has single-item buffer and a worker that delays 1 second.
-- R K Allen, Swinburne Univ Tech.  orig 25-Mar-01 revised 13-May-03
with Projdefs, Ada.Text_Io, Exec_Load, Ada.Real_Time, Ada.Float_Text_IO, Ada.Integer_Text_IO;
use Projdefs, Ada.Real_Time;
package body Widget is
   
   T0 : Time;

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
   
   function Time_Stamp return String is
      Dt : Time_Span;
      D : Duration;
      Tf : Float;
      time_stamp : String(1..10); 
   begin
      Dt := Clock - T0;
      D := To_Duration(Dt);
      Tf := Float(D);
      Ada.Float_Text_IO.Put(time_stamp, Tf, 6, 0);
      return time_stamp;
   end Time_Stamp;
   
   procedure Init_Time_Stamp is
   begin
      T0 := Clock;
   end Init_Time_Stamp;
   
   procedure Sporadic_Op(Request : in Request_Type) is
   begin
      Ada.Text_IO.Put(Time_Stamp);
      Ada.Text_Io.Put_Line(" Req=" & Request'Img & " starting");
      Exec_Load.Eat(1.0);
      Ada.Text_IO.Put_Line(Time_Stamp & " complete");
   end Sporadic_Op;
       
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
         if Oops then
           Ada.Text_Io.Put_Line(Time_Stamp & " Over_Run=" & Oops'Img);
         end if;
         Sporadic_Op(Req);
         --delay 1.0;
         -- NB the above delay statement is for test/demo ONLY.
         -- Normal sporadics do NOT have delays in their bodies.
         -- The relative time intervals between here and the test harness
         -- are simply to demonstrate one or more over-run occurrences.
      end loop;
   end Worker_Thread;

end Widget;

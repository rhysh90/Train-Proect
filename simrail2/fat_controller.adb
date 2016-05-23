with Projdefs, Ada.Text_Io, Exec_Load, Ada.Real_Time, Ada.Float_Text_IO, Ada.Integer_Text_IO, Trains;
use Projdefs, Ada.Real_Time, Trains;

package body Fat_Controller is

   T0 : Time;
   Train1, Train2, Train3 : Train;

   BuffSize : constant := 10;

   type Circular_Buffer is array (1..BuffSize) of Request_Type;


    protected Buffer is
      procedure Start(
         Request: in Request_Type);

      entry Wait_Start(
         Request: out Request_Type;
                       Over_Run : out Boolean );

      entry Add(Request : in Request_Type);
      entry Remove(Request : out Request_Type);
   private
      Item : Request_Type;

      --Circular Buffer
      Items : Circular_Buffer;
      Iin : Integer := 1;
      Jout : Integer := 1;
      Count : Natural := 0;

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

   procedure Init (T1 : in Train; T2 : in Train; T3 : in Train) is
   begin
      Train1 := T1;
      Train2 := T2;
      Train3 := T3;

   end Init;


   procedure Sporadic_Op(Request : in Request_Type) is
   begin
      Ada.Text_IO.Put(Time_Stamp);
      Ada.Text_Io.Put_Line(" Req=" & Request'Img & " starting");
      --Exec_Load.Eat(1.0); NOT REQUIRED
      --Pass senor request to the correct train controller


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

      entry Add(Request : in Request_Type) when Count < BuffSize is
      begin
         Items(Iin) := Request;
         Iin := Iin mod BuffSize + 1;
         Count := Count + 1;
      end Add;

      entry Remove(Request : out Request_Type) when Count > 0 is
      begin
         Request := Items(jout);
         Jout := Jout mod BuffSize + 1;
         Count := Count - 1;
      end Remove;
   end Buffer;

   -------
   task body Worker_Thread is
      Req : Request_Type ;
      Oops : Boolean;
   begin
      loop
         Buffer.Wait_Start(Request=>Req, Over_Run=>Oops);
         if Oops then
           Ada.Text_Io.Put_Line(Time_Stamp & " Sensor Event Lost");
         end if;
         Buffer.Add(Req);
         Buffer.Remove(Request=>Req);
         Sporadic_Op(Req);
         --delay 1.0;
         -- NB the above delay statement is for test/demo ONLY.
         -- Normal sporadics do NOT have delays in their bodies.
         -- The relative time intervals between here and the test harness
         -- are simply to demonstrate one or more over-run occurrences.
      end loop;
   end Worker_Thread;

end Fat_Controller;

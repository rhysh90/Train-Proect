-- interrupt package for skeleton test program skel2 for trains --
-- requires Swindows, Simrail2 (vsn 2.3+), Raildefs (vsn 3+)
-- and Halls2 & Io_Ports for Simrail2
-- Only displays one line for each interrupt.
--
-- Version: 1.0 extracted from skel2 for GNAT2009, 19-Feb-09
-- Version: 1.1 hide protected, 16-Mar-10
-- Version: 1.3 improve display, eg ...5.7.., 31-Jan-2011
-- Version: 1.4 add W_Height to eliminate a magic no, reformat 22-Jun-2011
-- Version: 2.2 write 'I' events to Slogger 19-Mar-2013
-- Version  3.0 25-Feb-2015 procedure no longer protected
-- version  3.1 16-Feb-16 revert to protected proc for int handling
--
-- Copyright: Dr R. K Allen, Faculty of Sc Eng Tech, Swinburne Uni Tech
--
with Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Elementary_Functions;
with Ada.Integer_Text_Io;
with Swindows;  use Swindows;
with Unsigned_Types;  use Unsigned_Types;
with Widget;
with
   Raildefs,
   Int32defs,
   Halls2,
   Projdefs;
use Raildefs;
with Slogger;  --v2.2

with Fat_Controller;

package body Interrupt_Hdlr is

   --procedure F(Value : in Float) is
   --   package Float_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
   --   The_Log : Integer := 0;
   --begin
   --   The_Log := Integer(Float_Functions.Log(Value, 2.0));
   --   G(Value, The_Log);
   --end;

   W_Interrupts : Swindows.Window;
   -- assumed to be full width, ie 78 columns inside, and W_Height lines inside
   W_Height : constant Natural := 14;  -- beware: must conform to main program!

   package Iio renames Ada.Integer_Text_Io;

   subtype String8 is String(1..8);  -- cant be declared in a protected.

   protected Interrupt is

      procedure Analyze (
         Offset : in     Raildefs.Sensor_Idx;     -- 0 or 32
         Value : in     Raildefs.Four_Registers );-- vsn 2.0.5
      -- this procedure conforms to Raildefs.Proc4_Access

   private

      Previous_Sensor_Reg1 : Raildefs.Four_Registers := (0, 0, 0, 0, 0);
      Previous_Sensor_Reg2 : Raildefs.Four_Registers := (0, 0, 0, 0, 0);

      Number : Natural := 1;  -- a serial number
      Line_Number : Natural := 1;  -- within the Swindows window

      Fg : Swindows.Color := Swindows.White;
      Sensor_Line : String(1..78) :=
         (1..4|13|22|31|40|49|58|67|76..78 => ' ', others => '.');

      function To_String (
            Val        : Unsigned_8;
            LSB_Sensor : Raildefs.Sensor_Idx)
         return String8;

   end Interrupt;

   procedure Init (
         Win : in     Swindows.Window) is
   begin
      W_Interrupts := Win;
      Widget.Init_Time_Stamp;
   end Init;

   procedure Install is -- added v1.1
   begin
      Halls2.Install_Int_Handling(Interrupt.Analyze'access);
   end Install;

   protected body Interrupt is

      -- Analyze (Offset, Value)
      --
      -- Receive 40-bit data captured from one of the two INT32 cards
      -- (by Halls2, or simulated in Simrail2) and pass sensor changes on to
      -- train control code.  Also display as one line in W_Interrupts.
      --
      -- This version only displays; it takes too much screen space.
      -- Todo: add variable(s) to remember Value from previous call;
      -- add code to check for sensor bit changes and for any change call
      -- an async (ASER) operation in train controller.
      --
      procedure Analyze (
            Offset : in     Raildefs.Sensor_Idx;  -- 0 or 32
            Value  : in     Raildefs.Four_Registers ) is
         --
         use Int32defs;

         Previous_Reg : Unsigned_8;
         Current_Reg : Unsigned_8;
         Changed_Val : Unsigned_8;
         Sensor_Int  : Integer;

         procedure Increment_Line is -- v1.4
            -- provides rolling colour change (much more efficient than
            -- scrolling)
         begin
            Line_Number := (Line_Number mod W_Height) + 1;
            if Line_Number = 1 then
               -- change colour
               if Fg = White then
                  Fg := Yellow;
               else
                  Fg := White;
               end if;
            end if;
         end Increment_Line;

      begin


         -------------------------TRAIN PROJECT---------------------------------
         if Offset < 32 then
            null;
            --check what changed in reg1
            for i in 0..3 loop
               Current_Reg := Value(i);
               Previous_Reg := Previous_Sensor_Reg1(i);
               --compare unsigned_8 with each other
               if (Current_Reg XOR Previous_Reg) /= 0 then
                  Changed_Val := Current_Reg XOR Previous_Reg;
                  --Sensor 1 to 32
                  Sensor_Int := (Integer(Ada.Numerics.Elementary_Functions.Log(Float(Changed_Val), 2.0)) + (i*8) + 1);
                  Fat_Controller.Start(Projdefs.Request_Type(Sensor_Int));
               end if;
            end loop;

         else
            null;
            --check what changed in reg2
            for i in 0..3 loop
               Current_Reg := Value(i);
               Previous_Reg := Previous_Sensor_Reg2(i);
               --compare unsigned_8 with each other
               if (Current_Reg XOR Previous_Reg) /= 0 then
                  Changed_Val := Current_Reg XOR Previous_Reg;
                  --Sensor 33 to 64
                  Sensor_Int := (Integer(Ada.Numerics.Elementary_Functions.Log(Float(Changed_Val), 2.0)) + (i*8) + 33);
                  Fat_Controller.Start(Projdefs.Request_Type(Sensor_Int));
               end if;
            end loop;
        end if;

         --create ASER operation in train controller
         --Ada.Integer_Text_IO.Put(Sensor_Int);
         Widget.Start(Projdefs.Request_Type(Sensor_Int));


         --update the previous sensor registers with current for next interrupt
        if Offset < 32 then
            Previous_Sensor_Reg1 := Value;
        else
            Previous_Sensor_Reg2 := Value;
        end if;
         -----------------------------------------------------------------------



         -- if logging is enabled (it is by default) write an 'I' event.
         -- This could be suppressed entirely, as Simrail2 v2.2.1 and HW Halls2 v2.6
         -- send 'i' events.  'i' to 'I' measures interrupt queue latency, but
         -- this is meaningless for simrail2.
         if Slogger.On then
            Slogger.Send_Event('I', Integer(Offset), Value);
         end if;

         -- assemble 78-char string:
         Iio.Put(Sensor_Line(1..3), Number);
         -- display sensor bytes and turnout nibble in binary ('.'=1)
         if Offset = 0 then -- sensors 1..32
            Sensor_Line( 5..12) := To_String(Value(0), 1);
            Sensor_Line(14..21) := To_String(Value(1), 9);
            Sensor_Line(23..30) := To_String(Value(2), 17);
            Sensor_Line(32..39) := To_String(Value(3), 25);
         else  -- sensors 33..64
            Sensor_Line(41..48) := To_String(Value(0), 33);
            Sensor_Line(50..57) := To_String(Value(1), 41);
            Sensor_Line(59..66) := To_String(Value(2), 49);
            Sensor_Line(68..75) := To_String(Value(3), 57);
         end if;
         -- Note: 35 chars retained from previous call.

         -- last byte is for debugging simrail or Halls2:
         if Value'Last = 4 then  -- (a bit of future-proofing)
            Iio.Put(Sensor_Line(76..78), Integer(Value(4)));  -- added v.1.5.2
            -- 0..255 a pity not hex but no room.
         end if;
         Put_Line(W_Interrupts, Sensor_Line, Line_Number, Foreground=>Fg);
         Number := (Number + 1) mod 1000;  -- serial number
         Increment_Line;

      exception
         when Constraint_Error =>
            Put_Line(W_Interrupts, "int constraint", Line_Number);
            Increment_Line;  -- v1.4
         when Tasking_Error =>
            Put_Line(W_Interrupts, "int tasking", Line_Number);
            Increment_Line;  -- v1.4
         when others =>
            Put_Line(W_Interrupts, "int others", Line_Number);
            Increment_Line;  -- v1.4
      end Analyze;

      function To_String (
            Val        : Unsigned_8;
            LSB_Sensor : Raildefs.Sensor_Idx)
            return String8 is
      -- Example:
      -- for only sensor18 on (Val=>2,LSB_Sensor=>17) returns ".8......"
         use Int32defs;
         V      : Sensor_Register := Unsigned_8_To_Sensor_Register (Val);
         Result : String8         := "........";
      begin
         for I in Sensor_Idx range 0..7 loop  -- note display LSB on left
            if V(I) = Raildefs.On then
               Result(Integer(I)+1) :=
                  Character'Val(48 + Integer(I + LSB_Sensor) mod 10);
            end if;
         end loop;
         return Result;
      end To_String;

   end Interrupt;

end Interrupt_Hdlr;

-- skeleton test program 2.3 for trains
--
-- requires Adagraph, Simrail2 (vsn 2.3.0 +), Raildefs (3.0), Dio192defs,
--  Dda06defs, Dda06defs, and Halls2 & Io_Ports for Simrail2
--
-- Original (test5): 16-Nov-94
-- version 2.0.6  11-Mar-08 for simrail2 2.0.6
-- version 2.0.8   3-Apr-08 improved Dialog_Loop, made it compilable
-- version 2.0.9  13-May-08 Halls2 init, Pull param
-- version 2.1.0  20-Feb-09 moved interrupt handler into separate package
-- version 2.1.1  16-Mar-10 hide protected inside the interrupt package
-- version 2.2    19-Mar-13 include 'D'=Slogger in dialog, 'S' now simrail dump
-- version 2.3     9-Mar-15 number is prefix in dialog, for raildefs 3.0
--
-- Copyright: Dr R. K Allen, Faculty of SET, Swinburne UT
-- (For use within the unit HIT3047/SWE30001 Real-Time Programming only.)
--
with Ada.Text_IO, Ada.Integer_Text_IO;
with Simrail2;
with Io_Ports;
with Swindows;                                 use Swindows;
with Unsigned_Types;                           use Unsigned_Types;  -- 1.8
with Raildefs;                                 use Raildefs;
with dac_driver;
with block_driver;
with turnout_driver;
with Sound_Manager;
with Dio192defs, Int32defs, Halls2;
with Interrupt_Hdlr;  -- 2.1
with Slogger;  -- 2.2

with Fat_Controller, Trains, Turnouts, Blocks;
use Turnouts, Blocks;

procedure main is
   --package Iio is new Ada.Text_Io.Integer_Io(Integer);
   package Iio renames Ada.Integer_Text_IO;

   W_In, W_Info, W_Interrupts : Swindows.Window;

   --TRAIN PROJECT CODE--

   -- TRAIN OBJECTS --


   -- vars and code for dio192: -------
   --
   type Block_Reg_Array is
     array (Raildefs.Block_Idx range 0 .. 11) of Dio192defs.Block_Register;
   Block_Regs : Block_Reg_Array;

   --   type Turnout_Drive_Array is ... Tn_Drives : ...
   --
   -- NB the above arrays must persist between calls of procs below
   --  (should be inside Ada sep package, maybe protected)

   procedure Init_Dio is
      -- todo: split into two procedures in two packages
      -- for blocks and turnouts separately
      use Dio192defs;
   begin
      -- init 24-bits output 4 times
      Io_Ports.Write_Io_Port (Pctl1_Addr, Output_Init1);
      Io_Ports.Write_Io_Port (Qctl1_Addr, Output_Init1);
      Io_Ports.Write_Io_Port (Pctl2_Addr, Output_Init1);
      Io_Ports.Write_Io_Port (Qctl2_Addr, Output_Init1);
      -- init 24-bits mixed input & output
      --      Io_Ports.Write_Io_Port(Pctl3_Addr, Pctl3_Init1);
      --      Io_Ports.Write_Io_Port(Qctl3_Addr, Qctl3_Init1);

      for I in Block_Regs'range loop
         Block_Regs (I) := Zero_Normal;
         Io_Ports.Write_Io_Port (Block_Addr (I), Unsigned (Block_Regs (I)));
      end loop;

      --      for I in Tn_Drives'range loop
      --         Tn_Drives(I) := Turnout_Drive_Init;
      --         Io_Ports.Write_Io_Port(Turnout_Drive_Addr(I),
      --Unsigned(Tn_Drives(I)));
      --      end loop;

      -- finish initialisation, tristate on
      Io_Ports.Write_Io_Port (Pctl1_Addr, Output_Init2);
      Io_Ports.Write_Io_Port (Qctl1_Addr, Output_Init2);
      Io_Ports.Write_Io_Port (Pctl2_Addr, Output_Init2);
      Io_Ports.Write_Io_Port (Qctl2_Addr, Output_Init2);
      -- init 24-bits mixed input & output you write

   end Init_Dio;

   procedure Pull
     (Tn  : in Raildefs.Turnout_Id;
      Dir : in Raildefs.Turnout_Pos  -- ignore if Middle
        ) is
      --
      use Dio192defs;
      Ndx   : Raildefs.Turnout_Idx := (Tn - 1) / 8;
      Bit   : Raildefs.Turnout_Idx := (Tn - 1) mod 8;
      Drive : Dio192defs.Turnout_Drive_Bit;
   begin
      case Dir is
         when Middle =>
            return;
         when Straight =>
            Drive := Straighten;
         when Turned =>
            Drive := Turn;
      end case;
      --      Tn_Drives(Ndx)(Bit) := Drive;
      --      Io_Ports.Write_Io_Port(Turnout_Drive_Addr(Ndx),
      --      Unsigned(Tn_Drives(Ndx)) );
   end Pull;

   -------- Oval ------------------------
   --
   -- p will set the direction around the oval
   -- sets up an inner oval track for train 2
   ----------------------------------------------
   procedure Oval (Pol : in Polarity_Type) is
   begin
      --move other trains off the oval (can make this later)
      --move train 2 into the oval
      --set up the oval for train 2

      --straighten turnouts in oval:
      turnout_driver.Set_Straight(Raildefs.Turnout_Id(12));
      turnout_driver.Set_Straight(Raildefs.Turnout_Id(13));
      turnout_driver.Set_Straight(Raildefs.Turnout_Id(14));
      turnout_driver.Set_Straight(Raildefs.Turnout_Id(15));
      turnout_driver.Set_Straight(Raildefs.Turnout_Id(16));
      turnout_driver.Set_Straight(Raildefs.Turnout_Id(17));
      turnout_driver.Set_Straight(Raildefs.Turnout_Id(18));
      turnout_driver.Set_Straight(Raildefs.Turnout_Id(19));

      -- set blocks for cab 2
      block_driver.Set_Cab_And_Polarity(Raildefs.Block_Id(12), Raildefs.Cab_Type(2), Pol);
      block_driver.Set_Cab_And_Polarity(Raildefs.Block_Id(13), Raildefs.Cab_Type(2), Pol);
      block_driver.Set_Cab_And_Polarity(Raildefs.Block_Id(14), Raildefs.Cab_Type(2), Pol);
      block_driver.Set_Cab_And_Polarity(Raildefs.Block_Id(15), Raildefs.Cab_Type(2), Pol);
      block_driver.Set_Cab_And_Polarity(Raildefs.Block_Id(16), Raildefs.Cab_Type(2), Pol);
      block_driver.Set_Cab_And_Polarity(Raildefs.Block_Id(17), Raildefs.Cab_Type(2), Pol);
      block_driver.Set_Cab_And_Polarity(Raildefs.Block_Id(18), Raildefs.Cab_Type(2), Pol);
      block_driver.Set_Cab_And_Polarity(Raildefs.Block_Id(19), Raildefs.Cab_Type(2), Pol);

      --run train 2 around the oval

   end Oval;

   -- for Dialog_Loop: --

   Pos0 : constant := 48;  -- ASCII '0'
   Number : Integer := 0;  -- prefix for commands

   -------- Dac_Command ------------------------
   -- User syntax:  ndm
   -- where n and 'd' already read, supports m in 0..9
   -- Here voltage is m*factor (not very nice).
   ----------------------------------------------
   procedure Dac_Command is
      C   : Character;
      Dac : Cab_Type := 0;
      V   : Unsigned_8;
   begin
      if Number in 1..4 then
         Dac := Dac_Id(Number);
         Get_Char (W_In, C);
         if C in '0' .. '9' then
            V := Unsigned_8((Character'pos (C) - Pos0) * 27);  -- or something
            dac_driver.Set_Voltage (Dac, V);
         else
            Dac := 0;
         end if;
      end if;
      if Dac = 0 then
         Put_Line (W_In, "command ignored");
         delay 1.0;
      end if;
      Number := 0;  -- we used it SMALLCAT
   end Dac_Command;

   -------- b_Command ------------------------
   -- User syntax:  nb{+-}m
   -- where n and 'b' already read
   -- supports m in 1..4, n 1..24
   ----------------------------------------------
   procedure b_command is
      C          : Character;
      Block      : Block_Id;
      Polarity   : Polarity_Type;
      Cab	 : Cab_Type;
   begin
      if Number in 1..24 then
         Block := Block_Id(Number);
         Get_Char (W_In, C);
         if C = '+' then
            Polarity := Normal_Pol;
         elsif C = '-' then
            Polarity := Reverse_Pol;      -- THIS IS GOOD ONE
         else
            Number := 0;
            Put_Line (W_In, "command ignored");
            delay 1.0;
            return;
         end if;
         Get_Char (W_In, C);
         if C in '0'..'4' then
            Cab := Cab_Type(Character'pos (C) - Pos0);
            block_driver.Set_Cab(Block, Cab);
            block_driver.Set_Polarity(Block, Polarity);
         else
            Put_Line (W_In, "command ignored");
            delay 1.0;
         end if;
      else
         Put_Line (W_In, "command ignored");     --COMAND IGNORED
         delay 1.0;
      end if;
      Number := 0;
   end b_command;

   -------- t_Command ------------------------
   -- User syntax:  nt
   -- where n and 't' already read
   -- supports n 1..19
   ----------------------------------------------
   procedure t_command is
      Turnout   : Turnout_Id;
   begin
      if Number in 1..19 then
         Turnout := Turnout_Id(Number);
         Set_Turnout_State (Turnout, Turned);
      else
         Put_Line (W_In, "command ignored");     --COMAND IGNORED
         delay 1.0;
      end if;
      Number := 0;
   end t_command;

   -------- s_Command ------------------------
   -- User syntax:  ns
   -- where n and 's' already read
   -- supports n 1..19
   ----------------------------------------------
   procedure s_command is
      Turnout   : Turnout_Id;
   begin
      if Number in 1..19 then
         Turnout := Turnout_Id(Number);
         Set_Turnout_State (Turnout, Straight);
      else
         Put_Line (W_In, "command ignored");     --COMAND IGNORED
         delay 1.0;
      end if;
      Number := 0;
   end s_command;

   -------- o_Command ------------------------
   -- User syntax:  o{+/-}
   --
   -- calls the oval function
   ----------------------------------------------
   procedure o_command is
      Polarity : Polarity_Type;
      C        : Character;
   begin
      Get_Char (W_In, C);
      if C = '+' then
      	Polarity := Normal_Pol;
      elsif C = '-' then
      	Polarity := Reverse_Pol;      -- THIS IS GOOD ONE
      else
      	Number := 0;
      	Put_Line (W_In, "command ignored");
      	delay 1.0;
      	return;
      end if;
      Number := 0;
      Oval(Polarity);
   end o_command;

   -------- Bell_Command ------------------------
   -- User syntax:  nB
   -- where n is already read

   -- calls the Sound_Bell function
   ----------------------------------------------
   procedure Bell_command is
   begin
      if Number in 1..4 then
         Sound_Manager.Sound_Bell(Cab_Type(Number));
      else
         Put_Line (W_In, "command ignored");     --COMAND IGNORED
         delay 1.0;
      end if;
      Number := 0;
   end Bell_command;

   -------- Horn_Command ------------------------
   -- User syntax:  nH
   -- where n is already read

   -- calls the Sound_Horn function
   ----------------------------------------------
   procedure Horn_command is
   begin
      if Number in 1..4 then
         Sound_Manager.Sound_Horn(Cab_Type(Number));
      else
         Put_Line (W_In, "command ignored");     --COMAND IGNORED
         delay 1.0;
      end if;
      Number := 0;
   end Horn_command;

   procedure Dialog_Loop is
      C : Character;
   begin
      loop
         Put_Line (W_In, "Command:");
         Get_Char (W_In, C);
         case C is
            when '0'..'9' =>
               Number := Number*10 + (Character'Pos(C) - Pos0);

            when 'D' =>
               Slogger.Finalize;   -- dump goes to a disk file
               Ada.Text_IO.Put_Line ("simlogger_out.txt closed");
               Number := 0;  -- forget it

            when 'S' =>
               Simrail2.Dump;  -- to console
               Number := 0;  -- forget it

            when 'd' =>
               Dac_Command;

            when 'b' =>
               b_command;

            when 't' =>
               t_command;

            when 's' =>
               s_command;

            when 'o' =>
               o_command;

            when 'B' =>
               Bell_command;

            when 'H' =>
               Horn_command;

            when others =>
               null;
         end case;
         Clear (W_In);
      end loop;
   end Dialog_Loop;

begin
   Ada.Text_IO.Put_Line (" Simple use of simrail2 " & Simrail2.Version);
   Simrail2.Reset (N_Trains => 3, N_Carriages_Train_1 => 2);
   Swindows.Open (W_In, 0, 0, 7, 35, "Input");
   Swindows.Open (W_Interrupts, 8, 0, 23, 79, "Interrupts"); -- 24 lines
   Interrupt_Hdlr.Init (W_Interrupts);

   Init_Dio;

   Halls2.Initialize;
   Interrupt_Hdlr.Install; -- calls Halls2

   --intialize objects
   Turnouts.Init;
   Blocks.Init;
   Fat_Controller.Init;

   --TEST TEST TEST TEST TEST
   Dialog_Loop;

end main;

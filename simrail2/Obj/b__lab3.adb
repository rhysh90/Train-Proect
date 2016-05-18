pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__lab3.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__lab3.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E086 : Short_Integer; pragma Import (Ada, E086, "system__os_lib_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "system__fat_flt_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "system__fat_llf_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E062 : Short_Integer; pragma Import (Ada, E062, "ada__io_exceptions_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "ada__numerics_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "ada__tags_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "ada__streams_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "interfaces__c_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "interfaces__c__strings_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E089 : Short_Integer; pragma Import (Ada, E089, "system__file_control_block_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "system__file_io_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "system__finalization_root_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "ada__finalization_E");
   E251 : Short_Integer; pragma Import (Ada, E251, "system__storage_pools_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "system__finalization_masters_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "system__task_info_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__calendar__delays_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "system__pool_global_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "system__random_seed_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__secondary_stack_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "system__tasking__initialization_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "ada__real_time_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__text_io_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "system__tasking__protected_objects_E");
   E213 : Short_Integer; pragma Import (Ada, E213, "system__tasking__protected_objects__entries_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "system__tasking__queuing_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "system__tasking__stages_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "adagraph_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "logger_ada_E");
   E247 : Short_Integer; pragma Import (Ada, E247, "swindows_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "interrupt_hdlr_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "io_ports_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "dac_driver_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "dio192defs_E");
   E111 : Short_Integer; pragma Import (Ada, E111, "block_driver_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "halls2_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "simrail2_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "simtrack2_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "simtrack2__display_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "sound_manager_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "turnout_driver_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "slogger_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "turnout_driver__finalize_body");
      begin
         E260 := E260 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "swindows__finalize_body");
      begin
         E247 := E247 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "simrail2__finalize_body");
      begin
         E120 := E120 - 1;
         F3;
      end;
      E213 := E213 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F4;
      end;
      E059 := E059 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "ada__text_io__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__file_io__finalize_body");
      begin
         E080 := E080 - 1;
         F6;
      end;
      E249 := E249 - 1;
      E253 := E253 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__pool_global__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__finalization_masters__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (True, True, False, True, True, False, False, True, 
           False, False, True, True, True, True, False, False, 
           True, False, False, True, True, False, True, True, 
           False, True, True, True, True, False, True, True, 
           False, True, False, False, True, False, False, False, 
           True, True, False, True, False, True, True, False, 
           False, True, False, False, False, False, False, False, 
           True, True, True, True, True, False, False, True, 
           False, False, True, False, True, True, False, True, 
           True, True, False, True, False, False, False, True, 
           True, True, True, False, True, False),
         Count => (0, 0, 0, 2, 3, 2, 2, 0, 3, 0),
         Unknown => (False, False, False, False, False, False, False, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Fat_Flt'Elab_Spec;
      E139 := E139 + 1;
      System.Fat_Llf'Elab_Spec;
      E127 := E127 + 1;
      System.Exception_Table'Elab_Body;
      E025 := E025 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E062 := E062 + 1;
      Ada.Numerics'Elab_Spec;
      E140 := E140 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E061 := E061 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      System.File_Control_Block'Elab_Spec;
      E089 := E089 + 1;
      System.Finalization_Root'Elab_Spec;
      E084 := E084 + 1;
      Ada.Finalization'Elab_Spec;
      E082 := E082 + 1;
      System.Storage_Pools'Elab_Spec;
      E251 := E251 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Task_Info'Elab_Spec;
      E164 := E164 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E006 := E006 + 1;
      System.Pool_Global'Elab_Spec;
      E253 := E253 + 1;
      System.Random_Seed'Elab_Body;
      E146 := E146 + 1;
      System.Finalization_Masters'Elab_Body;
      E249 := E249 + 1;
      System.File_Io'Elab_Body;
      E080 := E080 + 1;
      E156 := E156 + 1;
      E047 := E047 + 1;
      Ada.Tags'Elab_Body;
      E064 := E064 + 1;
      System.Soft_Links'Elab_Body;
      E015 := E015 + 1;
      System.Os_Lib'Elab_Body;
      E086 := E086 + 1;
      System.Secondary_Stack'Elab_Body;
      E019 := E019 + 1;
      System.Tasking.Initialization'Elab_Body;
      E217 := E217 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E148 := E148 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E059 := E059 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E189 := E189 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E213 := E213 + 1;
      System.Tasking.Queuing'Elab_Body;
      E225 := E225 + 1;
      System.Tasking.Stages'Elab_Body;
      E233 := E233 + 1;
      Adagraph'Elab_Spec;
      Adagraph'Elab_Body;
      E187 := E187 + 1;
      E239 := E239 + 1;
      Swindows'Elab_Spec;
      E241 := E241 + 1;
      Dio192defs'Elab_Spec;
      E112 := E112 + 1;
      E111 := E111 + 1;
      Simrail2'Elab_Spec;
      E243 := E243 + 1;
      Simtrack2'Elab_Spec;
      E178 := E178 + 1;
      Simtrack2.Display'Elab_Body;
      E185 := E185 + 1;
      Simrail2'Elab_Body;
      E120 := E120 + 1;
      Swindows'Elab_Body;
      E247 := E247 + 1;
      E257 := E257 + 1;
      turnout_driver'elab_body;
      E260 := E260 + 1;
      Slogger'Elab_Spec;
      Slogger'Elab_Body;
      E237 := E237 + 1;
      E116 := E116 + 1;
      Interrupt_Hdlr'Elab_Body;
      E245 := E245 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_lab3");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\Adagraph.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\logger_ada.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\Unsigned_Types.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\das08defs.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\raildefs.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\dda06defs.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\dac_driver.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\dio192defs.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\block_driver.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\int32defs.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\simdefs2.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\halls2.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\simtrack2.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\simtrack2-display.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\simrail2.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\Swindows.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\sound_manager.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\turnout_driver.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\slogger.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\Io_ports.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\interrupt_hdlr.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\lab3.o
   --   -LC:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\
   --   -LC:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\
   --   -LC:/gnat/2015/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
   --   -static
   --   -ladagraph
   --   -lgnarl
   --   -lgnat
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;

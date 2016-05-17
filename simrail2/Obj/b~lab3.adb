pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~lab3.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~lab3.adb");

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E154 : Short_Integer; pragma Import (Ada, E154, "system__fat_flt_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__fat_llf_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "ada__io_exceptions_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "ada__numerics_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__tags_E");
   E061 : Short_Integer; pragma Import (Ada, E061, "ada__streams_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "interfaces__c_E");
   E082 : Short_Integer; pragma Import (Ada, E082, "interfaces__c__strings_E");
   E031 : Short_Integer; pragma Import (Ada, E031, "system__exceptions_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "system__finalization_root_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "ada__finalization_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "system__storage_pools_E");
   E090 : Short_Integer; pragma Import (Ada, E090, "system__finalization_masters_E");
   E104 : Short_Integer; pragma Import (Ada, E104, "system__storage_pools__subpools_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "system__task_info_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "ada__calendar_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__calendar__delays_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "system__pool_global_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "system__file_control_block_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__file_io_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "system__random_seed_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__secondary_stack_E");
   E085 : Short_Integer; pragma Import (Ada, E085, "system__os_lib_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "system__tasking__initialization_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "system__tasking__protected_objects_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "ada__real_time_E");
   E060 : Short_Integer; pragma Import (Ada, E060, "ada__text_io_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "system__tasking__protected_objects__entries_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "system__tasking__queuing_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "system__tasking__stages_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "adagraph_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "logger_ada_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "swindows_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "interrupt_hdlr_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "io_ports_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "dac_driver_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "dio192defs_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "block_driver_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "halls2_E");
   E135 : Short_Integer; pragma Import (Ada, E135, "simrail2_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "simtrack2_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "simtrack2__display_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "turnout_driver_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "slogger_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "turnout_driver__finalize_body");
      begin
         E256 := E256 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "swindows__finalize_body");
      begin
         E254 := E254 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "simrail2__finalize_body");
      begin
         E135 := E135 - 1;
         F3;
      end;
      E224 := E224 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F4;
      end;
      E060 := E060 - 1;
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
         E075 := E075 - 1;
         F6;
      end;
      E090 := E090 - 1;
      E104 := E104 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "system__file_control_block__finalize_spec");
      begin
         E088 := E088 - 1;
         F7;
      end;
      E100 := E100 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__pool_global__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "system__storage_pools__subpools__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "system__finalization_masters__finalize_spec");
      begin
         F10;
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
   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
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
      Zero_Cost_Exceptions : Integer;
      pragma Import (C, Zero_Cost_Exceptions, "__gl_zero_cost_exceptions");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");

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
           False, False, False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (True, True, True, True, False, False, False, True, 
           False, True, True, True, True, False, False, True, 
           False, False, True, True, False, True, True, True, 
           True, True, True, False, True, True, False, True, 
           False, False, False, False, True, True, False, True, 
           False, True, True, False, True, False, False, False, 
           False, False, False, True, True, True, True, True, 
           False, False, True, False, False, True, False, True, 
           False, False, True, True, True, False, True, True, 
           True, True, True, False, True, False),
         Count => (2, 3, 2, 2, 0, 4, 0),
         Unknown => (False, False, False, False, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Zero_Cost_Exceptions := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Fat_Flt'Elab_Spec;
      E154 := E154 + 1;
      System.Fat_Llf'Elab_Spec;
      E142 := E142 + 1;
      System.Exception_Table'Elab_Body;
      E025 := E025 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E080 := E080 + 1;
      Ada.Numerics'Elab_Spec;
      E155 := E155 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E061 := E061 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E031 := E031 + 1;
      System.Finalization_Root'Elab_Spec;
      E079 := E079 + 1;
      Ada.Finalization'Elab_Spec;
      E077 := E077 + 1;
      System.Storage_Pools'Elab_Spec;
      E098 := E098 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Task_Info'Elab_Spec;
      E179 := E179 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E008 := E008 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E006 := E006 + 1;
      System.Pool_Global'Elab_Spec;
      E100 := E100 + 1;
      System.File_Control_Block'Elab_Spec;
      E088 := E088 + 1;
      System.Random_Seed'Elab_Body;
      E161 := E161 + 1;
      E104 := E104 + 1;
      System.Finalization_Masters'Elab_Body;
      E090 := E090 + 1;
      E082 := E082 + 1;
      E050 := E050 + 1;
      Ada.Tags'Elab_Body;
      E063 := E063 + 1;
      System.Soft_Links'Elab_Body;
      E015 := E015 + 1;
      System.Secondary_Stack'Elab_Body;
      E019 := E019 + 1;
      System.Os_Lib'Elab_Body;
      E085 := E085 + 1;
      System.File_Io'Elab_Body;
      E075 := E075 + 1;
      System.Tasking.Initialization'Elab_Body;
      E228 := E228 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E208 := E208 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E163 := E163 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E060 := E060 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E224 := E224 + 1;
      System.Tasking.Queuing'Elab_Body;
      E234 := E234 + 1;
      System.Tasking.Stages'Elab_Body;
      E242 := E242 + 1;
      Adagraph'Elab_Spec;
      Adagraph'Elab_Body;
      E206 := E206 + 1;
      E246 := E246 + 1;
      Swindows'Elab_Spec;
      E248 := E248 + 1;
      Dio192defs'Elab_Spec;
      E127 := E127 + 1;
      E126 := E126 + 1;
      Simrail2'Elab_Spec;
      E250 := E250 + 1;
      Simtrack2'Elab_Spec;
      E197 := E197 + 1;
      Simtrack2.Display'Elab_Body;
      E204 := E204 + 1;
      Simrail2'Elab_Body;
      E135 := E135 + 1;
      Swindows'Elab_Body;
      E254 := E254 + 1;
      turnout_driver'elab_body;
      E256 := E256 + 1;
      Slogger'Elab_Spec;
      Slogger'Elab_Body;
      E244 := E244 + 1;
      E131 := E131 + 1;
      Interrupt_Hdlr'Elab_Body;
      E252 := E252 + 1;
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
   --   C:\Users\6963838\Desktop\simrail2\Obj\Adagraph.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\logger_ada.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\Unsigned_Types.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\raildefs.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\dda06defs.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\dac_driver.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\dio192defs.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\block_driver.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\int32defs.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\simdefs2.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\halls2.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\simtrack2.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\simtrack2-display.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\simrail2.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\Swindows.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\turnout_driver.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\slogger.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\Io_ports.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\interrupt_hdlr.o
   --   C:\Users\6963838\Desktop\simrail2\Obj\lab3.o
   --   -LC:\Users\6963838\Desktop\simrail2\Obj\
   --   -LC:/apps/GNAT/lib/gcc/i686-pc-mingw32/4.5.4/adalib/
   --   -ladagraph
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;

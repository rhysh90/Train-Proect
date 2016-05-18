pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__testwid.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__testwid.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E089 : Short_Integer; pragma Import (Ada, E089, "system__os_lib_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E111 : Short_Integer; pragma Import (Ada, E111, "system__fat_flt_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "system__fat_llf_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exception_table_E");
   E065 : Short_Integer; pragma Import (Ada, E065, "ada__io_exceptions_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "ada__tags_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "ada__streams_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "interfaces__c_E");
   E121 : Short_Integer; pragma Import (Ada, E121, "interfaces__c__strings_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exceptions_E");
   E092 : Short_Integer; pragma Import (Ada, E092, "system__file_control_block_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "system__file_io_E");
   E087 : Short_Integer; pragma Import (Ada, E087, "system__finalization_root_E");
   E085 : Short_Integer; pragma Import (Ada, E085, "ada__finalization_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "system__task_info_E");
   E007 : Short_Integer; pragma Import (Ada, E007, "ada__calendar_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__calendar__delays_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__secondary_stack_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "system__tasking__initialization_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "ada__real_time_E");
   E062 : Short_Integer; pragma Import (Ada, E062, "ada__text_io_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "system__tasking__protected_objects_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "system__tasking__protected_objects__entries_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "system__tasking__queuing_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "system__tasking__stages_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "exec_load_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "widget_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "widget__finalize_body");
      begin
         E058 := E058 - 1;
         F1;
      end;
      E155 := E155 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F2;
      end;
      E062 := E062 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "ada__text_io__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__file_io__finalize_body");
      begin
         E083 := E083 - 1;
         F4;
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
          (False, False, False, True, True, False, False, True, 
           False, False, True, True, True, True, False, False, 
           True, False, False, True, True, False, True, True, 
           False, True, True, True, True, False, False, True, 
           False, True, False, False, True, False, False, False, 
           True, True, False, True, False, True, False, False, 
           False, True, False, False, False, False, False, False, 
           True, False, True, True, True, False, False, True, 
           False, False, True, False, True, True, False, True, 
           True, True, False, True, False, False, False, True, 
           False, False, True, False, True, False),
         Count => (0, 0, 0, 1, 0, 0, 1, 0, 1, 0),
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
      E111 := E111 + 1;
      System.Fat_Llf'Elab_Spec;
      E099 := E099 + 1;
      System.Exception_Table'Elab_Body;
      E025 := E025 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E065 := E065 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E064 := E064 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E027 := E027 + 1;
      System.File_Control_Block'Elab_Spec;
      E092 := E092 + 1;
      System.Finalization_Root'Elab_Spec;
      E087 := E087 + 1;
      Ada.Finalization'Elab_Spec;
      E085 := E085 + 1;
      System.Task_Info'Elab_Spec;
      E129 := E129 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E007 := E007 + 1;
      Ada.Calendar.Delays'Elab_Body;
      E005 := E005 + 1;
      System.File_Io'Elab_Body;
      E083 := E083 + 1;
      E121 := E121 + 1;
      E047 := E047 + 1;
      Ada.Tags'Elab_Body;
      E067 := E067 + 1;
      System.Soft_Links'Elab_Body;
      E015 := E015 + 1;
      System.Os_Lib'Elab_Body;
      E089 := E089 + 1;
      System.Secondary_Stack'Elab_Body;
      E019 := E019 + 1;
      System.Tasking.Initialization'Elab_Body;
      E159 := E159 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E113 := E113 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E062 := E062 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E149 := E149 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E155 := E155 + 1;
      System.Tasking.Queuing'Elab_Body;
      E167 := E167 + 1;
      System.Tasking.Stages'Elab_Body;
      E175 := E175 + 1;
      Exec_Load'Elab_Body;
      E143 := E143 + 1;
      Widget'Elab_Body;
      E058 := E058 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_testwid");

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
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\exec_load.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\Projdefs.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\Widget.o
   --   C:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\TestWid.o
   --   -LC:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\
   --   -LC:\Users\69640_000\Documents\GitHub\Train Proect\simrail2\Obj\
   --   -LC:/gnat/2015/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;

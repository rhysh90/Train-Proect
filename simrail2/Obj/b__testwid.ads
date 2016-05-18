pragma Ada_95;
with System;
package ada_main is
   pragma Warnings (Off);

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2015 (20150428-49)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_testwid" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#126e248e#;
   pragma Export (C, u00001, "testwidB");
   u00002 : constant Version_32 := 16#fbff4c67#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#f72f352b#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#030467d8#;
   pragma Export (C, u00004, "ada__calendar__delaysB");
   u00005 : constant Version_32 := 16#46a66b2f#;
   pragma Export (C, u00005, "ada__calendar__delaysS");
   u00006 : constant Version_32 := 16#649a98f6#;
   pragma Export (C, u00006, "ada__calendarB");
   u00007 : constant Version_32 := 16#e67a5d0a#;
   pragma Export (C, u00007, "ada__calendarS");
   u00008 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00008, "adaS");
   u00009 : constant Version_32 := 16#b612ca65#;
   pragma Export (C, u00009, "ada__exceptionsB");
   u00010 : constant Version_32 := 16#1d190453#;
   pragma Export (C, u00010, "ada__exceptionsS");
   u00011 : constant Version_32 := 16#a46739c0#;
   pragma Export (C, u00011, "ada__exceptions__last_chance_handlerB");
   u00012 : constant Version_32 := 16#3aac8c92#;
   pragma Export (C, u00012, "ada__exceptions__last_chance_handlerS");
   u00013 : constant Version_32 := 16#f4ce8c3a#;
   pragma Export (C, u00013, "systemS");
   u00014 : constant Version_32 := 16#a207fefe#;
   pragma Export (C, u00014, "system__soft_linksB");
   u00015 : constant Version_32 := 16#af945ded#;
   pragma Export (C, u00015, "system__soft_linksS");
   u00016 : constant Version_32 := 16#b01dad17#;
   pragma Export (C, u00016, "system__parametersB");
   u00017 : constant Version_32 := 16#8ae48145#;
   pragma Export (C, u00017, "system__parametersS");
   u00018 : constant Version_32 := 16#b19b6653#;
   pragma Export (C, u00018, "system__secondary_stackB");
   u00019 : constant Version_32 := 16#5faf4353#;
   pragma Export (C, u00019, "system__secondary_stackS");
   u00020 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00020, "system__storage_elementsB");
   u00021 : constant Version_32 := 16#d90dc63e#;
   pragma Export (C, u00021, "system__storage_elementsS");
   u00022 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00022, "system__stack_checkingB");
   u00023 : constant Version_32 := 16#7a71e7d2#;
   pragma Export (C, u00023, "system__stack_checkingS");
   u00024 : constant Version_32 := 16#393398c1#;
   pragma Export (C, u00024, "system__exception_tableB");
   u00025 : constant Version_32 := 16#5ad7ea2f#;
   pragma Export (C, u00025, "system__exception_tableS");
   u00026 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00026, "system__exceptionsB");
   u00027 : constant Version_32 := 16#9cade1cc#;
   pragma Export (C, u00027, "system__exceptionsS");
   u00028 : constant Version_32 := 16#37d758f1#;
   pragma Export (C, u00028, "system__exceptions__machineS");
   u00029 : constant Version_32 := 16#b895431d#;
   pragma Export (C, u00029, "system__exceptions_debugB");
   u00030 : constant Version_32 := 16#472c9584#;
   pragma Export (C, u00030, "system__exceptions_debugS");
   u00031 : constant Version_32 := 16#570325c8#;
   pragma Export (C, u00031, "system__img_intB");
   u00032 : constant Version_32 := 16#f6156cf8#;
   pragma Export (C, u00032, "system__img_intS");
   u00033 : constant Version_32 := 16#b98c3e16#;
   pragma Export (C, u00033, "system__tracebackB");
   u00034 : constant Version_32 := 16#6af355e1#;
   pragma Export (C, u00034, "system__tracebackS");
   u00035 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00035, "system__traceback_entriesB");
   u00036 : constant Version_32 := 16#f4957a4a#;
   pragma Export (C, u00036, "system__traceback_entriesS");
   u00037 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00037, "system__wch_conB");
   u00038 : constant Version_32 := 16#efb3aee8#;
   pragma Export (C, u00038, "system__wch_conS");
   u00039 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00039, "system__wch_stwB");
   u00040 : constant Version_32 := 16#c2a282e9#;
   pragma Export (C, u00040, "system__wch_stwS");
   u00041 : constant Version_32 := 16#92b797cb#;
   pragma Export (C, u00041, "system__wch_cnvB");
   u00042 : constant Version_32 := 16#e004141b#;
   pragma Export (C, u00042, "system__wch_cnvS");
   u00043 : constant Version_32 := 16#6033a23f#;
   pragma Export (C, u00043, "interfacesS");
   u00044 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00044, "system__wch_jisB");
   u00045 : constant Version_32 := 16#60740d3a#;
   pragma Export (C, u00045, "system__wch_jisS");
   u00046 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00046, "interfaces__cB");
   u00047 : constant Version_32 := 16#4a38bedb#;
   pragma Export (C, u00047, "interfaces__cS");
   u00048 : constant Version_32 := 16#f4bb3578#;
   pragma Export (C, u00048, "system__os_primitivesB");
   u00049 : constant Version_32 := 16#441f0013#;
   pragma Export (C, u00049, "system__os_primitivesS");
   u00050 : constant Version_32 := 16#0881bbf8#;
   pragma Export (C, u00050, "system__task_lockB");
   u00051 : constant Version_32 := 16#9544bb54#;
   pragma Export (C, u00051, "system__task_lockS");
   u00052 : constant Version_32 := 16#1716ff24#;
   pragma Export (C, u00052, "system__win32S");
   u00053 : constant Version_32 := 16#1a9147da#;
   pragma Export (C, u00053, "system__win32__extS");
   u00054 : constant Version_32 := 16#ee80728a#;
   pragma Export (C, u00054, "system__tracesB");
   u00055 : constant Version_32 := 16#06d3e490#;
   pragma Export (C, u00055, "system__tracesS");
   u00056 : constant Version_32 := 16#6d055b07#;
   pragma Export (C, u00056, "projdefsS");
   u00057 : constant Version_32 := 16#3699a5c7#;
   pragma Export (C, u00057, "widgetB");
   u00058 : constant Version_32 := 16#08ba5310#;
   pragma Export (C, u00058, "widgetS");
   u00059 : constant Version_32 := 16#e18a47a0#;
   pragma Export (C, u00059, "ada__float_text_ioB");
   u00060 : constant Version_32 := 16#e61b3c6c#;
   pragma Export (C, u00060, "ada__float_text_ioS");
   u00061 : constant Version_32 := 16#28f088c2#;
   pragma Export (C, u00061, "ada__text_ioB");
   u00062 : constant Version_32 := 16#1a9b0017#;
   pragma Export (C, u00062, "ada__text_ioS");
   u00063 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00063, "ada__streamsB");
   u00064 : constant Version_32 := 16#2e6701ab#;
   pragma Export (C, u00064, "ada__streamsS");
   u00065 : constant Version_32 := 16#db5c917c#;
   pragma Export (C, u00065, "ada__io_exceptionsS");
   u00066 : constant Version_32 := 16#12c8cd7d#;
   pragma Export (C, u00066, "ada__tagsB");
   u00067 : constant Version_32 := 16#ce72c228#;
   pragma Export (C, u00067, "ada__tagsS");
   u00068 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00068, "system__htableB");
   u00069 : constant Version_32 := 16#700c3fd0#;
   pragma Export (C, u00069, "system__htableS");
   u00070 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00070, "system__string_hashB");
   u00071 : constant Version_32 := 16#d25254ae#;
   pragma Export (C, u00071, "system__string_hashS");
   u00072 : constant Version_32 := 16#699628fa#;
   pragma Export (C, u00072, "system__unsigned_typesS");
   u00073 : constant Version_32 := 16#b44f9ae7#;
   pragma Export (C, u00073, "system__val_unsB");
   u00074 : constant Version_32 := 16#793ec5c1#;
   pragma Export (C, u00074, "system__val_unsS");
   u00075 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00075, "system__val_utilB");
   u00076 : constant Version_32 := 16#586e3ac4#;
   pragma Export (C, u00076, "system__val_utilS");
   u00077 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00077, "system__case_utilB");
   u00078 : constant Version_32 := 16#d0c7e5ed#;
   pragma Export (C, u00078, "system__case_utilS");
   u00079 : constant Version_32 := 16#84a27f0d#;
   pragma Export (C, u00079, "interfaces__c_streamsB");
   u00080 : constant Version_32 := 16#8bb5f2c0#;
   pragma Export (C, u00080, "interfaces__c_streamsS");
   u00081 : constant Version_32 := 16#845f5a34#;
   pragma Export (C, u00081, "system__crtlS");
   u00082 : constant Version_32 := 16#431faf3c#;
   pragma Export (C, u00082, "system__file_ioB");
   u00083 : constant Version_32 := 16#53bf6d5f#;
   pragma Export (C, u00083, "system__file_ioS");
   u00084 : constant Version_32 := 16#b7ab275c#;
   pragma Export (C, u00084, "ada__finalizationB");
   u00085 : constant Version_32 := 16#19f764ca#;
   pragma Export (C, u00085, "ada__finalizationS");
   u00086 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00086, "system__finalization_rootB");
   u00087 : constant Version_32 := 16#bb3cffaa#;
   pragma Export (C, u00087, "system__finalization_rootS");
   u00088 : constant Version_32 := 16#ee0f26dd#;
   pragma Export (C, u00088, "system__os_libB");
   u00089 : constant Version_32 := 16#d7b69782#;
   pragma Export (C, u00089, "system__os_libS");
   u00090 : constant Version_32 := 16#1a817b8e#;
   pragma Export (C, u00090, "system__stringsB");
   u00091 : constant Version_32 := 16#8a719d5c#;
   pragma Export (C, u00091, "system__stringsS");
   u00092 : constant Version_32 := 16#09511692#;
   pragma Export (C, u00092, "system__file_control_blockS");
   u00093 : constant Version_32 := 16#d5f9759f#;
   pragma Export (C, u00093, "ada__text_io__float_auxB");
   u00094 : constant Version_32 := 16#f854caf5#;
   pragma Export (C, u00094, "ada__text_io__float_auxS");
   u00095 : constant Version_32 := 16#181dc502#;
   pragma Export (C, u00095, "ada__text_io__generic_auxB");
   u00096 : constant Version_32 := 16#a6c327d3#;
   pragma Export (C, u00096, "ada__text_io__generic_auxS");
   u00097 : constant Version_32 := 16#f0df9003#;
   pragma Export (C, u00097, "system__img_realB");
   u00098 : constant Version_32 := 16#3366ddd8#;
   pragma Export (C, u00098, "system__img_realS");
   u00099 : constant Version_32 := 16#f05937c9#;
   pragma Export (C, u00099, "system__fat_llfS");
   u00100 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00100, "system__float_controlB");
   u00101 : constant Version_32 := 16#1432cf06#;
   pragma Export (C, u00101, "system__float_controlS");
   u00102 : constant Version_32 := 16#f1f88835#;
   pragma Export (C, u00102, "system__img_lluB");
   u00103 : constant Version_32 := 16#205f2839#;
   pragma Export (C, u00103, "system__img_lluS");
   u00104 : constant Version_32 := 16#eef535cd#;
   pragma Export (C, u00104, "system__img_unsB");
   u00105 : constant Version_32 := 16#f662140d#;
   pragma Export (C, u00105, "system__img_unsS");
   u00106 : constant Version_32 := 16#a4beea4d#;
   pragma Export (C, u00106, "system__powten_tableS");
   u00107 : constant Version_32 := 16#faa9a7b2#;
   pragma Export (C, u00107, "system__val_realB");
   u00108 : constant Version_32 := 16#0ae7fb2b#;
   pragma Export (C, u00108, "system__val_realS");
   u00109 : constant Version_32 := 16#6c05c057#;
   pragma Export (C, u00109, "system__exn_llfB");
   u00110 : constant Version_32 := 16#48b037e6#;
   pragma Export (C, u00110, "system__exn_llfS");
   u00111 : constant Version_32 := 16#acbb902e#;
   pragma Export (C, u00111, "system__fat_fltS");
   u00112 : constant Version_32 := 16#91613c5c#;
   pragma Export (C, u00112, "ada__real_timeB");
   u00113 : constant Version_32 := 16#87ade2f4#;
   pragma Export (C, u00113, "ada__real_timeS");
   u00114 : constant Version_32 := 16#1f99af62#;
   pragma Export (C, u00114, "system__arith_64B");
   u00115 : constant Version_32 := 16#d4b08bf7#;
   pragma Export (C, u00115, "system__arith_64S");
   u00116 : constant Version_32 := 16#30bb6e97#;
   pragma Export (C, u00116, "system__taskingB");
   u00117 : constant Version_32 := 16#8d6ada58#;
   pragma Export (C, u00117, "system__taskingS");
   u00118 : constant Version_32 := 16#01715bc2#;
   pragma Export (C, u00118, "system__task_primitivesS");
   u00119 : constant Version_32 := 16#f4bb5b54#;
   pragma Export (C, u00119, "system__os_interfaceS");
   u00120 : constant Version_32 := 16#2c7d263c#;
   pragma Export (C, u00120, "interfaces__c__stringsB");
   u00121 : constant Version_32 := 16#603c1c44#;
   pragma Export (C, u00121, "interfaces__c__stringsS");
   u00122 : constant Version_32 := 16#e2725713#;
   pragma Export (C, u00122, "system__task_primitives__operationsB");
   u00123 : constant Version_32 := 16#12291044#;
   pragma Export (C, u00123, "system__task_primitives__operationsS");
   u00124 : constant Version_32 := 16#da8ccc08#;
   pragma Export (C, u00124, "system__interrupt_managementB");
   u00125 : constant Version_32 := 16#c90ea50e#;
   pragma Export (C, u00125, "system__interrupt_managementS");
   u00126 : constant Version_32 := 16#f65595cf#;
   pragma Export (C, u00126, "system__multiprocessorsB");
   u00127 : constant Version_32 := 16#cc621349#;
   pragma Export (C, u00127, "system__multiprocessorsS");
   u00128 : constant Version_32 := 16#77769007#;
   pragma Export (C, u00128, "system__task_infoB");
   u00129 : constant Version_32 := 16#232885cd#;
   pragma Export (C, u00129, "system__task_infoS");
   u00130 : constant Version_32 := 16#ab9ad34e#;
   pragma Export (C, u00130, "system__tasking__debugB");
   u00131 : constant Version_32 := 16#f1f2435f#;
   pragma Export (C, u00131, "system__tasking__debugS");
   u00132 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00132, "system__concat_2B");
   u00133 : constant Version_32 := 16#f66e5bea#;
   pragma Export (C, u00133, "system__concat_2S");
   u00134 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00134, "system__concat_3B");
   u00135 : constant Version_32 := 16#ffbed09f#;
   pragma Export (C, u00135, "system__concat_3S");
   u00136 : constant Version_32 := 16#d0432c8d#;
   pragma Export (C, u00136, "system__img_enum_newB");
   u00137 : constant Version_32 := 16#95828afa#;
   pragma Export (C, u00137, "system__img_enum_newS");
   u00138 : constant Version_32 := 16#118e865d#;
   pragma Export (C, u00138, "system__stack_usageB");
   u00139 : constant Version_32 := 16#00bc3311#;
   pragma Export (C, u00139, "system__stack_usageS");
   u00140 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00140, "system__ioB");
   u00141 : constant Version_32 := 16#6a8c7b75#;
   pragma Export (C, u00141, "system__ioS");
   u00142 : constant Version_32 := 16#aae0185d#;
   pragma Export (C, u00142, "exec_loadB");
   u00143 : constant Version_32 := 16#482fa4fb#;
   pragma Export (C, u00143, "exec_loadS");
   u00144 : constant Version_32 := 16#f533f6df#;
   pragma Export (C, u00144, "calendarS");
   u00145 : constant Version_32 := 16#7dbbd31d#;
   pragma Export (C, u00145, "text_ioS");
   u00146 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00146, "system__img_boolB");
   u00147 : constant Version_32 := 16#0117fdd1#;
   pragma Export (C, u00147, "system__img_boolS");
   u00148 : constant Version_32 := 16#5933ea28#;
   pragma Export (C, u00148, "system__tasking__protected_objectsB");
   u00149 : constant Version_32 := 16#63b50013#;
   pragma Export (C, u00149, "system__tasking__protected_objectsS");
   u00150 : constant Version_32 := 16#001f972c#;
   pragma Export (C, u00150, "system__soft_links__taskingB");
   u00151 : constant Version_32 := 16#e47ef8be#;
   pragma Export (C, u00151, "system__soft_links__taskingS");
   u00152 : constant Version_32 := 16#17d21067#;
   pragma Export (C, u00152, "ada__exceptions__is_null_occurrenceB");
   u00153 : constant Version_32 := 16#9a9e8fd3#;
   pragma Export (C, u00153, "ada__exceptions__is_null_occurrenceS");
   u00154 : constant Version_32 := 16#3ea9332d#;
   pragma Export (C, u00154, "system__tasking__protected_objects__entriesB");
   u00155 : constant Version_32 := 16#7671a6ef#;
   pragma Export (C, u00155, "system__tasking__protected_objects__entriesS");
   u00156 : constant Version_32 := 16#100eaf58#;
   pragma Export (C, u00156, "system__restrictionsB");
   u00157 : constant Version_32 := 16#efa60774#;
   pragma Export (C, u00157, "system__restrictionsS");
   u00158 : constant Version_32 := 16#92d5df45#;
   pragma Export (C, u00158, "system__tasking__initializationB");
   u00159 : constant Version_32 := 16#d9930fa8#;
   pragma Export (C, u00159, "system__tasking__initializationS");
   u00160 : constant Version_32 := 16#d89f9b67#;
   pragma Export (C, u00160, "system__tasking__task_attributesB");
   u00161 : constant Version_32 := 16#952bcf5e#;
   pragma Export (C, u00161, "system__tasking__task_attributesS");
   u00162 : constant Version_32 := 16#6f8919f6#;
   pragma Export (C, u00162, "system__tasking__protected_objects__operationsB");
   u00163 : constant Version_32 := 16#eb67f071#;
   pragma Export (C, u00163, "system__tasking__protected_objects__operationsS");
   u00164 : constant Version_32 := 16#72d3cb03#;
   pragma Export (C, u00164, "system__tasking__entry_callsB");
   u00165 : constant Version_32 := 16#e903595c#;
   pragma Export (C, u00165, "system__tasking__entry_callsS");
   u00166 : constant Version_32 := 16#94c4f9d9#;
   pragma Export (C, u00166, "system__tasking__queuingB");
   u00167 : constant Version_32 := 16#3117b7f1#;
   pragma Export (C, u00167, "system__tasking__queuingS");
   u00168 : constant Version_32 := 16#c6ee4b22#;
   pragma Export (C, u00168, "system__tasking__utilitiesB");
   u00169 : constant Version_32 := 16#ea41a805#;
   pragma Export (C, u00169, "system__tasking__utilitiesS");
   u00170 : constant Version_32 := 16#bd6fc52e#;
   pragma Export (C, u00170, "system__traces__taskingB");
   u00171 : constant Version_32 := 16#3fb127e5#;
   pragma Export (C, u00171, "system__traces__taskingS");
   u00172 : constant Version_32 := 16#3cc73d8e#;
   pragma Export (C, u00172, "system__tasking__rendezvousB");
   u00173 : constant Version_32 := 16#71fce298#;
   pragma Export (C, u00173, "system__tasking__rendezvousS");
   u00174 : constant Version_32 := 16#d6fbdf05#;
   pragma Export (C, u00174, "system__tasking__stagesB");
   u00175 : constant Version_32 := 16#f8a082a4#;
   pragma Export (C, u00175, "system__tasking__stagesS");
   u00176 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00176, "system__address_imageB");
   u00177 : constant Version_32 := 16#55221100#;
   pragma Export (C, u00177, "system__address_imageS");
   u00178 : constant Version_32 := 16#2bce1226#;
   pragma Export (C, u00178, "system__memoryB");
   u00179 : constant Version_32 := 16#adb3ea0e#;
   pragma Export (C, u00179, "system__memoryS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  system%s
   --  system.arith_64%s
   --  system.case_util%s
   --  system.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.htable%s
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_real%s
   --  system.io%s
   --  system.io%b
   --  system.multiprocessors%s
   --  system.os_primitives%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.restrictions%s
   --  system.restrictions%b
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.stack_usage%s
   --  system.stack_usage%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.os_lib%s
   --  system.task_lock%s
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.arith_64%b
   --  ada.exceptions.is_null_occurrence%s
   --  ada.exceptions.is_null_occurrence%b
   --  system.soft_links%s
   --  system.task_lock%b
   --  system.traces%s
   --  system.traces%b
   --  system.unsigned_types%s
   --  system.fat_flt%s
   --  system.fat_llf%s
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.img_real%b
   --  system.val_real%s
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.val_real%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  system.address_image%s
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.io_exceptions%s
   --  ada.tags%s
   --  ada.streams%s
   --  ada.streams%b
   --  interfaces.c%s
   --  system.multiprocessors%b
   --  interfaces.c.strings%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.file_control_block%s
   --  system.file_io%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  ada.finalization%b
   --  system.win32%s
   --  system.os_interface%s
   --  system.interrupt_management%s
   --  system.interrupt_management%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.tasking%s
   --  system.task_primitives.operations%s
   --  system.tasking%b
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.traces.tasking%s
   --  system.traces.tasking%b
   --  system.win32.ext%s
   --  system.task_primitives.operations%b
   --  system.os_primitives%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.delays%s
   --  ada.calendar.delays%b
   --  calendar%s
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.secondary_stack%s
   --  system.file_io%b
   --  interfaces.c.strings%b
   --  interfaces.c%b
   --  ada.tags%b
   --  system.soft_links%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.address_image%b
   --  system.soft_links.tasking%s
   --  system.soft_links.tasking%b
   --  system.tasking.entry_calls%s
   --  system.tasking.initialization%s
   --  system.tasking.task_attributes%s
   --  system.tasking.task_attributes%b
   --  system.tasking.utilities%s
   --  system.traceback%s
   --  ada.exceptions%b
   --  system.traceback%b
   --  system.tasking.initialization%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.text_io.float_aux%s
   --  ada.float_text_io%s
   --  ada.float_text_io%b
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  ada.text_io.float_aux%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.protected_objects.entries%s
   --  system.tasking.protected_objects.entries%b
   --  system.tasking.queuing%s
   --  system.tasking.queuing%b
   --  system.tasking.utilities%b
   --  system.tasking.rendezvous%s
   --  system.tasking.protected_objects.operations%s
   --  system.tasking.protected_objects.operations%b
   --  system.tasking.rendezvous%b
   --  system.tasking.entry_calls%b
   --  system.tasking.stages%s
   --  system.tasking.stages%b
   --  text_io%s
   --  exec_load%s
   --  exec_load%b
   --  projdefs%s
   --  widget%s
   --  widget%b
   --  testwid%b
   --  END ELABORATION ORDER


end ada_main;

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

   Ada_Main_Program_Name : constant String := "_ada_lab3" & ASCII.NUL;
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
   u00001 : constant Version_32 := 16#39b4559b#;
   pragma Export (C, u00001, "lab3B");
   u00002 : constant Version_32 := 16#fbff4c67#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#f72f352b#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#030467d8#;
   pragma Export (C, u00005, "ada__calendar__delaysB");
   u00006 : constant Version_32 := 16#46a66b2f#;
   pragma Export (C, u00006, "ada__calendar__delaysS");
   u00007 : constant Version_32 := 16#649a98f6#;
   pragma Export (C, u00007, "ada__calendarB");
   u00008 : constant Version_32 := 16#e67a5d0a#;
   pragma Export (C, u00008, "ada__calendarS");
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
   u00056 : constant Version_32 := 16#f64b89a4#;
   pragma Export (C, u00056, "ada__integer_text_ioB");
   u00057 : constant Version_32 := 16#f1daf268#;
   pragma Export (C, u00057, "ada__integer_text_ioS");
   u00058 : constant Version_32 := 16#28f088c2#;
   pragma Export (C, u00058, "ada__text_ioB");
   u00059 : constant Version_32 := 16#1a9b0017#;
   pragma Export (C, u00059, "ada__text_ioS");
   u00060 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00060, "ada__streamsB");
   u00061 : constant Version_32 := 16#2e6701ab#;
   pragma Export (C, u00061, "ada__streamsS");
   u00062 : constant Version_32 := 16#db5c917c#;
   pragma Export (C, u00062, "ada__io_exceptionsS");
   u00063 : constant Version_32 := 16#12c8cd7d#;
   pragma Export (C, u00063, "ada__tagsB");
   u00064 : constant Version_32 := 16#ce72c228#;
   pragma Export (C, u00064, "ada__tagsS");
   u00065 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00065, "system__htableB");
   u00066 : constant Version_32 := 16#700c3fd0#;
   pragma Export (C, u00066, "system__htableS");
   u00067 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00067, "system__string_hashB");
   u00068 : constant Version_32 := 16#d25254ae#;
   pragma Export (C, u00068, "system__string_hashS");
   u00069 : constant Version_32 := 16#699628fa#;
   pragma Export (C, u00069, "system__unsigned_typesS");
   u00070 : constant Version_32 := 16#b44f9ae7#;
   pragma Export (C, u00070, "system__val_unsB");
   u00071 : constant Version_32 := 16#793ec5c1#;
   pragma Export (C, u00071, "system__val_unsS");
   u00072 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00072, "system__val_utilB");
   u00073 : constant Version_32 := 16#586e3ac4#;
   pragma Export (C, u00073, "system__val_utilS");
   u00074 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00074, "system__case_utilB");
   u00075 : constant Version_32 := 16#d0c7e5ed#;
   pragma Export (C, u00075, "system__case_utilS");
   u00076 : constant Version_32 := 16#84a27f0d#;
   pragma Export (C, u00076, "interfaces__c_streamsB");
   u00077 : constant Version_32 := 16#8bb5f2c0#;
   pragma Export (C, u00077, "interfaces__c_streamsS");
   u00078 : constant Version_32 := 16#845f5a34#;
   pragma Export (C, u00078, "system__crtlS");
   u00079 : constant Version_32 := 16#431faf3c#;
   pragma Export (C, u00079, "system__file_ioB");
   u00080 : constant Version_32 := 16#53bf6d5f#;
   pragma Export (C, u00080, "system__file_ioS");
   u00081 : constant Version_32 := 16#b7ab275c#;
   pragma Export (C, u00081, "ada__finalizationB");
   u00082 : constant Version_32 := 16#19f764ca#;
   pragma Export (C, u00082, "ada__finalizationS");
   u00083 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00083, "system__finalization_rootB");
   u00084 : constant Version_32 := 16#bb3cffaa#;
   pragma Export (C, u00084, "system__finalization_rootS");
   u00085 : constant Version_32 := 16#ee0f26dd#;
   pragma Export (C, u00085, "system__os_libB");
   u00086 : constant Version_32 := 16#d7b69782#;
   pragma Export (C, u00086, "system__os_libS");
   u00087 : constant Version_32 := 16#1a817b8e#;
   pragma Export (C, u00087, "system__stringsB");
   u00088 : constant Version_32 := 16#8a719d5c#;
   pragma Export (C, u00088, "system__stringsS");
   u00089 : constant Version_32 := 16#09511692#;
   pragma Export (C, u00089, "system__file_control_blockS");
   u00090 : constant Version_32 := 16#f6fdca1c#;
   pragma Export (C, u00090, "ada__text_io__integer_auxB");
   u00091 : constant Version_32 := 16#b9793d30#;
   pragma Export (C, u00091, "ada__text_io__integer_auxS");
   u00092 : constant Version_32 := 16#181dc502#;
   pragma Export (C, u00092, "ada__text_io__generic_auxB");
   u00093 : constant Version_32 := 16#a6c327d3#;
   pragma Export (C, u00093, "ada__text_io__generic_auxS");
   u00094 : constant Version_32 := 16#18d57884#;
   pragma Export (C, u00094, "system__img_biuB");
   u00095 : constant Version_32 := 16#afb4a0b7#;
   pragma Export (C, u00095, "system__img_biuS");
   u00096 : constant Version_32 := 16#e7d8734f#;
   pragma Export (C, u00096, "system__img_llbB");
   u00097 : constant Version_32 := 16#ee73b049#;
   pragma Export (C, u00097, "system__img_llbS");
   u00098 : constant Version_32 := 16#9777733a#;
   pragma Export (C, u00098, "system__img_lliB");
   u00099 : constant Version_32 := 16#e581d9eb#;
   pragma Export (C, u00099, "system__img_lliS");
   u00100 : constant Version_32 := 16#0e8808d4#;
   pragma Export (C, u00100, "system__img_llwB");
   u00101 : constant Version_32 := 16#471f93df#;
   pragma Export (C, u00101, "system__img_llwS");
   u00102 : constant Version_32 := 16#428b07f8#;
   pragma Export (C, u00102, "system__img_wiuB");
   u00103 : constant Version_32 := 16#c1f52725#;
   pragma Export (C, u00103, "system__img_wiuS");
   u00104 : constant Version_32 := 16#7ebd8839#;
   pragma Export (C, u00104, "system__val_intB");
   u00105 : constant Version_32 := 16#bc6ba605#;
   pragma Export (C, u00105, "system__val_intS");
   u00106 : constant Version_32 := 16#b3aa7b17#;
   pragma Export (C, u00106, "system__val_lliB");
   u00107 : constant Version_32 := 16#6eea6a9a#;
   pragma Export (C, u00107, "system__val_lliS");
   u00108 : constant Version_32 := 16#06052bd0#;
   pragma Export (C, u00108, "system__val_lluB");
   u00109 : constant Version_32 := 16#13647f88#;
   pragma Export (C, u00109, "system__val_lluS");
   u00110 : constant Version_32 := 16#ef6b6121#;
   pragma Export (C, u00110, "block_driverB");
   u00111 : constant Version_32 := 16#08bebdf0#;
   pragma Export (C, u00111, "block_driverS");
   u00112 : constant Version_32 := 16#6126b02c#;
   pragma Export (C, u00112, "dio192defsS");
   u00113 : constant Version_32 := 16#55c514bd#;
   pragma Export (C, u00113, "raildefsS");
   u00114 : constant Version_32 := 16#8a0726ac#;
   pragma Export (C, u00114, "unsigned_typesS");
   u00115 : constant Version_32 := 16#42e390f5#;
   pragma Export (C, u00115, "io_portsB");
   u00116 : constant Version_32 := 16#6e2ad8e5#;
   pragma Export (C, u00116, "io_portsS");
   u00117 : constant Version_32 := 16#70d23530#;
   pragma Export (C, u00117, "dda06defsS");
   u00118 : constant Version_32 := 16#4047cdf3#;
   pragma Export (C, u00118, "int32defsS");
   u00119 : constant Version_32 := 16#711c1115#;
   pragma Export (C, u00119, "simrail2B");
   u00120 : constant Version_32 := 16#39d6f0ed#;
   pragma Export (C, u00120, "simrail2S");
   u00121 : constant Version_32 := 16#e18a47a0#;
   pragma Export (C, u00121, "ada__float_text_ioB");
   u00122 : constant Version_32 := 16#e61b3c6c#;
   pragma Export (C, u00122, "ada__float_text_ioS");
   u00123 : constant Version_32 := 16#d5f9759f#;
   pragma Export (C, u00123, "ada__text_io__float_auxB");
   u00124 : constant Version_32 := 16#f854caf5#;
   pragma Export (C, u00124, "ada__text_io__float_auxS");
   u00125 : constant Version_32 := 16#f0df9003#;
   pragma Export (C, u00125, "system__img_realB");
   u00126 : constant Version_32 := 16#3366ddd8#;
   pragma Export (C, u00126, "system__img_realS");
   u00127 : constant Version_32 := 16#f05937c9#;
   pragma Export (C, u00127, "system__fat_llfS");
   u00128 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00128, "system__float_controlB");
   u00129 : constant Version_32 := 16#1432cf06#;
   pragma Export (C, u00129, "system__float_controlS");
   u00130 : constant Version_32 := 16#f1f88835#;
   pragma Export (C, u00130, "system__img_lluB");
   u00131 : constant Version_32 := 16#205f2839#;
   pragma Export (C, u00131, "system__img_lluS");
   u00132 : constant Version_32 := 16#eef535cd#;
   pragma Export (C, u00132, "system__img_unsB");
   u00133 : constant Version_32 := 16#f662140d#;
   pragma Export (C, u00133, "system__img_unsS");
   u00134 : constant Version_32 := 16#a4beea4d#;
   pragma Export (C, u00134, "system__powten_tableS");
   u00135 : constant Version_32 := 16#faa9a7b2#;
   pragma Export (C, u00135, "system__val_realB");
   u00136 : constant Version_32 := 16#0ae7fb2b#;
   pragma Export (C, u00136, "system__val_realS");
   u00137 : constant Version_32 := 16#6c05c057#;
   pragma Export (C, u00137, "system__exn_llfB");
   u00138 : constant Version_32 := 16#48b037e6#;
   pragma Export (C, u00138, "system__exn_llfS");
   u00139 : constant Version_32 := 16#acbb902e#;
   pragma Export (C, u00139, "system__fat_fltS");
   u00140 : constant Version_32 := 16#84ad4a42#;
   pragma Export (C, u00140, "ada__numericsS");
   u00141 : constant Version_32 := 16#ac5daf3d#;
   pragma Export (C, u00141, "ada__numerics__float_randomB");
   u00142 : constant Version_32 := 16#6b3928a3#;
   pragma Export (C, u00142, "ada__numerics__float_randomS");
   u00143 : constant Version_32 := 16#216aa6ef#;
   pragma Export (C, u00143, "system__random_numbersB");
   u00144 : constant Version_32 := 16#0d50ccf7#;
   pragma Export (C, u00144, "system__random_numbersS");
   u00145 : constant Version_32 := 16#7cd2c459#;
   pragma Export (C, u00145, "system__random_seedB");
   u00146 : constant Version_32 := 16#95585536#;
   pragma Export (C, u00146, "system__random_seedS");
   u00147 : constant Version_32 := 16#91613c5c#;
   pragma Export (C, u00147, "ada__real_timeB");
   u00148 : constant Version_32 := 16#87ade2f4#;
   pragma Export (C, u00148, "ada__real_timeS");
   u00149 : constant Version_32 := 16#1f99af62#;
   pragma Export (C, u00149, "system__arith_64B");
   u00150 : constant Version_32 := 16#d4b08bf7#;
   pragma Export (C, u00150, "system__arith_64S");
   u00151 : constant Version_32 := 16#30bb6e97#;
   pragma Export (C, u00151, "system__taskingB");
   u00152 : constant Version_32 := 16#8d6ada58#;
   pragma Export (C, u00152, "system__taskingS");
   u00153 : constant Version_32 := 16#01715bc2#;
   pragma Export (C, u00153, "system__task_primitivesS");
   u00154 : constant Version_32 := 16#f4bb5b54#;
   pragma Export (C, u00154, "system__os_interfaceS");
   u00155 : constant Version_32 := 16#2c7d263c#;
   pragma Export (C, u00155, "interfaces__c__stringsB");
   u00156 : constant Version_32 := 16#603c1c44#;
   pragma Export (C, u00156, "interfaces__c__stringsS");
   u00157 : constant Version_32 := 16#e2725713#;
   pragma Export (C, u00157, "system__task_primitives__operationsB");
   u00158 : constant Version_32 := 16#12291044#;
   pragma Export (C, u00158, "system__task_primitives__operationsS");
   u00159 : constant Version_32 := 16#da8ccc08#;
   pragma Export (C, u00159, "system__interrupt_managementB");
   u00160 : constant Version_32 := 16#c90ea50e#;
   pragma Export (C, u00160, "system__interrupt_managementS");
   u00161 : constant Version_32 := 16#f65595cf#;
   pragma Export (C, u00161, "system__multiprocessorsB");
   u00162 : constant Version_32 := 16#cc621349#;
   pragma Export (C, u00162, "system__multiprocessorsS");
   u00163 : constant Version_32 := 16#77769007#;
   pragma Export (C, u00163, "system__task_infoB");
   u00164 : constant Version_32 := 16#232885cd#;
   pragma Export (C, u00164, "system__task_infoS");
   u00165 : constant Version_32 := 16#ab9ad34e#;
   pragma Export (C, u00165, "system__tasking__debugB");
   u00166 : constant Version_32 := 16#f1f2435f#;
   pragma Export (C, u00166, "system__tasking__debugS");
   u00167 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00167, "system__concat_2B");
   u00168 : constant Version_32 := 16#f66e5bea#;
   pragma Export (C, u00168, "system__concat_2S");
   u00169 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00169, "system__concat_3B");
   u00170 : constant Version_32 := 16#ffbed09f#;
   pragma Export (C, u00170, "system__concat_3S");
   u00171 : constant Version_32 := 16#d0432c8d#;
   pragma Export (C, u00171, "system__img_enum_newB");
   u00172 : constant Version_32 := 16#95828afa#;
   pragma Export (C, u00172, "system__img_enum_newS");
   u00173 : constant Version_32 := 16#118e865d#;
   pragma Export (C, u00173, "system__stack_usageB");
   u00174 : constant Version_32 := 16#00bc3311#;
   pragma Export (C, u00174, "system__stack_usageS");
   u00175 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00175, "system__ioB");
   u00176 : constant Version_32 := 16#6a8c7b75#;
   pragma Export (C, u00176, "system__ioS");
   u00177 : constant Version_32 := 16#eb62b144#;
   pragma Export (C, u00177, "simdefs2S");
   u00178 : constant Version_32 := 16#04c9db66#;
   pragma Export (C, u00178, "simtrack2S");
   u00179 : constant Version_32 := 16#03e83d1c#;
   pragma Export (C, u00179, "ada__numerics__elementary_functionsB");
   u00180 : constant Version_32 := 16#00443200#;
   pragma Export (C, u00180, "ada__numerics__elementary_functionsS");
   u00181 : constant Version_32 := 16#3e0cf54d#;
   pragma Export (C, u00181, "ada__numerics__auxB");
   u00182 : constant Version_32 := 16#9f6e24ed#;
   pragma Export (C, u00182, "ada__numerics__auxS");
   u00183 : constant Version_32 := 16#fb75f7f4#;
   pragma Export (C, u00183, "system__machine_codeS");
   u00184 : constant Version_32 := 16#f4b54e65#;
   pragma Export (C, u00184, "simtrack2__displayB");
   u00185 : constant Version_32 := 16#683a853e#;
   pragma Export (C, u00185, "simtrack2__displayS");
   u00186 : constant Version_32 := 16#00b1d196#;
   pragma Export (C, u00186, "adagraphB");
   u00187 : constant Version_32 := 16#0b1102d2#;
   pragma Export (C, u00187, "adagraphS");
   u00188 : constant Version_32 := 16#5933ea28#;
   pragma Export (C, u00188, "system__tasking__protected_objectsB");
   u00189 : constant Version_32 := 16#63b50013#;
   pragma Export (C, u00189, "system__tasking__protected_objectsS");
   u00190 : constant Version_32 := 16#001f972c#;
   pragma Export (C, u00190, "system__soft_links__taskingB");
   u00191 : constant Version_32 := 16#e47ef8be#;
   pragma Export (C, u00191, "system__soft_links__taskingS");
   u00192 : constant Version_32 := 16#17d21067#;
   pragma Export (C, u00192, "ada__exceptions__is_null_occurrenceB");
   u00193 : constant Version_32 := 16#9a9e8fd3#;
   pragma Export (C, u00193, "ada__exceptions__is_null_occurrenceS");
   u00194 : constant Version_32 := 16#932a4690#;
   pragma Export (C, u00194, "system__concat_4B");
   u00195 : constant Version_32 := 16#8aaaa71a#;
   pragma Export (C, u00195, "system__concat_4S");
   u00196 : constant Version_32 := 16#608e2cd1#;
   pragma Export (C, u00196, "system__concat_5B");
   u00197 : constant Version_32 := 16#7390cf14#;
   pragma Export (C, u00197, "system__concat_5S");
   u00198 : constant Version_32 := 16#46b1f5ea#;
   pragma Export (C, u00198, "system__concat_8B");
   u00199 : constant Version_32 := 16#17c9c1ed#;
   pragma Export (C, u00199, "system__concat_8S");
   u00200 : constant Version_32 := 16#46899fd1#;
   pragma Export (C, u00200, "system__concat_7B");
   u00201 : constant Version_32 := 16#0809d725#;
   pragma Export (C, u00201, "system__concat_7S");
   u00202 : constant Version_32 := 16#a83b7c85#;
   pragma Export (C, u00202, "system__concat_6B");
   u00203 : constant Version_32 := 16#2609a188#;
   pragma Export (C, u00203, "system__concat_6S");
   u00204 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00204, "system__img_boolB");
   u00205 : constant Version_32 := 16#0117fdd1#;
   pragma Export (C, u00205, "system__img_boolS");
   u00206 : constant Version_32 := 16#dd13bf65#;
   pragma Export (C, u00206, "system__exn_lliB");
   u00207 : constant Version_32 := 16#7559f795#;
   pragma Export (C, u00207, "system__exn_lliS");
   u00208 : constant Version_32 := 16#276453b7#;
   pragma Export (C, u00208, "system__img_lldB");
   u00209 : constant Version_32 := 16#07ec8553#;
   pragma Export (C, u00209, "system__img_lldS");
   u00210 : constant Version_32 := 16#bd3715ff#;
   pragma Export (C, u00210, "system__img_decB");
   u00211 : constant Version_32 := 16#5ae385e1#;
   pragma Export (C, u00211, "system__img_decS");
   u00212 : constant Version_32 := 16#3ea9332d#;
   pragma Export (C, u00212, "system__tasking__protected_objects__entriesB");
   u00213 : constant Version_32 := 16#7671a6ef#;
   pragma Export (C, u00213, "system__tasking__protected_objects__entriesS");
   u00214 : constant Version_32 := 16#100eaf58#;
   pragma Export (C, u00214, "system__restrictionsB");
   u00215 : constant Version_32 := 16#efa60774#;
   pragma Export (C, u00215, "system__restrictionsS");
   u00216 : constant Version_32 := 16#92d5df45#;
   pragma Export (C, u00216, "system__tasking__initializationB");
   u00217 : constant Version_32 := 16#d9930fa8#;
   pragma Export (C, u00217, "system__tasking__initializationS");
   u00218 : constant Version_32 := 16#d89f9b67#;
   pragma Export (C, u00218, "system__tasking__task_attributesB");
   u00219 : constant Version_32 := 16#952bcf5e#;
   pragma Export (C, u00219, "system__tasking__task_attributesS");
   u00220 : constant Version_32 := 16#6f8919f6#;
   pragma Export (C, u00220, "system__tasking__protected_objects__operationsB");
   u00221 : constant Version_32 := 16#eb67f071#;
   pragma Export (C, u00221, "system__tasking__protected_objects__operationsS");
   u00222 : constant Version_32 := 16#72d3cb03#;
   pragma Export (C, u00222, "system__tasking__entry_callsB");
   u00223 : constant Version_32 := 16#e903595c#;
   pragma Export (C, u00223, "system__tasking__entry_callsS");
   u00224 : constant Version_32 := 16#94c4f9d9#;
   pragma Export (C, u00224, "system__tasking__queuingB");
   u00225 : constant Version_32 := 16#3117b7f1#;
   pragma Export (C, u00225, "system__tasking__queuingS");
   u00226 : constant Version_32 := 16#c6ee4b22#;
   pragma Export (C, u00226, "system__tasking__utilitiesB");
   u00227 : constant Version_32 := 16#ea41a805#;
   pragma Export (C, u00227, "system__tasking__utilitiesS");
   u00228 : constant Version_32 := 16#bd6fc52e#;
   pragma Export (C, u00228, "system__traces__taskingB");
   u00229 : constant Version_32 := 16#3fb127e5#;
   pragma Export (C, u00229, "system__traces__taskingS");
   u00230 : constant Version_32 := 16#3cc73d8e#;
   pragma Export (C, u00230, "system__tasking__rendezvousB");
   u00231 : constant Version_32 := 16#71fce298#;
   pragma Export (C, u00231, "system__tasking__rendezvousS");
   u00232 : constant Version_32 := 16#d6fbdf05#;
   pragma Export (C, u00232, "system__tasking__stagesB");
   u00233 : constant Version_32 := 16#f8a082a4#;
   pragma Export (C, u00233, "system__tasking__stagesS");
   u00234 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00234, "system__address_imageB");
   u00235 : constant Version_32 := 16#55221100#;
   pragma Export (C, u00235, "system__address_imageS");
   u00236 : constant Version_32 := 16#e9aaf431#;
   pragma Export (C, u00236, "sloggerB");
   u00237 : constant Version_32 := 16#824ad064#;
   pragma Export (C, u00237, "sloggerS");
   u00238 : constant Version_32 := 16#3c011662#;
   pragma Export (C, u00238, "logger_adaB");
   u00239 : constant Version_32 := 16#a3570c65#;
   pragma Export (C, u00239, "logger_adaS");
   u00240 : constant Version_32 := 16#792d926a#;
   pragma Export (C, u00240, "dac_driverB");
   u00241 : constant Version_32 := 16#089a161a#;
   pragma Export (C, u00241, "dac_driverS");
   u00242 : constant Version_32 := 16#fcc9a4c0#;
   pragma Export (C, u00242, "halls2B");
   u00243 : constant Version_32 := 16#ecf94573#;
   pragma Export (C, u00243, "halls2S");
   u00244 : constant Version_32 := 16#166b9811#;
   pragma Export (C, u00244, "interrupt_hdlrB");
   u00245 : constant Version_32 := 16#ef4a55cc#;
   pragma Export (C, u00245, "interrupt_hdlrS");
   u00246 : constant Version_32 := 16#a906eaad#;
   pragma Export (C, u00246, "swindowsB");
   u00247 : constant Version_32 := 16#a676c5b7#;
   pragma Export (C, u00247, "swindowsS");
   u00248 : constant Version_32 := 16#b5b2aca1#;
   pragma Export (C, u00248, "system__finalization_mastersB");
   u00249 : constant Version_32 := 16#80d8a57a#;
   pragma Export (C, u00249, "system__finalization_mastersS");
   u00250 : constant Version_32 := 16#6d4d969a#;
   pragma Export (C, u00250, "system__storage_poolsB");
   u00251 : constant Version_32 := 16#01950bbe#;
   pragma Export (C, u00251, "system__storage_poolsS");
   u00252 : constant Version_32 := 16#e34550ca#;
   pragma Export (C, u00252, "system__pool_globalB");
   u00253 : constant Version_32 := 16#c88d2d16#;
   pragma Export (C, u00253, "system__pool_globalS");
   u00254 : constant Version_32 := 16#2bce1226#;
   pragma Export (C, u00254, "system__memoryB");
   u00255 : constant Version_32 := 16#adb3ea0e#;
   pragma Export (C, u00255, "system__memoryS");
   u00256 : constant Version_32 := 16#587e0610#;
   pragma Export (C, u00256, "turnout_driverB");
   u00257 : constant Version_32 := 16#23f2d4e8#;
   pragma Export (C, u00257, "turnout_driverS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  system%s
   --  system.arith_64%s
   --  system.case_util%s
   --  system.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.exn_lli%s
   --  system.exn_lli%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.htable%s
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_dec%s
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_dec%b
   --  system.img_lld%s
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.img_lld%b
   --  system.img_real%s
   --  system.io%s
   --  system.io%b
   --  system.machine_code%s
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
   --  system.img_biu%s
   --  system.img_biu%b
   --  system.img_llb%s
   --  system.img_llb%b
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_llw%s
   --  system.img_llw%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.img_real%b
   --  system.img_wiu%s
   --  system.img_wiu%b
   --  system.val_int%s
   --  system.val_lli%s
   --  system.val_llu%s
   --  system.val_real%s
   --  system.val_uns%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_uns%b
   --  system.val_real%b
   --  system.val_llu%b
   --  system.val_lli%b
   --  system.val_int%b
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
   --  system.concat_4%s
   --  system.concat_4%b
   --  system.concat_5%s
   --  system.concat_5%b
   --  system.concat_6%s
   --  system.concat_6%b
   --  system.concat_7%s
   --  system.concat_7%b
   --  system.concat_8%s
   --  system.concat_8%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.io_exceptions%s
   --  ada.numerics%s
   --  ada.numerics.aux%s
   --  ada.numerics.aux%b
   --  ada.numerics.elementary_functions%s
   --  ada.numerics.elementary_functions%b
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
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
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
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.pool_global%s
   --  system.pool_global%b
   --  system.random_numbers%s
   --  ada.numerics.float_random%s
   --  ada.numerics.float_random%b
   --  system.random_seed%s
   --  system.random_seed%b
   --  system.secondary_stack%s
   --  system.finalization_masters%b
   --  system.file_io%b
   --  interfaces.c.strings%b
   --  interfaces.c%b
   --  ada.tags%b
   --  system.soft_links%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.random_numbers%b
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
   --  ada.text_io.integer_aux%s
   --  ada.text_io.integer_aux%b
   --  ada.integer_text_io%s
   --  ada.integer_text_io%b
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
   --  adagraph%s
   --  adagraph%b
   --  logger_ada%s
   --  logger_ada%b
   --  swindows%s
   --  interrupt_hdlr%s
   --  unsigned_types%s
   --  io_ports%s
   --  raildefs%s
   --  dda06defs%s
   --  dac_driver%s
   --  dac_driver%b
   --  dio192defs%s
   --  block_driver%s
   --  block_driver%b
   --  halls2%s
   --  int32defs%s
   --  simdefs2%s
   --  simrail2%s
   --  halls2%b
   --  simtrack2%s
   --  simtrack2.display%s
   --  simtrack2.display%b
   --  simrail2%b
   --  swindows%b
   --  turnout_driver%s
   --  turnout_driver%b
   --  slogger%s
   --  slogger%b
   --  io_ports%b
   --  interrupt_hdlr%b
   --  lab3%b
   --  END ELABORATION ORDER


end ada_main;

readme for simrail2_src_234 2016-02-16

This has protected procedure for interrupt callback (essential for hardware) and simulates test bit T
(see Spec2016 or later; changes to T cause an interrupt via sensor 9).

simrail2.adb   v2.3.4   5-Feb-2016
raildefs.ads   v3.1    16-Feb-2016 -- identical to the hardware (486) version for 2016
interrupt_hdlr v3.1    16-Feb-2016 -- this is skeleton code

There is also a GPS project file skeleton.gpr, that has main skel2 and places binaries in subdirectory Obj.


skel2.adb contains procedure Skel2, skeleton/incomplete code for a main program.  You should rename this procedure and file, and the project.
-- Testwid : testprogram for Widget (example Sporadic)
-- R K Allen, Swinburne Univ Tech.  13-May-03
with Projdefs, Widget;  
use Projdefs;
procedure TestWid is

begin
   for I in 1..10 loop
      Widget.Start(Request_Type'Val(I mod 2));
      delay 0.8;
   end loop;
end TestWid;
--example output:
-- Req=STOP Over_Run=FALSE
-- Req=RUN Over_Run=FALSE
-- Req=STOP Over_Run=FALSE
-- Req=RUN Over_Run=FALSE
-- Req=STOP Over_Run=FALSE
-- Req=STOP Over_Run=TRUE
-- Req=RUN Over_Run=FALSE
-- Req=STOP Over_Run=FALSE
-- Req=RUN Over_Run=FALSE
-- Testwid : testprogram for Widget (example Sporadic)
-- R K Allen, Swinburne Univ Tech.  13-May-03
with Projdefs, Widget;  
use Projdefs;
procedure TestWid is

begin
      for I in 1..30 loop
         Widget.Start(Request_Type'Val(I));
         delay 0.8;
         if (I rem 10 = 0) then
           delay 5.0;
         end if;
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

;+
;  NAME:
;    timer
;  PURPOSE:
;    Get start/end/elapsed time for a running code
;
;  USE:
;    time=code_timer(st=st,/fin,unit='h')   
;
;  INPUT:
;    
;  OPTIONAL INPUT:
;    st - the start time of the code, needed if /fin is set and you
;         want to get the elapsed time    
;
;  KEYWORDS:  
;    fin - getting end time      
;    unit - return time in hours (h) ,minutes (m), seconds (s - default)
;
;  OUTPUT:
;    returns time, if end is set prints elapsed time
;
;  NOTES:
;
;  HISTORY:
;    5-29-15 - written - MAD (Uwyo)
;-
FUNCTION timer,st=st,fin=fin,unit=unit

  IF ~keyword_set(unit) THEN unit='m'
  
  time=systime(1)

  IF keyword_set(fin) THEN BEGIN
     elapsed=time-st
     string=' seconds'
     IF (unit EQ 'm') THEN BEGIN
        elapsed=elapsed/60.
        string=' minutes'
     ENDIF
     IF (unit EQ 'h') THEN BEGIN
        elapsed=elapsed/3600.
        string=' hours'
     ENDIF
     print,'Elapsed time: ' + strtrim(elapsed,2) + string
  ENDIF

  return,time
END

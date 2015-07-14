;+
;  NAME:
;    pull_all
;  PURPOSE:
;    pull changes for all Git repos in the current directory
;
;  USE:
;    pull_all,
;
;  INPUT:
;    
;  OPTIONAL INPUT:
;    
;  KEYWORDS:  
;    norun - if set, only writes script, doesn't execute it
;
;  OUTPUT:
;    
;  NOTES:
;
;  HISTORY:
;    7-14-15 - written - MAD (Uwyo)
;-
PRO pull_all,norun=norun

spawn,'ls -d */',directories
directories=strsplit(directories,' ',/extract)

openw,1,'pull_all.sh'
FOR i=0L,n_elements(directories)-1 DO BEGIN
   printf,1,'(cd ' + strtrim(directories[i],2) + $
          '; git pull)'
ENDFOR
close,1

cmd=['chmod','+x','pull_all.sh']
spawn,cmd,/noshell

IF ~keyword_set(norun) THEN spawn,'./pull_all.sh',/noshell

END

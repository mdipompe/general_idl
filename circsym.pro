;+
;  NAME:
;    circsym
;  PURPOSE:
;    Initialize a (filled) circle for plotting (psym=8)
;
;  USE:
;    circsym,/fill
;
;  INPUT:
;    
;  OPTIONAL INPUT:
;    
;  KEYWORDS:        
;    fill - set to provide filled circle
;
;  OUTPUT:
;    
;  NOTES:
;    
;  HISTORY:
;    2013 - Written - MAD (UWyo)
;    2015 - Cleaned and documented - MAD (UWyo)
;-
PRO circsym,fill=fill

A = findgen(17)*(!PI*2/16.)

IF keyword_set(fill) THEN $
   usersym,cos(A),sin(A),/fill ELSE $
      usersym,cos(A),sin(A)

return

END

;+
;  NAME:
;    base60_2_dec
;  PURPOSE:
;    Convert base60 strings (like SDSS names) to ra and dec
;
;  USE:
;    coord=base60_2_dec(base60strings,coord='Q')
;
;  INPUT:
;    base60 - input string in form hhmmss.s(sss...)+ddmmss.s(sss...)
;
;  OPTIONAL INPUT:
;    coord - output coordinate system.  Equatorial (Q) by default,
;            also takes galactic (G) and ecliptic (E)
;    
;  KEYWORDS:
;        
;  OUTPUT:
;    structure with tags long and lat
;
;  NOTES:
;    requires hms2dec
;
;  HISTORY:
;    2013 - Written - MAD (UWyo)
;    2015 - Cleaned and documented - MAD (UWyo)
;-
FUNCTION base60_2_dec,base60,coord=coord

  IF ~keyword_set(coord) THEN coord='Q'

 ;MAD Initialize output structure 
  coords={long:0., lat:0.}
  coords=replicate(coords,n_elements(base60))

  ;MAD Split string names into pieces of RA and DEC
  FOR i=0L,n_elements(base60)-1 DO BEGIN 
     tmp=strsplit(base60[i],'+',/extract)
     IF n_elements(tmp EQ 1) THEN BEGIN
        tmp=strsplit(base60[i],'-',/extract)
     ENDIF
     ra=tmp[0]
     dec=tmp[1]
     ra1=strmid(ra,0,2)
     ra2=strmid(ra,2,2)
     ra3=strmid(ra,4,strlen(ra)-1)
     dec1=strmid(dec,0,2)
     dec2=strmid(dec,2,2)
     dec3=strmid(dec,4,strlen(dec)-1)

     ;MAD Put RA and DEC into separate strings readable by hms2dec
     ra=ra1+':'+ra2+':'+ra3
     dec=dec1+':'+dec2+':'+dec3

    ;MAD Convert RA and DEC into decimal forms
    ra=hms2dec(ra)*15.
    dec=hms2dec(dec)

    coords[i].long=ra
    coords[i].lat=dec
  ENDFOR

  ;MAD Convert
  IF (coord EQ 'G') THEN BEGIN
     euler,coords.long,coords.lat,l,b,1
     coords.long=l
     coords.lat=b
  ENDIF
  IF (coord EQ 'E') THEN BEGIN
     euler,coords.long,coords.lat,l,b,3
     coords.long=l
     coords.lat=b
  ENDIF

  return,coords

END

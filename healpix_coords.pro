;+
;  NAME:
;    healpix_coords
;  PURPOSE:
;    Get HEALPix pixel center coordinates 
;
;  USE:
;    healpix_coords,nside,long,lat,coord='G'
;
;  INPUT:
;    nside
;
;  OPTIONAL INPUT:
;    coord - coordinates to return pixel centers in.  Assumption is
;            that native HEALPix is galactic
;    outfile - string name of file to write results to
;
;  OUTPUT:
;    long
;    lat
;
;  HISTORY:
;    5-27-15 - Written - MAD (UWyo)
;-
PRO healpix_coords,nside,long,lat,coord=coord,outfile=outfile

IF ~keyword_set(coord) THEN coord='G'

npix=12D*nside^2
pixnum=lindgen(npix)
pix2ang_nest,nside,pixnum,theta,phi

l=phi*(180./!dpi)
b=90.-(theta*(180./!dpi))

IF (coord EQ 'G') THEN BEGIN
   long=l
   lat=b
ENDIF
IF (coord EQ 'Q') THEN BEGIN
   euler,l,b,long,lat,2
ENDIF
IF (coord EQ 'E') THEN BEGIN
   euler,l,b,long,lat,6
ENDIF

IF (keyword_set(outfile)) THEN BEGIN
   openw,1,outfile
   printf,1,'long    lat',format='(A)'
   FOR i=0L,n_elements(long)-1 DO BEGIN
      printf,1,strtrim(long[i],2)+'    '+strtrim(lat[i],2),format='(A)'
   ENDFOR
   close,1
ENDIF

return
END





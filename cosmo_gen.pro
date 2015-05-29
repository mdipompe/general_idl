;+
;  NAME:
;    cosmo_gen
;  PURPOSE:
;    Wrapper for ADM's 'cosmo_gen.py'
;
;  USE:
;    dist = cosmo_gen(redshifts,'dist',om=om,lambda=lambda,h=h)
;
;  INPUT:
;    redshift - z value(s)
;    dist - string indicating which distance you want:
;           c - comoving distance (Mpc)
;           a - angular diameter distance (Mpc)
;           l - luminosity distance (Mpc)
;           v - comoving volume (from z=0) (Mpc^3)           
;           age - age of Universe at z (Gyr)
;
;  OPTIONAL INPUT:
;    om - omega_matter (defaults to 0.27)
;    lambda - omega_lambda (defaults to 0.73)
;    h - little h (defaults to 0.71)
;
;  KEYWORDS:        
;
;  OUTPUT:
;    distance
;
;  NOTES:
;    requires cosmo_dist.py (MAD) and cosmo_gen.py (as well as their dependencies)
;
;  HISTORY:
;    2014 - Written - MAD (UWyo)
;    2015 - Cleaned and documented - MAD (UWyo)
;-
FUNCTION cosmo_gen,dist,omega_m,omega_l,h,redshift

  On_error,2                    ;Return to caller
  compile_opt idl2
  IF (N_params() LT 5) THEN BEGIN
     print,'Syntax - dist = cosmo_gen(''dist'',omega_m,omega_l,h,redshifts)'
     print,'Options for dist are ''c'' (comoving, Mpc)'
     print,'                     ''a'' (angular diameter, Mpc)'
     print,'                     ''l'' (luminosity, Mpc)'
     print,'                     ''v'' (comoving volume from z=0, Mpc^3)'
     print,'                     ''age'' (age at z, Gyr)'
  ENDIF
  
  IF ~keyword_set(h) THEN h=0.71
  IF ~keyword_set(om) THEN om=0.27
  IF ~keyword_set(lambda) THEN lambda=0.73
  
  ;MAD Initialize output array
  out=fltarr(n_elements(redshift))
  
  ;Loop over redshifts to get chosen distance
  FOR i=0L,n_elements(redshift)-1 DO BEGIN
     cmd='python /Users/Mike/Research/wyo_postdoc/mikestrunk/code/Python/miked/gen/cosmo_dist.py '+"'"+strtrim(dist,2)+"' "+strtrim(om,2)+' '+$
         strtrim(lambda,2)+' '+strtrim(h,2)+' '+strtrim(redshift[i],2)
     
     spawn,cmd,result
     
     out[i]=result
  ENDFOR
  
  return,out
END

;+
;  NAME:
;    make_lune
;  PURPOSE:
;    make a mangle polygon structure of a lune ("rectangular" patch on
;    the sky)
;
;  USE:
;    poly=make_lune(bottom_ra,top_ra,smaller_dec,larger_dec,weight=1)
;
;  INPUT:
;    ldec - the lower DEC limit (degrees)
;    udec - the upper DEC limit (degrees)
;    lra - the lower RA limit (degrees)
;    ura - the upper RA limit (degrees)
;
;  OPTIONAL INPUT:
;    weight - weight for polygon (defaults to 1)
;    
;  KEYWORDS:
;        
;  OUTPUT:
;    structure with 8 tags: d_h - the hubble distance                      
;                           d_m - the transverse comiving distance (Mpc)   
;                           d_L - the luminosity distance (Mpc)            
;                           d_a - the angular size distnace (Mpc)          
;                           d_c - the comoving distance (Mpc)              
;                           v_c - the comoving volume (Mpc^3)              
;                           t_l - the lookback time (Gyrs)                 
;                           t_h - the hubble time (Gyrs)                   
;  HISTORY:
;    2-7-13 - Written - MAD (UWyo)
;    2015 - Cleaned and documented - MAD (UWyo)
;-
FUNCTION make_lune,lra,ura,ldec,udec,weight=weight
  IF ~keyword_set(weight) THEN weight=1

  ;MAD Define cap limits in ra
  min_ra=make_ra_cap(lra,sign=1)
  max_ra=make_ra_cap(ura,sign=-1)

  ;MAD Define cap limits in dec
  min_dec=make_dec_cap(ldec,sign=1)
  max_dec=make_dec_cap(udec,sign=-1)

  ;MAD Create polygon of region 
  region=construct_polygon(ncaps=4)
  region.ncaps=4
  (*region.caps)[0]=min_dec
  (*region.caps)[1]=max_dec
  (*region.caps)[2]=min_ra
  (*region.caps)[3]=max_ra
  ;MAD Use all of the caps
  region.use_caps=15
  region.weight=weight

  return,region
END

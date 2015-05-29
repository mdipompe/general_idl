;+
;  NAME:
;    space_fields
;  PURPOSE:
;    Determine spacing of centers of fields to fill given region.
;    Takes output from n_fields.pro
;
;  USE:
;    result=space_fields(lra,ura,ldec,udec,field_size,N_ra,N_dec)
;
;  INPUT:
;    ldec - the lower DEC limit of the region (degrees)
;    udec - the upper DEC limit of the region (degrees)
;    lra - the lower RA limit of the region (degrees)
;    ura - the upper RA limit of the region (degrees)
;    field_size - the subfield size (assumed to be square, in deg)
;    n_ra - an array with the number of fields in the RA direction at
;           each declination
;    n_dec - the number of fields in the DEC direction
;
;  OPTIONAL INPUT:
;    
;  KEYWORDS:        
;
;  OUTPUT:
;    Array of field spacings.  Elements to N-1 are spacings in RA at
;    each DEC, last element is spacing in DEC
;
;  NOTES:
;
;  HISTORY:
;    2-7-13 - Written - MAD (UWyo)
;    5-29-15 - Cleaned and documented - MAD (Uwyo)
;-
FUNCTION space_fields,lra,ura,ldec,udec,field_size,n_ra,n_dec

  dec_space=(udec-ldec-field_size)/(n_dec-1.)
  ra_space=fltarr(n_dec)
  FOR i=0L, n_dec-1 DO BEGIN
     dec=ldec+((i+1)*dec_space)
     field_size_scaled=field_size/COS(dec*!dpi/180.)
     ra_space[i]=(ura-lra-field_size_scaled)/(n_ra[i]-1.)
  ENDFOR
  
  print,'SPACE_FIELDS - RA spacing is from ',strtrim(min(ra_space),2),' to ',strtrim(max(ra_space),2),' degrees'
  print,'SPACE_FIELDS - DEC spacing is ',strtrim(dec_space,2),' degrees'

  return,[ra_space,dec_space]

END

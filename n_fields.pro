;+
;  NAME:
;    n_fields
;  PURPOSE:
;    Determine number of sub fields of specified size needed to over a 
;    region bounded by some RA and DEC.  Rounds up to the 
;    nearest integer numer of fields (to ensure full coverage), taking
;    a specified minumum overlap into account.  Overlap can become
;    larger (since N_fields is rounded up)
;
;  USE:
;    result=n_fields(lra,ura,ldec,udec,field_size,overlap)
;
;  INPUT:
;    ldec - the lower DEC limit of the region (degrees)
;    udec - the upper DEC limit of the region (degrees)
;    lra - the lower RA limit of the region (degrees)
;    ura - the upper RA limit of the region (degrees)
;    field_size - the subfield size (assumed to be square, in deg)
;    overlap - the minimum amount of overlap desired between fields (deg)
;
;  OPTIONAL INPUT:
;    
;  KEYWORDS:        
;
;  OUTPUT:
;    Returns an array of number of fields needed in RA and DEC
;    directions.  Varies in size, since depending on size in DEC, the
;    number of fields in RA can vary.  First N-1 elements are number
;    of fields needed in RA from lowest to highest DEC strip.  Last
;    element is number needed in DEC direction.
;
;  NOTES:
;
;  HISTORY:
;    2-7-13 - Written - MAD (UWyo)
;    5-29-15 - Cleaned and documented - MAD (Uwyo)
;-
FUNCTION n_fields,lra,ura,ldec,udec,field_size,overlap

  ;MAD Calculate (integer) number of fields needed in DEC directions
  num_fields_dec=ceil(((udec-ldec)/(field_size-overlap)))


  ;MAD Calculate (integer) number of fields needed in RA direction at
  ;top and bottom of field, see if they are the same
  num_fields_ra_top=ceil(((ura-lra)/((field_size/COS((udec-(field_size/2.))*!dpi/180.)) - $
                                     (overlap/COS((udec-(field_size/2.))*!dpi/180.)))))
  num_fields_ra_bot=ceil(((ura-lra)/((field_size/COS((ldec+(field_size/2.))*!dpi/180.)) - $
                                     (overlap/COS((ldec+(field_size/2.))*!dpi/180.)))))

  IF (num_fields_ra_top-num_fields_ra_bot EQ 0.) THEN BEGIN
     print,'Need same number of fields in RA at all DECs'
     print,'Need ',strtrim(num_fields_ra_top,2),' fields in RA direction'
     print,'Need ',strtrim(num_fields_dec,2),' fields in DEC direction'
     num_fields_ra=fltarr(num_fields_dec)+num_fields_ra_top
     
     n_fields=[num_fields_ra,num_fields_dec]
  ENDIF ELSE BEGIN
     print,'Number of fields needed in RA changes with DEC'
     dec_spacing=(udec-ldec)*1./num_fields_dec
     num_fields_ra=fltarr(num_fields_dec)
     FOR i=0,num_fields_dec-1 DO BEGIN
        dec=ldec+((i+1)*dec_spacing)
        field_size_scaled=field_size/COS(dec*!dpi/180.)
        overlap_scaled=overlap/COS(dec*!dpi/180.)
        num_fields_ra[i]=ceil(((ura-lra)/(field_size_scaled-overlap_scaled)))
     ENDFOR

     n_fields=[num_fields_ra,num_fields_dec]
  ENDELSE

  ;MAD Get actual overlap info
  dec_overlap=((num_fields_dec*field_size)-(udec-ldec))/(num_fields_dec-1)
  ra_overlap_min=((num_fields_ra[0]*field_size/cos((ldec+(field_size/2.))*!dpi/180.)) - $
                  (ura-lra))/(num_fields_ra[0]-1)
  ra_overlap_max=((num_fields_ra[n_elements(num_fields_ra)-1]*field_size/cos((udec-(field_size/2.))*!dpi/180.)) - $
                  (ura-lra))/(num_fields_ra[n_elements(num_fields_ra)-1]-1)

  ;MAD Print some info
  print,'N_FIELDS - There are ' + strtrim(total(num_fields_ra),2) + ' fields'
  print,'N_FIELDS - Overlap in DEC direction is ' + strtrim(dec_overlap,2) + ' degrees'
  print,'N_FIELDS - Overlap in RA is from ' + strtrim(ra_overlap_min,2) + ' to ' + $
        strtrim(ra_overlap_max,2) + ' degrees'


return,n_fields
END

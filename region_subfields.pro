;+
;  NAME:
;    region_subfields
;  PURPOSE:
;    Take a region bounded by RA and DEC) and break it up into
;    sub-regions of specified size (constant area - note there is
;    some error in this that increases as the field size increases,
;    since the COS(dec) term is taken at the center of the fields).
;
;    Since the number needs to be an integer, can also specify a minimum
;    desired overlap between regions, and the code will get as close
;    to that as possible while covering the whole field.  
;
;  USE:
;    region_subfields,ldec,udec,lra,ura,field_size,fields,centers,overlap=overlap,outpoly='fields.ply',outcenter='centers.txt',plotout='out.png'
;
;  INPUT:
;    ldec - the lower DEC limit of the region (degrees)
;    udec - the upper DEC limit of the region (degrees)
;    lra - the lower RA limit of the region (degrees)
;    ura - the upper RA limit of the region (degrees)
;    field_size - the subfield size (assumed to be square, in deg)
;
;  OPTIONAL INPUT:
;    outpoly - specify an output file name and Mangle polygons of the
;              fields will be written out (in polygon format).
;    outcenter - specify an output file name and a list of field
;                centers will be written to a text file
;    plotout - string name of plot output
;    overlap - the minimum desired overlap between fields.  Defaults
;              to 0
;
;  KEYWORDS:        
;
;  OUTPUT:
;    fields - structure of Mangle polygons representing the fields.
;    centers - the coordinates of the field centers.
;
;  NOTES:
;
;  HISTORY:
;    2-6-13 - Written - MAD (UWyo)
;    5-29-15 - Cleaned and documented - MAD (Uwyo)
;-
PRO region_subfields,lra,ura,ldec,udec,field_size,fields,centers,overlap=overlap,outpoly=outpoly,outcenter=outcenter,plotout=plotout

;MAD Get start time
st=timer()

IF ~keyword_set(overlap) THEN overlap=0.

;MAD Make polygon for whole survey footprint
full_foot=make_lune(lra,ura,ldec,udec)
;plot_poly,full_foot,color=cgcolor('yellow')
print,'REGION_SUBFIELDS - The footprint is ',strtrim(full_foot.str*((180./!dpi)^2.),2),' square degrees'

;MAD Call n_fields.pro to find number of fields needed in each direction
n_fields=n_fields(lra,ura,ldec,udec,field_size,overlap)

;MAD Call space_fields.pro to determine field center spacing
space=space_fields(lra,ura,ldec,udec,field_size,n_fields[0:n_elements(n_fields)-2],n_fields[n_elements(n_fields)-1])

;MAD Loop over footprint area to make fields
ldeclim=ldec
k=0L
FOR i=0L,n_fields[n_elements(n_fields)-1]-1. DO BEGIN
   IF (i EQ 0.) THEN ldeclim=ldeclim ELSE ldeclim=(ldeclim+(field_size/2.))+(space[n_elements(space)-1]-(field_size/2.))
   udeclim=ldeclim+field_size
   lralim=lra
   FOR j=0L,n_fields[i]-1. DO BEGIN
      counter,k,total(n_fields[0:n_elements(n_fields)-2])
      dec=ldec+((i+1)*space[n_elements(space)-1])
      field_size_scaled=field_size/COS(dec*!dpi/180.)
      IF (j EQ 0.) THEN lralim=lralim ELSE lralim=(lralim+(field_size_scaled/2.))+(space[i]-(field_size_scaled/2.))
      uralim=lralim+field_size_scaled
      
      ;MAD Build array of centers
      IF (n_elements(cra) EQ 0) THEN cra=(lralim+(field_size_scaled/2.)) ELSE $
         cra=[cra,(lralim+(field_size_scaled/2.))]
      IF (n_elements(cdec) EQ 0) THEN cdec=(ldeclim+(field_size/2.)) ELSE $
         cdec=[cdec,(ldeclim+(field_size/2.))]

      ;MAD Make polygon of field, plot
      tmp=make_lune(lralim,uralim,ldeclim,udeclim,weight=1)
      IF (n_elements(fields) EQ 0) THEN fields=tmp ELSE fields=[fields,tmp]
;      plot_poly,tmp,color=cgcolor('blue'),/over
      k=k+1
   ENDFOR
ENDFOR

;MAD Combine centers into 2-D array for output
centers=transpose([[cra],[cdec]])
IF keyword_set(outcenter) THEN BEGIN
   openw,1,outcenter
   FOR i=0L,n_elements(cra)-1 DO BEGIN
      printf,1,strtrim(cra[i],2) + '    ' + strtrim(cdec[i],2),format='(A)'
   ENDFOR
   close,1
ENDIF

;MAD Write polygons out, if needed
IF keyword_set(outpoly) THEN $
   write_mangle_polygons,outpoly,fields,/pixels


;MAD Final plot
IF keyword_set(plotout) THEN BEGIN
   PS_start,filename=plotout,xsize=11,ysize=9
   nice_plot,lra-1.,ura+1., ldec-1., udec+1,xtit='RA',ytit='Dec'
   plot_poly,full_foot,/over,color=cgcolor('red'),outline_thick=2
   plot_poly,fields,/over,color=cgcolor('blue'),outline_thick=0.5
   IF keyword_set(outcenter) THEN BEGIN
      readcol,outcenter,centra,centdec,format='F'
      oplot,centra,centdec,psym=1,thick=2,color=cgcolor('green')
   ENDIF
   PS_end,/png
ENDIF

;MAD Note, print elapsed time
et=timer(st=st,/fin)

return
END



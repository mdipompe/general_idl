;+
;  NAME:
;    pixel_props
;  PURPOSE:
;    Get properties of healpix pixels based on nside
;
;  USE:
;    result=pixel_props(nside,/rad,/arcmin,/arcsec)
;
;  INPUT:
;    nside - healpix resolution parameter
;    
;  OPTIONAL INPUT:
;    
;  KEYWORDS:        
;    rad - set to return angular properties (separation, area) in
;          radians instead of degrees
;    arcmin - set to return angular props in armin(^2)
;    arcsec - set to return angular props in arcsec(^2)
;
;  OUTPUT:
;    returns structure with tags nside, n, area, size.  Note that size
;    is approximate, as it is calculated assuming pixels are square
;    which they are not. Default unit for area is deg^2 and size is deg
;
;  NOTES:
;
;  HISTORY:
;    6-12-15 - Written - MAD (UWyo)
;-
FUNCTION pixel_props,nside,rad=rad,arcmin=arcmin,arcsec=arcsec
  ;MAD Setup output structure
  out={nside:0, n:0.D, area:0., size:0.}
  out.nside=nside

  ;MAD Get N
  npix=12.D*(nside^2.)
  out.n=npix

  ;MAD Get area, size
  IF ~keyword_set(rad) THEN $
     area=((4.*!dpi)*(180./!dpi)^2.)*1./npix ELSE $
        area=(4.*!dpi)*1./npix
  IF keyword_set(arcmin) THEN area=area*3600.
  IF keyword_set(arcsec) THEN area=area*3600.*3600.
  size=sqrt(area)

  out.area=area
  out.size=size

  return,out
END

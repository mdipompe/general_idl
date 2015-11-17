;+
;  NAME:
;    make_circle_poly
;  PURPOSE:
;    Take a central ra, dec, and radius, make a ciruclar Mangle
;    polygon (just takes circle_cap one step farther)
;
;  USE:
;    poly=make_circle_poly(ra,dec,radius,weight=1)
;
;  INPUT:
;    ra - center of circle (degrees)
;    dec - center of circle (degrees)
;    radius - radius (degrees)
;
;  OPTIONAL INPUT:
;    weight - weight to give polygon (defaults to 1)
;    
;  KEYWORDS:
;        
;  OUTPUT:
;    mangle polygon structure
;
;  HISTORY:
;    2013 - Written - MAD (UWyo)
;    2015 - Cleaned and documented - MAD (UWyo)
;    11-17-2015 - Added area to output polygon - MAD (Dartmouth)
;-
FUNCTION make_circle_poly,ra,dec,radius,weight=weight
  IF ~keyword_set(weight) THEN weight=1

  ;MAD Define a circular cap
  cap=circle_cap(radius,ra=ra,dec=dec)

  ;MAD Construct the circular polygon
  region=construct_polygon(ncaps=1)
  region.ncaps=1
  (*region.caps)[0]=cap
  region.use_caps=1
  region.weight=weight
  region.str=garea(region)
  
  return,region
END

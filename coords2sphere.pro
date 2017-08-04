PRO coords2sphere,long,lat,phi,theta,coords=coords

  ;Take coordinates and convert to phi and theta on the sphere,  
  ;where 0 < phi < 2pi and 0 < theta < pi. Assumes input coords are
  ;equatorial, unless spcified otherwise (using coords keyword).
  ;Useful for passing coordinates to healpix routines.
  
  IF ~keyword_set(coords) THEN coords='Q'

  IF (coords NE 'E' AND coords NE 'Q' AND coords NE 'G') THEN BEGIN
     message,'Unrecognized coordinates'
     return
  ENDIF
     
  IF (coords EQ 'E' OR coords EQ 'Q') THEN euler,long,lat,l,b,1

  IF (coords EQ 'G') THEN BEGIN
     l=long
     b=lat
  ENDIF
  
  phi=l*(!dpi/180.)
  theta=(90-b)*(!dpi/180.)

  return
END

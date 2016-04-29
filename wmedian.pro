FUNCTION wmedian,data,weights=weights

  IF (n_elements(weights) EQ 0) THEN weights=fltarr(n_elements(data))+1.

  sweights=weights[bsort(data)]
  sdata=data[bsort(data)]
  totw=total(sweights)
  totsofar=sweights[0]
  i=1L
  WHILE (totsofar LE totw/2.) DO BEGIN
     totsofar=totsofar+sweights[i]
     i=i+1
  ENDWHILE
  meddata=sdata[i-1]

 return,meddata
END

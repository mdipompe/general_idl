;+
;  NAME:
;    closest2d
;
;  PURPOSE:
;    Given arrays x and y, find indices of values in y closest to each
;    value in x
;
;  USE:
;    indx=closest2d(x,y)
;
;  INPUT:
;    x - array of values to find closest matches to
;    y - array of values to find indices of
;
;  OPTIONAL INPUT:
;    
;  KEYWORDS:
;        
;  OUTPUT:
;    Returns indices of y closest to each x
;
;  Notes:
;    Requires bsort and match2 (from IDL astro library)
;
;  HISTORY:
;    12-5-2017 - Written - MAD (Dartmouth)
;-
FUNCTION closest2D,x,y

  ;MAD Sort y so value locate works
  newy=y[bsort(y)]
  ;MAD Find indices of closest value without going over
  bin=value_locate(newy,x)
  ;MAD If values of x are lower than any y, value locate
  ;returns -1. This can have weird effects depending on IDL version
  ;so I just change these to the first index
  xx=where(bin EQ -1,cnt)
  IF (cnt NE 0) THEN bin[xx]=0
  ;MAD Get difference between x and y for two nearest values, put in 
  ;n_elements(x) x 2 array
  diff=[[abs(x-newy[bin])],[abs(x-newy[bin+1])]]
  ;MAD Figure out which y value of the two is closest
  tmp=min(diff,indx,dim=2)
  s=size(diff)
  row=indx/s[1]
  ;MAD Match back to original to undo the sorting
  match2,y,newy[bin+row],ind1,ind2

  return,ind2
END

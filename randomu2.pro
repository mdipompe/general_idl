;+
;  NAME:
;    randomu2
;  PURPOSE:
;    Wrapper for randomu where you can provide minimum and maximum of
;    distribution explicitly.  Defaults to behaving just like randomu.
;
;  USE:
;    x=randomu(n=n,min=min,max=max,seed=seed)
;
;  Optional Inputs:
;    n - number of points to generate (default 1)
;    max - maximum value of distribution (default 1)
;    min - minimum value of distribution (default 0)
;    seed - seed for random number generater (defaults to systime_seed)
;
;  OUTPUT:
;    dist - array of size n of values from uniform distribution
;
;  HISTORY:
;    12-7-14 - Written - MAD (UWyo)
;-
FUNCTION randomu2,n=n,min=min,max=max,seed=seed

  IF ~keyword_set(n) THEN n=1
  IF ~keyword_set(max) THEN max=1
  IF ~keyword_set(min) THEN min=0
  
  IF keyword_set(seed) THEN $
     dist=(randomu(seed,n)*(max-min))+min ELSE $
        dist=(randomu(systime_seed,n)*(max-min))+min

  return,dist
END

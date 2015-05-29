;+
;  NAME:
;    randomg
;  PURPOSE:
;    Wrapper for randomn where you explicitly just supply the mean and
;    standard deviation to get any Gaussian distribution.  All inputs
;    are optional, but if not supplied behaves just like standard randomn
;
;  USE:
;    x=randomg(n=n,mean=mean,sd=sd,seed=seed)
;
;  Optional Inputs:
;    n - number of points to generate (default 1)
;    mean - mean of distribution (default 0)
;    sd - standard deviation (default 1)
;    seed - seed for random number generater (defaults to systime_seed)
;
;  OUTPUT:
;    gdist - array of size n of values from Gaussian distribution
;
;  HISTORY:
;    12-7-14 - Written - MAD (UWyo)
;-
FUNCTION randomg,n=n,mean=mean,sd=sd,seed=seed

  IF ~keyword_set(n) THEN n=1
  IF ~keyword_set(mean) THEN mean=0
  IF ~keyword_set(sd) THEN sd=1

  IF keyword_set(seed) THEN $
     gdist=(randomn(seed,n)*sd)+mean ELSE $
        gdist=(randomn(systime_seed,n)*sd)+mean

  return,gdist
END

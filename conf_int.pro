;+
;  NAME:
;    conf_int
;  PURPOSE:
;    Find symmetric confidence interval of a data set out to some percentage
;
;  USE:
;    res = conf_int(data,mode,sig=sig,stepsize=stepsize)
;
;  INPUT:
;    data - data points
;    mode - most common value of data
;
;  OPTIONAL INPUT:
;    sig - which confidence interval you want (defaults to 67.268%)
;    stepsize - how to step through data (defaults to 0.001, limits
;               precision
;    
;  OUTPUT:
;    Returns symmetric confidence intervals
;
;  NOTES:
;
;  HISTORY:
;    8-26-16 - Written - MAD (Dartmouth)
;-
FUNCTION conf_int,data,mode,sig=sig,stepsize=stepsize
  ;MAD Set defaults
  IF ~keyword_set(sig) THEN sig=0.6826895
  IF ~keyword_set(stepsize) THEN stepsize=0.001

  ;MAD Initialize first step
  reach=mode+stepsize
  i=0.
  WHILE (reach LE max(data)) DO BEGIN
     halfwidth=stepsize*i
     reach=mode+halfwidth
     num=n_elements(where(data GE mode[0]-halfwidth[0] AND $
                          data LE mode[0]+halfwidth[0]))
     frac=num*(1./n_elements(data))
     IF (n_elements(halfwidths) EQ 0) THEN halfwidths=halfwidth ELSE $
        halfwidths=[halfwidths,halfwidth]
     IF (n_elements(fracs) EQ 0) THEN fracs=frac ELSE $
        fracs=[fracs,frac]
     i=i+1
  ENDWHILE
  err=halfwidths[closest(fracs,sig)]
  return,err
END

FUNCTION new_sample,data,errs,n=n,seed=seed

  ;Take a sample with errors, and make (a) new one(s)
  ;by randomly sampling from distributions.
  ;Each row of output is a new sample with same size
  ;as original, with points randomly shifted according to errors.
  
  IF ~keyword_set(n) THEN BEGIN
     IF ~keyword_set(seed) THEN $
        out=(randomn(systime_seed,n_elements(data))*errs)+data ELSE $
           out=(randomn(seed,n_elements(data))*errs)+data
  ENDIF ELSE BEGIN
     IF ~keyword_set(seed) THEN $
        out=(randomn(systime_seed,n_elements(data),n)*rebin(errs,n_elements(data),n))+rebin(data,n_elements(data),n) ELSE $
           out=(randomn(seed,n_elements(data),n)*rebin(errs,n_elements(data),n))+rebin(data,n_elements(data),n)
  ENDELSE
  
  return,out
END

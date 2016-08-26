+
;  NAME:
;    norm_pdf
;  PURPOSE:
;    Find probability that data is (are) from a Normal distribution
;      with specified mean and standard deviation
;
;  USE:
;    prob = norm_pdf(data,mu=mu,sd=sd)
;
;  INPUT:
;    data - data point(s) to get probability(s) for
;    
;  OPTIONAL INPUT:
;    mu - mean of Normal dist (defaults to 0)
;    sd - standard deviation of normal distributions (defaults to 1)
;    
;  OUTPUT:
;    Returns array of same dimension as data with
;      probability data are from Normal distribution
;
;  NOTES:
;
;  HISTORY:
;    8-26-16 - Written - MAD (Dartmouth)
;-
FUNCTION norm_pdf,data,mu=mu,sd=sd

  ;MAD Set defaults
  IF ~keyword_set(mu) THEN mu=0.
  IF ~keyword_set(sd) THEN sd=1.

  ;MAD get probabilities
  x=exp(((-1)*((data-mu)^2.))/(2*sd^2.))/sqrt(2.*!dpi*sd^2.)

  return,x
END

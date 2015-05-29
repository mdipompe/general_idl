;+
;  NAME:
;    app
;  PURPOSE:
;    Convert absolute to apparent magnitude, with a k-correction
;
;  USE:
;    ppM=appmag(M,z,h=h,om=om,lambda=lambda,kcorr=kcorr,alpha=alpha)
;
;  INPUT:
;    m - absolute magnitude
;    z - redshift
;
;  OPTIONAL INPUT:
;    h - little h (H_0/100). Defaults to 0.71
;    om - omega_matter.  Defaults to 0.27
;    lambda - omega_lambda. Defaults to 0.73
;    kcorr - k_correction value.  Can supply a spectral slope instead
;            to calculate this
;    alpha - Supply this slope to calculate kcorrection
;
;  KEYWORDS:
;        
;  OUTPUT:
;    apparent magnitude
;
;  Notes:
;    relies on cosmocalc.pro
;
;  HISTORY:
;    2013 - Written - MAD (UWyo)
;    2015 - Cleaned and documented - MAD (UWyo)
;-
FUNCTION absmag,m,z,h=h,om=om,lambda=lambda,kcorr=kcorr,alpha=alpha

  ;MAD Get luminosity distance
  distance=cosmocalc(z,h=h,om=om,lambda=lambda)

  ;MAD Convert to pc
  dlpc=distance.d_L*1e6

  IF keyword_set(kcorr) THEN kc=kcorr
  IF keyword_set(alpha) THEN kc=-2.5*(1.+alpha)*ALOG10(1.+z)
  IF (~keyword_set(kcorr) AND ~keyword_set(alpha)) THEN kc=0

  appmag=m-5.+5.*ALOG10(dlpc)+kc

  return,appmag

END

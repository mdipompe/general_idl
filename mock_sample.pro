;+
;  NAME:
;    mock_sample
;  PURPOSE:
;    Fit a spline to a distribution, then generate a mock sample with
;    N data points that have that same distribution.  
;
;  USE:
;    mock_sample,data,binsize,N,mockout,outfile=outfile
;
;  INPUT:
;    data - the original data
;    binsize - binning to apply before fit
;    n - number of points in the mock sample
;
;  OPTIONAL INPUT:
;    outfile - set to write a file with the mock data
;
;  KEYWORDS:        
;
;  OUTPUT:
;    mockdata
;    plots to screen
;
;  NOTES:
;    Ignores bins with 0 points (interpolates over them)
;
;  HISTORY:
;    2013 - Written - MAD (UWyo)
;    2015 - Cleaned and documented - MAD (UWyo)
;-
PRO mock_sample,data,binsize,n,mockdata,outfile=outfile

IF (n_elements(binsize) EQ 0) THEN message,'Syntax - mock_sample,data,binsize,n,mockout,outfile=''out.txt'''

;MAD Bin the values
h=histogram(data,binsize=binsize,min=0,max=max(data),locations=x)
x=x+(binsize/2)
;MAD Set array of x values corresponding to histogram vals for fit
;x=fltarr((max(data)/binsize)+1)
;x[0]=binsize/2.
;i=1
;WHILE (max(x) LE max(data)) DO BEGIN
; x[i]=x[i-1]+binsize
; i=i+1
;ENDWHILE
xx=where(h NE 0)
h=h[xx]
x=x[xx]

x=[0,x]
h=[0,h]

;MAD Generate array of x values for fit
x2=findgen(max(data)*1001)/1000.

;MAD Fit cubic spline, normalize fit
fit=spline(x,h,x2)
normfit=fit/max(fit)

;MAD Set seeds for random number generator
seed1=615
seed2=246

;MAD Generate n mock values
mockdata=0
WHILE (n_elements(mockdata) LT n+1.) DO BEGIN
 tmp_n=randomu(seed2)
 tmp_z=floor(randomu(seed1)*max(data)*1000.)/1000.
 IF ((tmp_n LE normfit[where(x2 EQ tmp_z)]) AND (tmp_z GE 0.)) THEN mockdata=[mockdata,tmp_z]
ENDWHILE
mockdata=mockdata[1:n_elements(mockdata)-1]

;MAD Make a plot
plothist,data,bin=binsize,peak=1,yra=[0,1.2],ysty=1,xtit='values',ytit='Normalized N'
plothist,mockdata,bin=binsize/10.,peak=1,color=cgcolor('blue'),/over
oplot,x2,normfit,linestyle=2,color=cgcolor('red'),thick=3


;MAD Write out a final file
IF keyword_set(outfile) THEN BEGIN
   openw,1,outfile
   FOR i=0L,n_elements(mockdata)-1 DO BEGIN
      printf,1,mockdata[i]
   ENDFOR
   close,1
ENDIF

return
END

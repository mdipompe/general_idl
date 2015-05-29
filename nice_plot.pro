;+
;  NAME:
;    nice_plot
;  PURPOSE:
;    Set up a plot window with some nice looking properties for output
;    to screen or png file.  Thick lines, bigger text, etc.  Works
;    well with an output xsize~11, ysize~9
;
;  USE:
;    nice_plot,xmin,xmax,ymin,ymax,xtit=xtit,ytit=ytit,/xlog,/ylog
;
;  INPUT:
;    x/ymin,x/ymax - the ranges of the x/y axes
;
;  OPTIONAL INPUT:
;    x/ytit - axis titles
;
;  KEYWORDS:
;    xlog - x axis in log
;    ylog - y axis in log
;
;  OUTPUT:
;    
;  NOTES:
;
;  HISTORY:
;    10-31-13 - Written - MAD (UWyo)
;    2015 - Cleaned and documented - MAD (UWyo)
;-
PRO nice_plot,xmin,xmax,ymin,ymax,xtit=xtit,ytit=ytit,xlog=xlog,ylog=ylog

IF ~keyword_set(xtit) THEN xtit=' '
IF ~keyword_set(ytit) THEN ytit=' '

plot,[0],[0],psym=0,$
     xra=[xmin,xmax],yra=[ymin,ymax],xsty=1,ysty=1,$
     xtit=xtit,ytit=ytit,thick=5,xthick=5,ythick=5,$
     charthick=2.0,charsize=2.0,xlog=xlog,ylog=ylog

END

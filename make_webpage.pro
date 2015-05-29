;+
;  NAME:
;    make_webpage
;  PURPOSE:
;    Make a webpage of SDSS image server cutouts at various
;    positions.  Useful for eye-balling your objects
;
;  USE:
;    make_webpage, 'directory', 'something.html',ra,dec,/getcharts, /create
;
;  INPUT:
;    webpagedirec - location to place html and image files.  Will create
;                   in current directory if /create is set
;    webpagename - name of html file
;    ra - center of image (degrees), can be list
;    dec - center of image (degrees), can be list
;
;  OPTION INPUT:
;    
;  KEYWORDS:
;    getcharts - without set, will just make the page.  With set, will
;                ping SDSS server
;    create - set to create the webdirectory in current directory        
;
;  OUTPUT:
;    
;  HISTORY:
;    12-1-12 - Written - ADM (UWyo)
;    2015 - Cleaned up, documented, etc. - MAD (UWyo)
;-
PRO make_webpage, webpagedirec, webpagename, ra, dec, getcharts=getcharts, create=create

  ;MAD Create directory if needed
  IF keyword_set(create) THEN BEGIN
     cmd=['mkdir',webpagedirec]
     spawn,cmd,/noshell
  ENDIF

  ;MAD If getting charts, make charts directory in webpagedir
  IF keyword_set(getcharts) THEN BEGIN
     cmd=['mkdir',webpagedirec+'/charts']
     spawn,cmd,/noshell
  ENDIF

  splog, 'MAKING ', webpagename
  splog, 'IN DIRECTORY ', webpagedirec

  webpagename = webpagedirec+'/'+webpagename

  ntargs = n_elements(ra)

  cols = 2 ; ADM how many columns on the webpage?
  rowends = where(indgen(ntargs) mod cols)

  ;ADM get ra and dec of targets
  ras = strcompress(ra,/rem)
  decs = strcompress(dec,/rem)

  ;ADM hit SDSS server for the finding charts
  ;ADM quotes at end and start needed to bracket file name
  serv = '"http://skyservice.pha.jhu.edu/DR8/ImgCutout/getjpeg.aspx?'
  options = '&scale=0.5&width=300&height=300"'

  outfile = "charts/findchart-ra="+ras+"-dec="+decs+".jpeg"

  cmd =  'wget -O "'+webpagedirec+"/"+outfile+'" '+serv
  cmd += "ra="+ ras+"&dec="+decs+options
  cmd += " | csh"

  if keyword_set(getcharts) then begin
     for i = 0L, ntargs-1L do  begin
        spawn, cmd[i]
        splog, cmd[i]
        spawn, 'sleep 2'  ;ADM don't hit the server too often
     endfor
  endif

  ;ADM write webpage that links to finding charts
  ;ADM based on input filename
  webhead = "<HTML>"
  webhead += '<TABLE CELLSPACING=0 CELLPADDING=10 WIDTH="100%" NOSAVE><TR>'
  webbody = "<TD><IMG WIDTH=300 SRC="+outfile+"></TD>"
  webbody += "<TD>"+ras+","+decs+"</TD>"
  webbody[rowends] += "</TR><TR>"
  webtail = "</TABLE>"
  webtail += "</HTML>"
  
  cmd = "echo '"+webhead+"' > "+webpagename
  spawn, cmd
  cmd = "echo '"+webbody+"' >> "+webpagename
  for i = 0L, ntargs-1L do $
     spawn, cmd[i]

  cmd = "echo '"+webtail+"' >> "+webpagename
  spawn, cmd

END

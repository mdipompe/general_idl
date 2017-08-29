;+
;NAME
;   pixelize
;
;PURPOSE
;   IDL wrapper for MANGLE function pixelize, which splits up
;   polygons according to a user-specified scheme
;
;USAGE
;   pixelize,'scheme','inpolys','outpolys'
;
;INPUTS
;   scheme - string specifying scheme (e.g. '6s')
;   inpolys - string name of mangle polygon file of polygons to
;             pixelize
;   outpolys - string name of mangle polygon file to write pixelized
;              polygons to
;
;OPTIONAL INPUTS
;
;OUTPUTS
;
;NOTES
;   Must have environment variable MANGLEBINDIR set to location of
;   mangle binaries
;
;HISTORY
;   6-12-15 - Written - MAD (UWyo)
;-
PRO pixelize,scheme,inpolys,outpolys

;MAD Make scheme string
scheme1=strmid(scheme,0,1)
scheme2=strmid(scheme,1,1)
schemestr='-P'+scheme2+'0,'+scheme1

;MAD Make and run command
cmd=[filepath('pixelize', root_dir=getenv('MANGLEBINDIR')), $
     schemestr,inpolys,outpolys]

print,'Running PIXELIZE with command: '
print,cmd

spawn,cmd,/noshell

RETURN
END

;+
;NAME
;   ransack
;
;PURPOSE
;   IDL wrapper for MANGLE function ransack, which populates
;   polygons with N random points
;
;USAGE
;   ransack,n,poly_file,outfile,seed=seed
;
;INPUTS
;   n - Number of random points to generate
;   polyfile - string name of file containing MANGLE polygons
;               to fill
;   outfile - string name of text file for ransack to output.
;             Contains two columns, RA and DEC
;
;OPTIONAL INPUTS
;   seed - Seed for random number generator.  Defaults to generating
;          random integer from 1 to 1000 using systime_seed.
;   precision - number of digits beyond the decimal place to
;               use. Defaults to 9.
;
;OUTPUTS
;
;NOTES
;   Must have environment variable MANGLEBINDIR set to location
;   of MANGLE binaries
;
;HISTORY
;   1-5-15 - Written - MAD (UWyo)
;  7-24-17 - Added precision keyword - MAD (Dartmouth)
;-
PRO ransack,n,polyfile,outfile,seed=seed,precision=precision

;MAD Set defaults
IF ~keyword_set(seed) THEN seed = ceil(randomu(systime_seed)*1000)
IF ~keyword_set(precision) THEN precision=9

;MAD Make string command to run
cmd=[filepath('ransack', root_dir=getenv('MANGLEBINDIR')), $
     '-c',strtrim(seed,2), '-r',strtrim(long(n),2), $
     '-p',strtrim(fix(precision),2), $
     polyfile,outfile]

print,'Running RANSACK with command: '
print,cmd

spawn,cmd,/noshell

RETURN
END

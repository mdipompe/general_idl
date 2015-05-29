;+
;  NAME:
;    read_square_matrix
;  PURPOSE:
;    read in a matrix from a text file
;
;  USE:
;    read_square_matrix,dimension,'filename.txt',matrix           
;
;  INPUT:
;    dim - dimension of matrix (width or height)
;    file - string name of file to read
;
;  OUTPUT:
;    matrix - the array read from the file
;
;  NOTES:
;    Replaced by the more general read_matrix.pro.  Kept for sake of
;    other codes that rely on it, but I wouldn't recommend using it...
;
;  HISTORY:
;    11-11-14 - Written - MAD (UWyo)
;    4-20-15 - Replaced by read_matrix.pro - MAD (UWyo)
;-
PRO read_square_matrix,dim,file,C

C=dblarr(dim,dim)
openr,1,file
i=0L
WHILE (not EOF(1)) DO BEGIN
   line=''
   readf,1,line
   xx=strsplit(line,' ',/extract)
   FOR j=0L,dim-1 DO BEGIN
      C[j,i]=xx[j]
   ENDFOR
   i=i+1
ENDWHILE
close,1

return

END

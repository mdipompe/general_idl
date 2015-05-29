;+
;  NAME:
;    read_matrix
;  PURPOSE:
;    read in a matrix from a text file
;
;  USE:
;    matrix = read_square_matrix('filename.txt')           
;
;  INPUT:
;    file - string name of file to read
;
;  RETURNS:
;    matrix - the array read from the file
;
;  HISTORY:
;    5-12-15 - Written - MAD (UWyo)
;-
FUNCTION read_matrix,file

  ;Get dimensions by counting number of lines
  openr,1,file
  WHILE (not EOF(1)) DO BEGIN
     line=''
     readf,1,line
     xx=strsplit(line,' ',/extract)
     IF (n_elements(C) EQ 0) THEN C=double(xx) ELSE C=[[C],[double(xx)]]
  ENDWHILE
  close,1

  return,C
END



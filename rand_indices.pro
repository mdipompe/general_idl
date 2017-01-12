;+
;NAME
;   rand_indices
;
;PURPOSE
;   Generates random indices for an array *without replacement*
;
;USAGE
;   indices = rand_indices(input_length, n_out)
;
;INPUTS
;   input_length - number of elements in original array
;   n_out - number of unique indices desired
;
;OPTIONAL INPUTS
;
;OUTPUTS
;
;NOTES
;
;HISTORY
;   11-2-16 - Written - MAD (UWyo)
;-
FUNCTION rand_indices, input_length, n_out
  swap = n_out gt input_length/2
  IF swap THEN n = input_length-n_out ELSE n = n_out
  inds = LonArr(n, /NOZERO)
  M = n
  WHILE n GT 0 DO BEGIN
     inds[M-n] = Long( RandomU(seed, n)*input_length)
     inds = inds[Sort(inds)]
     u = Uniq(inds)
     n = M-n_elements(u)
     inds[0] = inds[u]
  ENDWHILE
  
  IF swap THEN inds = Where(Histogram(inds,MIN=0,MAX=input_length-1) EQ 0)
  RETURN, inds
end

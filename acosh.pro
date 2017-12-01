FUNCTION acosh,z
  return, alog(z+(sqrt(z+1)*sqrt(z-1)))
END

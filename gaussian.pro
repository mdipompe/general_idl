FUNCTION gaussian,x,p

area=p[0]
mu=p[1]
sd=p[2]
ymod=area*exp(((-1)*((x-mu)^2.))/(2*sd^2.))/sqrt(2.*!dpi*sd^2.)


return,ymod

END

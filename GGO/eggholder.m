function myeggholder=eggholder(X1)
X2=1.369;
myeggholder = -(X2+47) .* sin(sqrt(abs(X1/2+(X2+47)))) - X1 .* sin(sqrt(abs(X1-(X2+47))));
 end
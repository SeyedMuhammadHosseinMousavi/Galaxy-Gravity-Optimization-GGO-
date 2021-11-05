function brok=rosenbrock(X1)
X2=2;
brok= sum( 100*(X2 - X1.^2).^2 + (1 - X1).^2, 1);
end
function y = ackley(x)
% Ackley function.
a = 20; b = 0.2; c = 2*pi;
s1 = 0; s2 = 0;
n = length(x);
for i=1:n;
   s1 = s1+x(i)^2;
   s2 = s2+cos(c*x(i));
end
y = -a*exp(-b*sqrt(1/n*s1))-exp(1/n*s2)+a+exp(1);
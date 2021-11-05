function bealefcn=beale(x1)
x2=2.65;
bealefcn = (1.5 - x1 + x1.*x2).^2 + (2.25 - x1 + x1.*x2.^2).^2 + (2.625 - x1 + x1.*x2.^3).^2;
end
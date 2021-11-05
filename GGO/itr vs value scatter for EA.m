clc;clear;
a = 0;b = 20;
for i=1:100
itr(i:100,1)=i;
end;
value = ((b-a).*rand(100,1)) + a;   
value=sort(value);
plot(itr,value);

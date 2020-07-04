close all ; clear all ; clc

CID = [1 0 7 7 2 1 9];

% b = mod(a,m) returns the remainder after division of a by m
for i=1:length(CID)
    states(i) = mod((CID(i) +2),3);
end

for i=1:length(CID)
    rewards(i) = mod(CID(i),2);
end

z=9;

j=mod((z+1),3)+1;

P=[0.25,0.25,0.5 ;
   1   ,0   ,0   ;
   1   ,0   ,0   ;];

gamma=0.9;

I=eye(3);

K=I-gamma*P;
m = K^-1;

a=1;

v2 = 3*a -2*(a^2) + a + (a^3) -3*(a^2) + 2*(a^3)

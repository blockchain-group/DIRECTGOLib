function [c, ceq] = Bunnag7c( x )
c(1) = -2*x(1)-6*x(2)-x(3)-3*x(5)-3*x(6)-2*x(7)-6*x(8)-2*x(9)-2*x(10)+4;
c(2) = 6*x(1)-5*x(2)+8*x(3)-3*x(4)+x(6)+3*x(7)+8*x(8)+9*x(9)-3*x(10)-22;
c(3) = -5*x(1)+6*x(2)+5*x(3)+3*x(4)+8*x(5)-8*x(6)+9*x(7)+2*x(8)-9*x(10)+6;
c(4) = 9*x(1)+5*x(2)-9*x(4)+x(5)-8*x(6)+3*x(7)-9*x(8)-9*x(9)-3*x(10)+23;
c(5) = -8*x(1)+7*x(2)-4*x(3)-5*x(4)-9*x(5)+x(6)-7*x(7)-x(8)+3*x(9)-2*x(10)+12;
ceq = [];
end
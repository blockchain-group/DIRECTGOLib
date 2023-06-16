function [c, ceq] = P9c( x )
    c(1) = -4*x(1) + (4/3)*x(2) - 6; 
    c(2) = -x(2) + (1/2)*x(3) - 2; 
    c(3) = -x(1) + (1/3)*x(2) - 2; 
    c(4) = x(1) + 2*(-x(1) + (1/3)*x(2)) - 4; 
    c(5) = x(2) + (-x(2) + (1/2)*x(3)) - 4; 
    c(6) = x(3) + (-4*x(1) + (4/3)*x(2)) - 6; 
    c(7) = -(-4*x(1) + (4/3)*x(2)); 
    c(8) = -(-x(2) + (1/2)*x(3)); 
    c(9) = -(-x(1) + (1/3)*x(2)); 
    ceq = [];
end
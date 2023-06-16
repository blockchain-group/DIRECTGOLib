function [c, ceq] = zecevic2c(x)
    c(1) = x(1) + x(2) - 2;  
    c(2) = x(1) + 4*x(2) - 4; 
    ceq = [];
end
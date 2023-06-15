function [c, ceq] = Ji2c( x )
    c(1) = 6*x(1) + 3*x(2) + 3*x(3) - 10;
    c(2) = 10*x(1) + 3*x(2) + 8*x(3) - 10; 
    ceq = [];
end
function [c, ceq] = Genocop9c(x)
    c(1) = x(1) + x(2) - x(3) - 1; 
    c(2) = -x(1) + x(2) - x(3) + 1; 
    c(3) = 12*x(1) + 5*x(2) + 12*x(2) - 34.8;
    c(4) = 12*x(1) + 12*x(2) + 7*x(3) - 29.1;
    c(5) = -6*x(1) + x(2) + x(3) + 4.1; 
    ceq = [];
end
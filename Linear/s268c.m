function [c, ceq] = s268c( x )
    c(1) = -(-1*x(1) - x(2) - x(3) - x(4) - x(5) + 5);
    c(2) = -(10*x(1) + 10*x(2) - 3*x(3) + 5*x(4) + 4*x(5) - 20);
    c(3) = -(-8*x(1) + x(2) - 2*x(3) - 5*x(4) + 3*x(5) + 40);
    c(4) = -(8*x(1) - x(2) + 2*x(3) + 5*x(4) - 3*x(5) - 11);
    c(5) = -(-4*x(1) - 2*x(2) + 3*x(3) - 5*x(4) + x(5) + 30);
    ceq = [];
end
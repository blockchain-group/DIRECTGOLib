function [c, ceq] = Michalewicz1c( x )
    c(1) = -(x(1)/sqrt(3) - x(2));
    c(2) = -(-x(1) - sqrt(3)*x(2) + 6);
    c(3) = x(1) - 6;
    ceq = [];
end
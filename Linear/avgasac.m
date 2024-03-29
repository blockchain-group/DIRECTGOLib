function [c, ceq] = avgasac( x )
    c    = zeros(1, 10);
    c(1) = -(2*x(1) + x(3) - x(7));
    c(2) = -(5*x(1) + 3*x(3) - 3*x(5) - x(7));
    c(3) = -(x(2) - x(4) - 3*x(6) - 5*x(8));
    c(4) = -(x(2) - 3*x(6) - 2*x(8));
    c(5) = x(2*1 - 1) + x(2*1) - 1;
    c(6) = x(2*2 - 1) + x(2*2) - 1;
    c(7) = x(2*3 - 1) + x(2*3) - 1;
    c(8) = x(2*4 - 1) + x(2*4) - 1;
    for i = 1:4
        c(9) = c(9) + x(2*i) - 2;
        c(10) = c(10) + x(2*i - 1) - 2;
    end
    ceq  = [];
end
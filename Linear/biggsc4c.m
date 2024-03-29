function [c, ceq] = biggsc4c( x )
    c(1)  = -(x(1) + x(2) - 2.5);
    c(2)  = -(x(1) + x(3) - 2.5);
    c(3)  = -(x(1) + x(4) - 2.5);
    c(4)  = -(x(2) + x(3) - 2.0);
    c(5)  = -(x(2) + x(4) - 2.0);
    c(6)  = -(x(3) + x(4) - 1.5);
    c(7)  = x(1) + x(2) - 2.5 - 5.0;
    c(8)  = x(1) + x(3) - 2.5 - 5.0;
    c(9)  = x(1) + x(4) - 2.5 - 5.0;
    c(10) = x(2) + x(3) - 2.0 - 5.0;
    c(11) = x(2) + x(4) - 2.0 - 5.0;
    c(12) = x(3) + x(4) - 1.5 - 5.0;
    c(13) = -(x(1) + x(2) + x(3) + x(4) - 5.0);
    ceq   = [];
end
function y = NASA_Speed_ReducerC1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   NASA_Speed_ReducerC1.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 2994.424465756735
%   x* = [3.5; 0.7; 17; 7.3; 7.71531991147825; 3.35054094910589; 5.28665446498022]
%   
% Problem Properties:
%   n  = 7;
%   #g = 11;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 7;
    y.ng = 11;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = 0.7854*x(1)*x(2)^2*(3.3333*x(3)^2 + 14.9334*x(3) - 43.0934) - 1.508*x(1)*(x(6)^2 + x(7)^2).....
     + 7.477*(x(6)^3 + x(7)^3) + 0.7854*(x(4)*x(6)^2 + x(5)*x(7)^2);
end

function [g, ceq] = ConFun( x )
    g(1) = -x(1)*x(2)^2*x(3) + 27;
    g(2) = -x(1)*x(2)^2*x(3)^2 + 397.5;
    g(3) = -x(2)*x(6)^4*x(3)*x(4)^( - 3) + 1.93;
    g(4) = -x(2)*x(7)^4*x(3)/x(5)^3 + 1.93;
    g(5) = 10*x(6)^(-3)*sqrt(16.91*10^6 + (745*x(4)/(x(2)*x(3)))^2) - 1100;
    g(6) = 10*x(7)^(-3)*sqrt(157.5*10^6 + (745*x(5)/(x(2)*x(3)))^2) - 850;
    g(7) = x(2)*x(3) - 40;
    g(8) = -x(1)/x(2) + 5;
    g(9) = x(1)/x(2) - 12;
    g(10) = 1.5*x(6) - x(4) + 1.9;
    g(11) = 1.1*x(7) - x(5) + 1.9;
    ceq = [];
end

function xl = get_xl(~)
    xl = [2.6; 0.7; 17; 7.3; 7.3; 2.9; 5];
end

function xu = get_xu(~)
    xu = [3.6; 0.8; 28; 8.3; 8.3; 3.9; 5.5];
end

function fmin = get_fmin(~)
    fmin = 2994.424465756735;
end

function xmin = get_xmin(~)
    xmin = [3.5; 0.7; 17; 7.3; 7.71531991147825; 3.35054094910589; 5.28665446498022];
end
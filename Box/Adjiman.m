function y = Adjiman(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Adjiman.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = -2.02180678335979
%   x = [2, 0.105783468176042]
%
% Default variable bounds:
%   -1 <= x(i) <= 2, i = 1...n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -1; 
    y.xu = @(i) 2;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = cos(x(1))*sin(x(2)) - (x(1)/(x(2)^2 + 1));
end

function fmin = get_fmin(~)
    fmin = -2.02180678335979;
end

function xmin = get_xmin(~)
    xmin = [2; 0.105783468176042];
end
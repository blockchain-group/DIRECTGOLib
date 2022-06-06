function y = BartelsConn(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   BartelsConn.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = 1
%   x = [0, 0]
%
% Default variable bounds:
%   -500 <= x(i) <= 500, i = 1, ..., n
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
    y.xl = @(i) -500; 
    y.xu = @(i) 500;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = abs(x(1)^2 + x(2)^2 + x(1)*x(2)) + abs(sin(x(1))) + abs(cos(x(2)));
end

function fmin = get_fmin(~)
    fmin = 1;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
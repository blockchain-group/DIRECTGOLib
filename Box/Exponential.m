function y = Exponential(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Exponential.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = 1
%   x = 0;
%
% Default variable bounds:
%   -1 <= x(i) <= 4, i = 1,...,n
%
% Problem Properties:
%   n  = any;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -1;
    y.xu = @(i) 4;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
a = 0;
for i = 1: length(x)
    a = a + x(i)^2;
end
y = -exp(-0.5*a);
end 

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
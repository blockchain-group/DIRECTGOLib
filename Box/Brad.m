function y = Brad(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Brad.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = 6.93522806970522
%   x = [-0.25, 2.5, 2.5]
%
% Default variable bounds:
%   -0.25 <= x(1) <= 0.25
%   0.01  <= x(2) <= 2.5
%   0.01  <= x(3) <= 2.5
%
% Problem Properties:
%   n  = 3;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 0;
    y.nh = 0;
    xl = [-0.25, 0.01, 0.01];
    y.xl = @(i) xl(i); 
    xu = [0.25, 2.5, 2.5];
    y.xu = @(i) xu(i);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
T = [0.14, 0.18, 0.22, 0.25, 0.29, 0.32, 0.35, 0.39,...
    0.37, 0.58, 0.73, 0.96, 1.34, 2.10, 4.39];
y = 0;
for i = 1:15
    a = 16 - i;
    b = min([i, a]);
    y = y + ((T(i) - x(1) - i)/(a*x(2) + b*x(3)))^2;
end
end

function fmin = get_fmin(~)
    fmin = 6.93522806970522;
end

function xmin = get_xmin(~)
    xmin = [-0.25; 2.5; 2.5];
end
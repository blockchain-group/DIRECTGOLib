function y = XinSheYajngN2(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   XinSheYajngN2.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = 0;
%   x = 0, i = 1...n
%
% Default variable bounds:
%   -pi <= x(i) <= pi, i = 1...n
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
    y.xl = @(i) -pi;
    y.xu = @(i) pi;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end  
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = sum(abs(x))*exp(-sum(sin(x.^2)));
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
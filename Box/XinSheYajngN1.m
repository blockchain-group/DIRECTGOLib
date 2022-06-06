function y = XinSheYajngN1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   XinSheYajngN1.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = -1;
%   x = 0, i = 1...n
%
% Default variable bounds:
%   11 <= x(i) <= 29, i = 1...n
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
    y.xl = @(i) -11;
    y.xu = @(i) 29;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end  
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = exp(-sum((x'/15).^(2*5), 2)) - (2*exp(-sum(x'.^ 2, 2)).*prod(cos(x').^ 2, 2));
end 

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
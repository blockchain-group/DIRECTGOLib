function y = Dolan(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Dolan.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = -529.8714387324576
%   x = [98.964258312237106, 100, 100, 99.224323672554704, -0.249987527588471];
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1,...,n
%
% Problem Properties:
%   n  = 5;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -100;
    y.xu = @(i) 100;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end

if size(x, 2) > size(x, 1)
    x = x'; 
end
y = (x(1) + 1.7*x(2))*sin(x(1)) - 1.5*x(3) - 0.1*x(4) * cos(x(4) + x(5)...
    - x(1)) + 0.2*x(5)^2 - x(2) - 1;
end 

function fmin = get_fmin(~)
    fmin = -529.8714387324576;
end

function xmin = get_xmin(~)
    xmin = [98.964258312237106; 100; 100; 99.224323672554704; -0.249987527588471];
end
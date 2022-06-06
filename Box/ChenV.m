function y = ChenV(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   ChenV.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = -2000.0009999990
%   x = [0.5, -0.5]
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...4
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
    y.xu = @(i) +500;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = -(0.001/(0.001^2 + (x(1)^2 - x(2)^2 - 1)^2)) -...
     (0.001/(0.001^2 + (x(1)^2 + x(2)^2 - 0.5)^2)) -...
     (0.001/(0.001^2 + (x(1)^2 - x(2)^2)^2));
end  

function fmin = get_fmin(~)
    fmin = -2000.0009999990;
end

function xmin = get_xmin(~)
    xmin = [0.5; -0.5];
end
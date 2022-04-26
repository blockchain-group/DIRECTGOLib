function y = Deb02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Deb02.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_D.html
%
% Globally optimal solution:
%   f = -1
%   x(i) = 1, i = 1...n
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1...n
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) 0;
    y.xu = @(i) 1;
    y.fmin = @(i) -1;
    y.xmin = @(i) 0;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
n = length(x);
y = 0;
for i = 1:n
    y = y + sin(5*pi*(x(i)^(3/4) - 0.5))^6;
end
y = -(1/n)*y;
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1);
end
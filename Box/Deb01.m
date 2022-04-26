function y = Deb01(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Deb01.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_D.html
%
% Globally optimal solution:
%   f = -1
%   x(i) = 0, i = 1...n
%
% Default variable bounds:
%   -1 <= x(i) <= 1, i = 1...n
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
    y.xl = @(i) -1;
    y.xu = @(i) 1;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
n = length(x);
y = 0;
for i = 1:n
    y = y + sin(5*pi*x(i))^6;
end
y = -(1/n)*y;
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*0.1;
end
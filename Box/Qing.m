function y = Qing(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Qing.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_Q.html
%
% Globally optimal solution:
%   f = 0
%   x(i) = [sqrt(i)], i = 1...n
%
% Default variable bounds:
%   -500 <= x(i) <= 500, i = 1...n
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
    y.xl = @(i) -500;
    y.xu = @(i) +500;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

n = length(x);
y = 0;
for i = 1:n
    y = y + (x(i)^2 - i)^2;
end
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
xmin = zeros(nx, 1);
for i = 1:nx
    xmin(i) = i^(1/2);
end
end
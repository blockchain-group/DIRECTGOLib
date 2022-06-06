function y = Trigonometric(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Trigonometric.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_T.html
%
% Globally optimal solution:
%   f = 0
%   x = [0]
%
% Default variable bounds:
%   -100 <= x(1) <= 100
%   -100 <= x(2) <= 100
%
% Problem Properties:
%   n  = 0;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
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
x = x';
n = size(x, 2);
i = repmat(1:n, size(x, 1), 1);
cosX = cos(x);
sumcosX = repmat(sum(cosX, 2), 1, n);
y = sum((n + i.*(1 - cosX) - sin(x) - sumcosX).^2, 2);
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
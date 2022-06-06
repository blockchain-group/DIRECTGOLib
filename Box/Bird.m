function y = Bird(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bird.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_B.html
%
% Globally optimal solution:
%   f = -106.764537
%   x = [4.701055751981055; 3.152946019601391]
%
% Default variable bounds:
%   -2*pi <= x(i) <= 2*pi, i = 1...n
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
    y.xl = @(i) -2*pi;
    y.xu = @(i) 2*pi;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = sin(x(1)).*exp((1-cos(x(2))).^2) +...
    cos(x(2)).*exp((1-sin(x(1))).^2) + (x(1) - x(2)).^2;
end

function fmin = get_fmin(~)
    fmin = -1.067645367198034e+002;
end

function xmin = get_xmin(~)
    xmin = [4.701055751981055; 3.152946019601391];
end
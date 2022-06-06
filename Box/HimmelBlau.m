function y = HimmelBlau(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   HimmelBlau.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_H.html
%
% Globally optimal solution:
%   f = 0
%   x = [3, 2]
%
% Default variable bounds:
%   -5 <= x(1) <= 5
%   -5 <= x(2) <= 5
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
    y.xl = @(i) -5;
    y.xu = @(i) 5;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = (x(1)^2 + x(2) - 11)^2 + (x(1) + x(2)^2 - 7)^2;
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [3; 2];
end
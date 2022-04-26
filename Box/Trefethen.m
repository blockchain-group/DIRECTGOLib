function y = Trefethen(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Trefethen.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_T.html
%
% Globally optimal solution:
%   f = -3.3068686474;
%   x = [-0.0244027376174927, 0.210612416267395]
%
% Default variable bounds:
%   -2 <= x(i) <= 2, i = 1...n
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
    y.xl = @(i) -2;
    y.xu = @(i) 2;
    y.fmin = @(i) -3.3068686474;
    xmin = [-0.0244027376174927, 0.210612416267395];
    y.xmin = @(i) xmin(i);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end   
y = 0.25*x(1)^2 + 0.25*x(2)^2 + exp(sin(50*x(1))) - sin(10*x(1) + 10*x(2))...
    + sin(60*exp(x(2))) + sin(70*sin(x(1))) + sin(sin(80*x(2)));
end

function fmin = get_fmin(~)
    fmin = -3.3068686474;
end

function xmin = get_xmin(~)
    xmin = [-0.0244027376174927; 0.210612416267395];
end
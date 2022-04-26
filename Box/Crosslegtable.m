function y = Crosslegtable(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Crosslegtable.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_C.html
%
% Globally optimal solution:
%   f = -1;
%   x = [0, 0]
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...n
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
    y.xl = @(i) -10; 
    y.xu = @(i) 10; 
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
y = -(abs(sin(x(1))*sin(x(2))*exp(abs(100 - sqrt(x(1)^2 + x(2)^2)/pi))) + 1)^(-0.1);
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
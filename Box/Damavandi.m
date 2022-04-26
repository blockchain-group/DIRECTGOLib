function y = Damavandi(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Damavandi.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_D.html
%
% Globally optimal solution:
%   f = 0;
%   x = [2, 2]
%
% Default variable bounds:
%   0 <= x(i) <= 14, i = 1...n
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
    y.xl = @(i) 0;
    y.xu = @(i) 14;
    y.fmin = @(i) 0;
    y.xmin = @(i) 2;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
y = (1 - abs((sin(pi*(x(1) - 2))).*(sin(pi*(x(2) - 2)))./(pi^2*(x(1) -...
    2).*(x(2) - 2))).^5).*(2 + (x(1) - 7).^2 + 2*(x(2) - 7).^2);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*(2 - 10^(-14));
end
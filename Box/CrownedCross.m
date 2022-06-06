function y = CrownedCross(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   CrownedCross.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_C.html
%
% Globally optimal solution:
%   f = 0.0001
%   x = [0, 0]
%
% Default variable bounds:
%   -10 <= x(1) <= 15
%   -10 <= x(2) <= 15
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
    y.xu = @(i) 15;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = 0.0001*(abs(sin(x(1)).*sin(x(2)).*exp(abs(100 -...
    sqrt(x(1)^2 + x(2)^2)/pi))) + 1).^(0.1);
end  

function fmin = get_fmin(~)
    fmin = 0.0001;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
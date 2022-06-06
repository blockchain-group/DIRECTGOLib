function y = CarromTable(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   CarromTable.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_C.html
%
% Globally optimal solution:
%   f = -24.15681551650653
%   x = [9.646157266348881, 9.646134286497169]
%
% Default variable bounds:
%   -10 <= x(1) <= 10
%   -10 <= x(2) <= 10
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
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = -((cos(x(1)).*cos(x(2)).*exp(abs(1 - sqrt(x(1).^2 + x(2).^2)/pi))).^2)/30;
end

function fmin = get_fmin(~)
    fmin = -24.15681551650653;
end

function xmin = get_xmin(~)
    xmin = [9.646157266348881; 9.646134286497169];
end
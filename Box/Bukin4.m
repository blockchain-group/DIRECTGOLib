function y = Bukin4(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bukin4.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_B.html
%
% Globally optimal solution:
%   f = 0
%   x = [-10; 0]
%
% Default variable bounds:
%   -15 <= x(1) <= 5
%   -3  <= x(2) <= 3
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
    xl = [-15; -3];
    y.xl = @(i) xl(i);
    xu = [5; 3];
    y.xu = @(i) xu(i);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = 100*x(2).^2 + 0.01*abs(x(1) + 10);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [-10; 0];
end
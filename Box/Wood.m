function y = Wood(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Wood.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_W.html
%
% Globally optimal solution:
%   f = 0
%   x = [0, 0]
%
% Default variable bounds:
%   -100 <= x(1) <= 100
%   -100 <= x(2) <= 100
%
% Problem Properties:
%   n  = 4;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
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
y = 100*(x(1)^2 - x(2))^2 + (x(1) - 1)^2 + (x(3) - 1)^2 + 90*(x(3)^2 - x(4))^2 + ...
    10.1*((x(2) - 1)^2 + (x(4) - 1)^2)  + 19.8*(x(2) - 1)*(x(4) - 1);
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1);
end
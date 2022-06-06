function y = Leon(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Leon.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_L.html
%
% Globally optimal solution:
%   f = 0
%   x = [1, 1]
%
% Default variable bounds:
%   -1.2 <= x(1) <= 1.2
%   -1.2 <= x(2) <= 1.2
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
    y.xl = @(i) -1.2;
    y.xu = @(i) 1.2;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = 100*(x(2) - x(1)^3)^2 + (1 - x(1))^2;
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [1; 1];
end 
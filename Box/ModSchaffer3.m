function y = ModSchaffer3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   ModSchaffer3.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_M.html
%
% Globally optimal solution:
%   f = 0.001566854526004080
%   x = [0, 1.253114961359037]
%
% Default variable bounds:
%   -100 <= x(1) <= 100
%   -100 <= x(2) <= 100
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
    y.xl = @(i) -100;
    y.xu = @(i) 100;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = 0.5  + (sin(cos(abs(x(1)^2 - x(2)^2)))^2 - 0.5)/(1 + 0.001*(x(1)^2 + x(2)^2))^2;
end 

function fmin = get_fmin(~)
    fmin = 0.001566854526004080;
end

function xmin = get_xmin(~)
    xmin = [0; 1.253114961359037];
end
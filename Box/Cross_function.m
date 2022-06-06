function y = Cross_function(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Cross_function.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_C.html
%
% Globally optimal solution:
%   f = 0.0000484822
%   x = [-1.34940661020092; -1.34940659873690];
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
y = (abs(sin(x(1)).*sin(x(2)).*exp(abs(100 - sqrt(x(1)^2 + x(2)^2)/pi))) + 1).^(-0.1);
end  

function fmin = get_fmin(~)
    fmin = 0.0000484822;
end

function xmin = get_xmin(~)
    xmin = [-1.34940661020092; -1.34940659873690];
end
function y = Chichinadze(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Chichinadze.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_C.html
%
% Globally optimal solution:
%   f = -42.94438701899098
%   x = [6.189866586965680, 0.5]
%
% Default variable bounds:
%   -30 <= x(1) <= 30
%   -30 <= x(2) <= 30
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
    y.xl = @(i) -30;
    y.xu = @(i) 30;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = x(1)^2 - 12*x(1) + 11 + 10*cos(pi*x(1)/2) + 8*sin(5*pi*x(1)/2) - ...
    1/sqrt(5)*exp(-((x(2) - 0.5)^2)/2);
end

function fmin = get_fmin(~)
    fmin = -42.94438701899098;
end

function xmin = get_xmin(~)
    xmin = [6.189866586965680; 0.5];
end
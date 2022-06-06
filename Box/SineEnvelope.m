function y = SineEnvelope(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   SineEnvelope.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_S.html
%
% Globally optimal solution:
%   f = -2.6535768335*(n-1);
%   x = 0, i = 1...n
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1...n
%
% Problem Properties:
%   n  = any;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
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
y = 0;
for i = 1:length(x) - 1
   y = y + (((sin((x(i)^2 + x(i + 1)^2)^0.5) - 0.5)^2)/((0.001*(x(i)^2 ...
       + x(i + 1)^2) + 1)^2)) + 0.5;
end
y = -y;
end 

function fmin = get_fmin(nx)
    fmin = -2.6535768335*(nx - 1);
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
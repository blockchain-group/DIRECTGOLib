function y = Sinenvsin(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Sinenvsin.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_S.html
%
% Globally optimal solution:
%   f = 0
%   x = [0, 0]
%
% Default variable bounds:
%   -100 <= x(1) <= 150
%   -100 <= x(2) <= 150
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -100;
    y.xu = @(i) 150;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
X1 = x(1:end-1, :);        
X2 = x(2:end, :);
XY = X1.^2 + X2.^2;
y = sum((sin(sqrt(XY)).^2 - 0.5)./(1 + 0.001*XY).^2 + 0.5, 1);
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
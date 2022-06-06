function y = HelicalValley(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   HelicalValley.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_H.html
%
% Globally optimal solution:
%   f = 0
%   x = [1, 0, 0]
%
% Default variable bounds:
%   -10 <= x(1) <= 20
%   -10 <= x(2) <= 20
%
% Problem Properties:
%   n  = 3;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -10;
    y.xu = @(i) 20;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = 100*((x(3) - 10*atan2(x(2), x(1))/2/pi).^2 +...
    (sqrt(x(1)^2 + x(2)^2) - 1)^2) + x(3)^2;
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [1; 0; 0];
end
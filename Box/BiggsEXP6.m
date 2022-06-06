function y = BiggsEXP6(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   BiggsEXP6.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = 0
%   x = [16.8708767020385, 3.74419145642598, 3.13065356800511,...
%        18.7441902620048, 14.3685848324821, 6.88004686839129]
%
% Default variable bounds:
%   0 <= x(i) <= 20, i = 1...n
%   
% Problem Properties:
%   n  = 6;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) 0;
    y.xu = @(i) 20;
    y.fmin = @(i) 0;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
t = 0.1;
g = exp(-t) - 5*exp(10*t) + 3*exp(-4*t);
y = (x(3)*exp(-t*x(1)) - x(4)*exp(-t*x(2)) + x(6)*exp(-t*x(5)) - g)^2;
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [16.8708767020385; 3.74419145642598; 3.13065356800511;...
            18.7441902620048; 14.3685848324821; 6.88004686839129];
end
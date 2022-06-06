function y = AckleyN3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   AckleyN3.m
%
% Original source:
%  - Jamil, Momin, and Xin-She Yang. "A literature survey of benchmark 
%    functions for global optimization problems." International Journal of 
%    Mathematical Modelling and Numerical Optimization 4.2 (2013): 150-194.
%
% Globally optimal solution:
%   f = -186.411212711269
%   x = [0; -0.00677345076110214]
%
% Default variable bounds:
%   -15 <= x(i) <= 30, i = 1...n
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
    y.xl = @(i) -15; 
    y.xu = @(i) 30;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = -200*exp(-0.2*(x(1)^2 + x(2)^2)^0.5) + 5*exp(cos(3*x(1)) + sin(3*x(2)));
end

function fmin = get_fmin(~)
    fmin = -186.411212711269;
end

function xmin = get_xmin(~)
    xmin = [0; -0.00677345076110214];
end
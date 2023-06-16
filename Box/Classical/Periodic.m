function y = Periodic(x, shift)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Periodic.m
%
% References:
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = 0.9;
%   x = [0; 0]
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 1, 0, 1, 0, 0, 1, 0];
    y.libraries = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
    return
end   
if size(x, 2) > size(x, 1), x = x'; end
if nargin == 2, x = shifted_x(x, shift); end

y = 1 + sin(x(1))^2 + sin(x(2))^2 - 0.1*exp(-(x(1)^2 + x(2)^2));
end

function x = shifted_x(x, shift)
    if size(shift, 2) > size(shift, 1), shift = shift'; end
    nx = length(x); 
    x = x - ((get_xu(nx) - get_xl(nx)).*shift + get_xl(nx) - get_xmin(nx));
end

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0.9;
end

function xmin = get_xmin(~)
    xmin = [0; 0];
end
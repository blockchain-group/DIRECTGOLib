function y = Rump(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Rump.m
%
% References:
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -2474753687571289088
%   x = [-500.00000000099993258118; -184.65960304405464853517]
%
% Default variable bounds:
%   -500.000000001 <= x(i) <= 500, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [0, 0, 0, 1, 0, 1, 0, 0];
    y.libraries = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = (333.75 - x(1)^2)*x(2)^6 + (x(1)^2)*(11*x(1)^2*x(2)^2 - 121*x(2)^4 - 2) ...
    + 5.5*x(2)^8 + x(1)/(2*x(2));

y = min([y, 10^2]);
end

function xl = get_xl(nx)
    xl = -500.000000001*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 500*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -2474753687571289088;
end

function xmin = get_xmin(~)
    xmin = [-500.00000000099993258118; -184.65960304405464853517];
end
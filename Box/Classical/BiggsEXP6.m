function y = BiggsEXP6(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   BiggsEXP6.m
%
% References:				
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = 0
%   x = [1; 10; 1; 5; 4; 3]
%
% Default variable bounds:
%   -20 <= x(i) <= 20, i = 1,...,n
%   
% Problem Properties:
%   n  = 6;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

t = (0.1:0.1:0.9);
y = sum((x(3)*exp(-t*x(1)) - x(4)*exp(-t*x(2)) + x(6)*exp(-t*x(5)) - ...
    exp(-t) + 5*exp(-t*10) - 3*exp(-t*4)).^2);
end

function xl = get_xl(nx)
    xl = -20*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 20*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [1; 10; 1; 5; 4; 3];
end
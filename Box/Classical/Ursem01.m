function y = Ursem01(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Ursem01.m
%
% References:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -4.81681406373482268179
%   x = [1.69713644976716171442; 0.00000000573594372000]
%
% Default variable bounds:
%   -2 <= x(1) <= 3
%   -2 <= x(2) <= 2
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
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end 
if size(x, 2) > size(x, 1), x = x'; end

y = -sin(2*x(1) - 0.5*pi) - 3*cos(x(2)) - 0.5*x(1);
end

function xl = get_xl(~)
    xl = [-2.5; -2];
end

function xu = get_xu(~)
    xu = [3; 2];
end

function fmin = get_fmin(~)
    fmin = -4.81681406373482268179;
end

function xmin = get_xmin(~)
    xmin = [1.69713644976716171442; 0.00000000573594372000];
end
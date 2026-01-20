function y = Trigonometric02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Trigonometric02.m
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
%   f = 1
%   x(i) = 0.9, i = 1,...,n
%
% Default variable bounds:
%   -500 <= x(i) <= 500, i = 1,...,n
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 1, 1, 1, 0, 0, 0, 1];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 1 + sum(8*sin(7*(x - 0.9).^2).^2 + 6*sin(14*(x - 0.9).^2).^2 + (x - 0.9).^2);
end  

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = pi*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 1;
end

function xmin = get_xmin(nx)
    xmin = 0.9*ones(nx, 1);
end
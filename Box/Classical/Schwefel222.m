function y = Schwefel222(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Schwefel222.m
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
%   f = 0
%   x(i) = 0, i = 1,...,n
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1,...,n
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, non-Separable, Scalable, Uni-modal,
%   Non-Convex, Non-plateau, Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 0, 0, 0, 1, 1];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum(abs(x)) + prod(abs(x));
end  

function xl = get_xl(nx)
    xl = -100*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
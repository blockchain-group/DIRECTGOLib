function y = Mishra02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Mishra02.m
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
%   f = 2
%   x(i) = 1, i = 1,...,n
%
% Default variable bounds:
%   -1 <= x(i) <= 1, i = 1,...,n
%
% Problem Properties:
%   n  = "n >= 2";
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Uni-modal,
%   Convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 0, 1, 0, 0, 1];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

aa = 0;
for i = 1:length(x)-1
    aa = aa + (x(i) + x(i+1))/2;
end
D = length(x) - aa;
y = (1+D)^D;
end

function xl = get_xl(nx)
    xl = -ones(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 2;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1);
end 
function y = Weierstrass(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Weierstrass.m
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
%   x(i) = 0.5, i = 1,...,n
%
% Default variable bounds:
%   -0.5 <= x(i) <= 0.5, i = 1,...,n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 1, 1, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

sum1 = -length(x)*sum((0.5.^(0:20)).*cos(pi*(3.^(0:20))));
sum2 = @(ii) -length(x)*sum((0.5.^(0:20)).*cos((x(ii) + 0.5)*2*pi*(3.^(0:20))));
y = 0;
for i = 1:length(x)
    y = y + sum2(i) + sum1;
end
end

function xl = get_xl(nx)
    xl = -0.5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 0.5*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*0.5;
end
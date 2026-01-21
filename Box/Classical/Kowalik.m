function y = Kowalik(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Kowalik.m
%
% References:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = 0.0003074859878056057
%   x = [0.192833452473070; 0.190836245640428; 0.123117296594577; 0.135765993237678]
%
% Default variable bounds:
%   -5 <= x(i) <= 5, i = 1,...,n
%
% Problem Properties:
%   n  = 4;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

b = [4, 2, 1, 1/2, 1/4, 1/6, 1/8, 1/10, 1/12, 1/14, 1/16];
a = [0.1957, 0.1947, 0.1735, 0.1600, 0.0844, 0.0627, 0.0456, 0.0342, 0.0323, 0.0235, 0.0246];
y = 0;
for i = 1:11
    y = y + (a(i) - (x(1)*(b(i)^2+b(i)*x(2)))/(b(i)^2+b(i)*x(3)+x(4)))^2;
end
end

function xl = get_xl(nx)
    xl = -5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0.0003074859878056057;
end

function xmin = get_xmin(~)
    xmin = [0.192833452473070; 0.190836245640428; 0.123117296594577; 0.135765993237678];
end
function y = Problem04(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Problem04.m
%
% References:	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = -3.85045070880022111126
%   x = 2.86803398997230996059
%
% Default variable bounds:
%   -1.9 <= x(i) <= 3.9, i = 1,...,n
%
% Problem Properties:
%   n  = 1;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Non-scalable, Uni-modal,
%   Convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 1;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 1, 0, 0, 1, 0, 0, 1];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -(16*x^2 - 24*x + 5)*exp(-x);
end

function xl = get_xl(nx)
    xl = 1.9*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 3.9*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -3.85045070880022111126;
end

function xmin = get_xmin(~)
    xmin = 2.86803398997230996059;
end
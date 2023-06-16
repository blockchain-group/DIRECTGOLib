function y = Problem02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Problem02.m
%
% References:	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = -1.89959934915211370310
%   x = 5.14573528692457671241
%
% Default variable bounds:
%   2.7 <= x <= 7.5
%
% Problem Properties:
%   n  = 1;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 1;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 1, 0, 1, 0, 0, 0, 1];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sin(x) + sin((10/3)*x);
end

function xl = get_xl(nx)
    xl = 2.7*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 7.5*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -1.89959934915211370310;
end

function xmin = get_xmin(~)
    xmin = 5.14573529272000484980;
end
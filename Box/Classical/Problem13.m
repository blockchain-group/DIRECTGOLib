function y = Problem13(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Problem13.m
%
% References:	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = -1.58740105196819958344
%   x = 0.70710678050342734569
%
% Default variable bounds:
%   0.007 <= x <= 0.99
%
% Problem Properties:
%   n  = 1;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Non-scalable, Uin-modal,
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

y = -x^(2/3) - (1 - x^2)^(1/3);
end

function xl = get_xl(nx)
    xl = 0.007*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 0.99*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -1.58740105196819958344;
end

function xmin = get_xmin(~)
    xmin = 0.70710678050342734569;
end
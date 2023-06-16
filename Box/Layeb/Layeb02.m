function y = Layeb02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb02.m
%
% References:
%  - A. Layeb.  (2022): New hard benchmark functions for global optimization. 
%    doi:10.48550/ARXIV.2202.04606. URL: https://arxiv.org/abs/2202.04606
%
% Globally optimal solution:
%   f = 0
%   x(i) = 1, i = 1,...,n
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Separable, Scalable, Multi-modal,
%   Non-convex, Plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
   y.nx = 0;
   y.ng = 0;
   y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
   y.fmin = @(nx) get_fmin(nx);
   y.xmin = @(nx) get_xmin(nx);
   y.features = [0, 1, 1, 0, 0, 1, 0, 1];
   y.libraries = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
   return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum(abs(exp(100*((x - 1).^2)./(exp(x) + 1)) - 1)); 
end 

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1);
end
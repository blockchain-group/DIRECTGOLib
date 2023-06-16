function y = AckleyN4(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   AckleyN4.m
%
% References:				
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -4.59010163415866756509 
%   x = [-1.50962010564600035423; -0.75486511728330185633]
%
% Default variable bounds:
%   -35 <= x(i) <= 35, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum(exp(-0.2)*sqrt(x(1:end - 1).^2 + x(2:end).^2) + ...
    3*(cos(2*x(1:end - 1)) + sin(2*x(2:end))));
end

function xl = get_xl(nx)
    xl = -35*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 35*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -4.59010163415866756509;
end

function xmin = get_xmin(~)
    xmin = [-1.50962010564600035423; -0.75486511728330185633];
end
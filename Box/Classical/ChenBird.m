function y = ChenBird(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   ChenBird.m
%
% References:				
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -2000.00000000000022737368
%   x = [0.38888888888720885006; 0.72222222222796972346]
%
% Default variable bounds:
%   -500 <= x(i) <= 500, i = 1,...,n
%   
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
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
    y.features = [1, 0, 0, 1, 0, 0, 0. 0];
    y.libraries = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -(0.001/(0.001^2 + (x(1) - 0.4* x(2) - 0.1)^2)) -...
    (0.001/(0.001^2 + (2*x(1) + x(2) - 1.5)^2));
end  

function xl = get_xl(nx)
    xl = -500*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 500*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -2000.00000000000022737368;
end

function xmin = get_xmin(~)
    xmin = [0.38888888888720885006; 0.72222222222796972346];
end
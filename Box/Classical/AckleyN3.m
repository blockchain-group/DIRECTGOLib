function y = AckleyN3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   AckleyN3.m
%
% References:				
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -195.62902826227937680414
%   x = [0.68257717405194995308; -0.36070185844338453762]
%
% Default variable bounds:
%   -32 <= x(i) <= 32, i = 1,...,n
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
    y.features = [1, 0, 0, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -200*exp(-0.02*sqrt(x(1)^2 + x(2)^2)) + 5*exp(cos(3*x(1)) + sin(3*x(2)));
end

function xl = get_xl(nx)
    xl = -32*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 32*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -195.62902826227937680414;
end

function xmin = get_xmin(~)
    xmin = [0.68257717405194995308; -0.36070185844338453762];
end
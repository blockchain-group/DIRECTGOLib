function y = RosenbrockModified(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   RosenbrockModified.m
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
%   f = 34.04024310664050290143
%   x = [-0.90955373727804644801; -0.95057171287770314549]
%
% Default variable bounds:
%   -2 <= x(i) <= 2, i = 1,...,n
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
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 74 + 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2 - ...
    400*exp(-((x(1) + 1)^2 + (x(2) + 1)^2)/0.1);
end 

function xl = get_xl(nx)
    xl = -2*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 2*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 34.04024310664050290143;
end

function xmin = get_xmin(~)
    xmin = [-0.90955373727804644801; -0.95057171287770314549];
end
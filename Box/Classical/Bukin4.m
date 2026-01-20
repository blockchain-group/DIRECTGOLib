function y = Bukin4(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bukin4.m
%
% References:				
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%  - Rody Oldenhuis (2020): Test functions for global optimization algorithms
%    URL: https://github.com/rodyo/FEX-testfunctions/releases/tag/v1.5
%
% Globally optimal solution:
%   f = 0
%   x = [-10; 0]
%
% Default variable bounds:
%   -15 <= x(1) <= -5
%   -3  <= x(2) <= 3
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Separable, Non-scalable, Uni-modal,
%   Non-convex, Non-plateau, Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [0, 1, 0, 0, 0, 0, 1, 0];
    y.libraries = [0, 0, 0, 1, 1, 0, 1, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 100*x(2)^2 + 0.01*abs(x(1) + 10);
end

function xl = get_xl(~)
    xl = [-15; -3];
end

function xu = get_xu(~)
    xu = [-5; 3];
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [-10; 0];
end
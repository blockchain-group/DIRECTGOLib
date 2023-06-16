function y = Branin02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Branin02.m
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
%   f = 5.55891440389381585874
%   x = [-3.19698842472849120711; 12.52625788524676586633]
%
% Default variable bounds:
%   -5 <= x(1) <= 10;
%    0 <= x(2) <= 15;
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

a = 1; b = 5.1/(4*pi^2); c = 5/pi; d = 6; e = 10; g = 1/(8*pi);
f1 = a*(x(2) - b*x(1).^2 + c*x(1) - d)^2;
f2 = e*(1 - g)*cos(x(1))*cos(x(2));
f3 = log(x(1).^2 + x(2).^2 + 1);
y = (f1 + f2 + f3 + e);
end

function xl = get_xl(~)
    xl = [-5; 0];
end

function xu = get_xu(~)
    xu = [10; 15];
end

function fmin = get_fmin(~)
    fmin = 5.55891440389381585874;
end

function xmin = get_xmin(~)
    xmin = [-3.19698842472849120711; 12.52625788524676586633];
end
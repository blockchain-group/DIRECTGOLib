function y = BoxBetts(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   BoxBetts.m
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
%   f = 0
%   x = [1; 10; 1]
%
% Default variable bounds:
%   0.9 <= x(1) <= 1.2
%   9 <= x(2) <= 11.2
%   0.9 <= x(3) <= 1.2
%
% Problem Properties:
%   n  = 3;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
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

y = 0;
for i = 1:10
y = y + (exp(-0.1*(i + 1))*x(1) - exp(-0.1*(i + 1))*x(2) - ...
    (exp(-0.1*(i + 1)) - exp(-0.1*(i + 1))*x(2)))^2;
end
end

function xl = get_xl(~)
    xl = [0.9; 9; 0.9];
end

function xu = get_xu(~)
    xu = [1.2; 11.2; 1.2];
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [1; 10; 1];
end
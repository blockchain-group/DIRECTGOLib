function y = Schaffer3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Schaffer3.m
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
%   f = 0.00156685452600402453
%   x = [-1.25311496480281903132; 0]
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 1, 1];
    y.libraries = [0, 0, 0, 1, 1, 0, 1, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

x1 = x(1);
x2 = x(2);

fact1 = (sin(cos(abs(x1^2-x2^2))))^2 - 0.5;
fact2 = (1 + 0.001*(x1^2+x2^2))^2;

y = 0.5 + fact1/fact2;
end  

function xl = get_xl(nx)
    xl = -100*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0.00156685452600402453;
end

function xmin = get_xmin(~)
    xmin = [-1.25311496480281903132; 0];
end
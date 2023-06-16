function y = SchmidtVetters(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   SchmidtVetters.m
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
%   f = 0.19397252244022777923
%   x = [7.07082456787074242754; 9.99999999999997868372; 3.14159267452663470976]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%
% Problem Properties:
%   n  = 3;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [0, 0, 0, 1, 0, 1, 0, 0];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end


y = 1/(1 + (x(1) - x(2))^2) + sin((pi*x(2) + x(3))/2) + exp(((x(1) + x(2))/(x(2) + 1e-10) - 2)^2);
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0.19397252244022777923;
end

function xmin = get_xmin(~)
    xmin = [7.07082456787074242754; 9.99999999999997868372; 3.14159267452663470976];
end
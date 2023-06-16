function y = Pinter(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Pinter.m
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
%   x(i) = 0, i = 1,...,n
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...n
%
% Problem Properties:
%   n  = "n >= 2";
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 1, 0, 0, 1, 0];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

n = length(x);
sum1 = 0;
sum2 = 0;
sum3 = 0;
for ii = 1:n
    if ii == 1 
        aa = x(n);
        bb = x(ii + 1);
    elseif ii == n 
        aa = x(ii-1);
        bb = x(1);
    else
        aa = x(ii-1);
        bb = x(ii + 1);
    end
    A = aa*sin(x(ii)) + sin(bb);
    B = aa^2 - 2*x(ii) + 3*bb - cos(x(ii)) + 1;
	sum1 = sum1 + ii*x(ii)^2;
	sum2 = sum2 + 20*ii*(sin(A))^2;
    sum3 = sum3 + ii*log10(1+ii*B^2);
end
y = sum1 + sum2 + sum3;
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
    xmin = zeros(nx, 1);
end
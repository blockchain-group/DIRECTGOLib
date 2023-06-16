function y = Trid(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Trid.m
%
% References:				
%  - Hedar, A. (2005): Test functions for unconstrained global optimization. 
%    URL: http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO.htm																				
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -n*(n + 4)*(n - 1)/6
%   x(i) = [i*(n + 1 - i)], i = 1,...,n
%
% Default variable bounds:
%   0 <= x(i) <= round(n/2)*(n + 1- round(n/2))                             
% Problem Properties:
%   n  = 0;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Uni-modal,
%   Convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 0, 1, 0, 0, 1];
    y.libraries = [1, 1, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum((x - 1).^2) - sum(x(2:end).*x(1:end - 1));
end

function xl = get_xl(nx)
    xl = -100*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = (round(nx/2)*(nx + 1- round(nx/2)))*ones(nx, 1);
end

function fmin = get_fmin(nx)
[~, fmin] = solve_trid(nx);
end

function xmin = get_xmin(nx)
[xmin, ~] = solve_trid(nx);
end

function [xmin,fmin] = solve_trid(nx)
A = zeros(nx, nx);
A(1, 1) = 2;
A(1, 2) = -1;
for i = 2:nx - 1
    A(i, i - 1) = -1;
    A(i, i) = 2;
    A(i, i + 1) = -1;
end
A(nx, nx - 1) = -1;
A(nx, nx) = 2;
b = 2*ones(nx, 1);
xmin = A \ b;
fmin = get_y(xmin);
end

function y = get_y(x)
n = length(x);
s1 = 0;
s2 = 0;
for j = 1:n
    s1 = s1 + (x(j) - 1)^2;
end
for j = 2:n
    s2 = s2 + x(j)*x(j - 1);
end
y = s1 - s2;
end
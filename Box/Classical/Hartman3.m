function y = Hartman3(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hartman3.m
%
% References:																							
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
%   f = -3.86278214782075579592
%   x = [0.11461434265927536447; 0.55564885010168318935; 0.85254695343372122185]
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,...,n
%   
% Problem Properties:
%   n  = 3;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% ------------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 0, 0];
    y.libraries = [0, 1, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

a(:, 2) = 10.0*ones(4, 1);
for j=1:2
    a(2*j - 1, 1) = 3.0;
    a(2*j, 1) = 0.1; 
    a(2*j - 1, 3) = 30.0; 
    a(2*j, 3) = 35.0;
end
c(1) = 1.0; 
c(2) = 1.2; 
c(3) = 3.0; 
c(4) = 3.2;
p(1, 1) = 0.36890; 
p(1, 2) = 0.11700; 
p(1, 3) = 0.26730;
p(2, 1) = 0.46990; 
p(2, 2) = 0.43870; 
p(2, 3) = 0.74700;
p(3, 1) = 0.10910; 
p(3, 2) = 0.87320; 
p(3, 3) = 0.55470;
p(4, 1) = 0.03815; 
p(4, 2) = 0.57430; 
p(4, 3) = 0.88280;
s = 0;
for i = 1:4
    sm = 0;
    for j = 1:3
        sm = sm + a(i, j)*(x(j) - p(i, j))^2;
    end
    s = s + c(i)*exp(-sm);
end
y = -s;
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -3.86278214782075579592;
end

function xmin = get_xmin(~)
    xmin = [0.11461434265927536447; 0.55564885010168318935; 0.85254695343372122185];
end
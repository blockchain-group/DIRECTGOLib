function y = Langermann5(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Langermann5.m
%
% References:
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -2.42311955301315995470
%   x = [8.04682028360667622735; 8.98500814093004329663]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
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
    y.features = [1, 0, 1, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

m = 5;
c = [0.806; 0.517; 1.5; 0.908; 0.965];

A = [9.681,0.667,4.783,9.095,3.517,9.325,6.544,0.211,5.122,2.020;...
     9.400,2.041,3.788,7.931,2.882,2.672,3.568,1.284,7.033,7.374;...
     8.025,9.152,5.114,7.621,4.564,4.711,2.996,6.126,0.734,4.982;...
     2.196,0.415,5.649,6.979,9.510,9.166,6.304,6.054,9.377,1.426;...
     8.074,8.777,3.467,1.863,6.708,6.349,4.534,0.276,7.633,1.567];

y = 0;
for i = 1:m
    inner = sum((x - A(i, 1:length(x))').^2);
    y = y + (c(i)*exp(-inner/pi)*cos(pi*inner));
end
y = - y;
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -2.42311955301315995470;
end

function xmin = get_xmin(~)
    xmin = [8.04682028360667622735; 8.98500814093004329663];
end
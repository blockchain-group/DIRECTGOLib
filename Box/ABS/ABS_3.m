function y = ABS_3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Jakub Kudela
% Name:
%   ABS_3.m
%
% References:
%  - Kudela, J., Matousek, R. (2022): New Benchmark Functions for 
%    Single-Objective Optimization Based on a Zigzag Pattern, 
%    IEEE Access, Vol. 10, pp. 8262-8278.
%    URL: https://doi.org/10.1109/ACCESS.2022.3144067
%
% Globally optimal solution:
%   f = 0
%   x(i) = 0, i = 1,...,n
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1,...,n
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [0, 1, 1, 1, 0, 0, 1, 1];
    y.libraries = [0, 0, 0, 0, 0, 0, 0, 1, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

m = 0.5000; k = 2; lmbd = 0.99;

f = @(x) 10.*abs(sin(0.1*x))+ 3*10^(-9)*zigzag(x,k,m,lmbd).*abs((x-40).*(x-185).*x.*(x+50).*(x+180) );
y = sum(f(f(x)),1);

end

function [valz] = zigzag(xs,k,m,lmbd)
    xs = abs(xs); 
    xs = xs/k - floor(xs/k);
    ids = xs<=lmbd;
    valz = 1-m+ids*m.*(xs/lmbd) + (1-ids).*m.*(1-(xs-lmbd)/((1-lmbd)));
end

function xl = get_xl(nx)
    xl = -100*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
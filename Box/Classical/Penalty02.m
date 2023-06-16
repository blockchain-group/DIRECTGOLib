function y = Penalty02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Penalty02.m
%
% References:	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = 0
%   x(i) = 1, i = 1,...,n
%
% Default variable bounds:
%   -50 <= x(i) <= 50, i = 1,...,n
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end   
if size(x, 2) > size(x, 1), x = x'; end

a = 5; k = 100; m = 4;
u = zeros(length(x), 1);
for i = 1:length(x)
    if x(i) > a
        u(i) = k*(x(i) - a)^m;
    elseif x(i) <= a && x(i) >= -a
        u(i) = 0;
    elseif x(i) < -a
        u(i) = k*(-x(i) - a)^m;
    end
end

y = 0.1*(sin(3*pi*x(1))^2 + sum(((x(1:end - 1) - ...
    1).^2).*(1 + sin(3*pi*x(2:end)).^2)) + ((x(end) - 1)^2)*(1 + sin(2*pi*x(end))^2)) + sum(u);
end

function xl = get_xl(nx)
    xl = -50*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 50*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1);
end
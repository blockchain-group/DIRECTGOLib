function y = Deceptive(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Deceptive.m
%
% References:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = -1
%   x(i) = 1, i = 1,...,n
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,...,n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [0, 0, 1, 1, 0, 0, 0, 1];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

b = 2;
a = 1;
y = 0;
x = min([x, ones(length(x), 1)],[],2);
x = max([x, zeros(length(x), 1)],[],2);
for i = 1:length(x)

    if x(i) >= 0 && x(i) <= 4/5*a
        g = -x(i)/a + 4/5;
    elseif x(i) > 4/5*a && x(i) <= a
        g = (5*x(i))/a - 4;
    elseif x(i) > a && x(i) <= (1+4*a)/5
        g = (5*(x(i)-a))/(a-1) + 1;
    elseif x(i) > (1+4*a)/5 && x(i) <= 1
        g = (x(i)-1)/(1-a) + 4/5;
    end
   y = y + g;
end
y = -((y/length(x))^b);
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1);
end
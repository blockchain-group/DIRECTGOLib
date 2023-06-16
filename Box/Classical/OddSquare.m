function y = OddSquare(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   OddSquare.m
%
% References:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = -1.19595108868180899364
%   x = [-9.99992977193720911089; -15.70796243427961158545]
%
% Default variable bounds:
%   -5*pi <= x(i) <= 5*pi, i = 1,...,n
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
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

b = [1, 1.3, 0.8, -0.4, -1.3, 1.6, -0.2, -0.6, 0.5, 1.4, 1, 1.3, 0.8, -0.4, -1.3, 1.6, -0.2, -0.6, 0.5, 1.4]';
d = length(x)*max(x - b(1:length(x)));
h = sqrt(sum((x - b(1:length(x))).^2));
y = -exp(-cos(d)/(2*pi))*cos(pi*d)*(1+((0.02*h)/(h+0.01)));
end 

function xl = get_xl(nx)
    xl = -5*pi*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*pi*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -1.19595108868180899364;
end

function xmin = get_xmin(~)
    xmin = [-9.99992977193720911089; -15.70796243427961158545];
end 
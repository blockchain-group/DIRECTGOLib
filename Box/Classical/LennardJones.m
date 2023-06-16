function y = LennardJones(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   LennardJones.m
%
% References:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = -0.2500000000
%   x = [-2.39598760111285e-09; -30.2798951284995; -4.44796936214180e-09;
%        -29.1574330804699; -2.39598760111285e-09; 1.29339744922682e-16]
%
% Default variable bounds:
%   -4 <= x(i) <= 4, i = 1,...,n
%
% Problem Properties:
%   n  = 6;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 1, 0];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

k = 1;
y = 0;
for i = 0:k
    z = max([3*i, 1]);
    for j = i+1:k
        v = max([3*j, 1]);
        r = sqrt((x(z)-x(v))^2+(x(z+1)-x(v+1))^2+(x(z+2)-x(v+2))^2);
        if r < 1e-6, r = 1e+30; end
        y = y + (1/(r^12) - 1/(r^6));
    end
end
end

function xl = get_xl(nx)
    xl = -100*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -0.2500000000;
end

function xmin = get_xmin(~)
    xmin = [-2.39598760111285e-09;-30.2798951284995;-4.44796936214180e-09;...
        -29.1574330804699;-2.39598760111285e-09;1.29339744922682e-16];
end
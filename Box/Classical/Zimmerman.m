function y = Zimmerman(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Zimmerman.m
%
% References:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = 0
%   x = [7; 2]
%
% Default variable bounds:
%   0 <= x(i) <= 100, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Separable, Non-scalable, Multi-modal,
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
    y.features = [0, 1, 0, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = max([9 - x(1) - x(2), (100*(1 + (x(1) - 3)^2 + (x(2) - 2)^2 - 16))*sign((x(1) - 3)^2 + (x(2) - 2)^2 - 16),...
    (100*(1 + x(1)*x(2) - 14))*sign(x(1)*x(2) - 14), (100*(1 - x(1)))*sign(x(1)), (100*(1 - x(2)))*sign(x(2))]);
end 

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [7; 2];
end
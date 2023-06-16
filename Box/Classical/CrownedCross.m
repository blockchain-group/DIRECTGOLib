function y = CrownedCross(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   CrownedCross.m
%
% References:				
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%  - Rody Oldenhuis (2020): Test functions for global optimization algorithms
%    URL: https://github.com/rodyo/FEX-testfunctions/releases/tag/v1.5
%
% Globally optimal solution:
%   f = 0.0001
%   x = [0; 0]
%
% Default variable bounds:
%   -10 <= x(i) <= 15, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [0, 0, 0, 1, 0, 0, 1, 1];
    y.libraries = [0, 0, 0, 1, 0, 0, 1, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 0.0001*(abs(sin(x(1)).*sin(x(2)).*exp(abs(100 -...
    sqrt(x(1)^2 + x(2)^2)/pi))) + 1).^(0.1);
end  

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 15*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0.0001;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
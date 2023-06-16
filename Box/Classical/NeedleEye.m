function y = NeedleEye(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   NeedleEye.m
%
% References:	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = 0
%   x = depends on the dimension
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1,...,n
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Plateau, Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [0, 0, 1, 1, 0, 1, 1, 1];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

if norm(x) < (1e-4 - 1e-6)
    y = 1;
elseif norm(x) > (1e-4 + 1e-6)
    y = sum(abs(x) + 100);
else
    y = 0;
end
end 

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    persistent xxx dim
    if isempty(xxx) || dim ~= nx
        dim = nx;
        xxx = ones(nx, 1)*0.0001;
        xx = norm(xxx);
        while xx >= (1e-4 - 1e-7)
            xxx = xxx./(1.000001);
            xx = norm(xxx);
        end
    end
    xmin = xxx;
end
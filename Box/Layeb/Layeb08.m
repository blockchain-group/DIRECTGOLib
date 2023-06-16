function y = Layeb08(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb08.m
%
% References:
%  - A. Layeb.  (2022): New hard benchmark functions for global optimization. 
%    doi:10.48550/ARXIV.2202.04606. URL: https://arxiv.org/abs/2202.04606
%
% Globally optimal solution:
%   f = log(0.001)*(n - 1)
%   x = is alternation of pi/4 and -pi/4
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = "n >= 2";
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
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
    y.features = [1, 0, 1, 1, 0, 0, 0, 1];
    y.libraries = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

cos_rad = @(theta) cosd(theta/pi*180);
y = 0;
dim = length(x);
for i = 1:dim - 1
    y = y + abs(100*cos_rad((x(i) - x(i + 1)))) + log(abs(x(i) +...
        x(i + 1)) + 0.001);
end
end 

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(nx)
    fmin = log(0.001)*(nx - 1);
end

function xmin = get_xmin(nx)
    xmin = (pi/4)*ones(nx, 1);
    for i = 1:nx
        if mod(i, 2) == 0
            xmin(i) = -(pi/4);
        end
    end
end
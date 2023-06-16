function y = Layeb14(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb14.m
%
% References:
%  - A. Layeb.  (2022): New hard benchmark functions for global optimization. 
%    doi:10.48550/ARXIV.2202.04606. URL: https://arxiv.org/abs/2202.04606
%
% Globally optimal solution:
%   f = 0
%   x = is alternation of 0 and -1
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1,...,n
%   
% Problem Properties:
%   n  = "n >= 2";
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
 if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 1, 0, 0, 1, 0];
    y.libraries = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
    return
 end
if size(x, 2) > size(x, 1), x = x'; end

y = 0;
dim = length(x);
for i = 1:dim - 1
    y = y + abs(log((x(i) + x(i + 1) + 2)^2)) +...
        100*abs((x(i)^2 - x(i + 1) - 1))^0.1;
end
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
    for i = 1:nx
        if mod(i, 2) == 0
            xmin(i) = -1;
        end
    end
end 
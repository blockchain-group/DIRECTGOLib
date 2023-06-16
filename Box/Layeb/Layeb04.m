function y = Layeb04(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb04.m
%
% References:
%  - A. Layeb.  (2022): New hard benchmark functions for global optimization. 
%    doi:10.48550/ARXIV.2202.04606. URL: https://arxiv.org/abs/2202.04606
%
% Globally optimal solution:
%   f = (log(0.001) - 1)*(n - 1)
%   x(i) = is alternation of 0 and (2i - 1)pi, i is an integer
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
    y.features = [1, 0, 1, 1, 0, 0, 1, 1];
    y.libraries = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

cos_rad = @(theta) cosd(theta/pi*180) ;
dim = length(x);
y = 0;
for i = 1:dim - 1
    y = y + log(abs(x(i + 1).*x(i)) + 0.001) + cos_rad(x(i + 1) + x(i)); 
end
end 

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(nx)
    fmin = (log(0.001) - 1)*(nx - 1);
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
    for i = 1:nx
        if mod(i, 2) == 0
            xmin(i) = pi;
        end
    end
end 
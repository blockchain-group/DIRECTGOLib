function y = Layeb12(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb12.m
%
% References:
%  - A. Layeb.  (2022): New hard benchmark functions for global optimization. 
%    doi:10.48550/ARXIV.2202.04606. URL: https://arxiv.org/abs/2202.04606
%
% Globally optimal solution:
%   f = -(exp(1) + 1)*(n - 1)
%   x(i) = 2, i = 1,...,n
%
% Default variable bounds:
%   -5 <= x(i) <= 5, i = 1,...,n
%   
% Problem Properties:
%   n  = "n >= 2";
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
    y.libraries = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

cos_rad = @(theta) cosd(theta/pi*180) ;
y = 0;
dim=length(x);
for i = 1:dim - 1
    y = y - ((cos_rad((x(i)*pi/2 - x(i + 1)*pi/4 - pi/2))*...
        exp(cos_rad(2*pi*x(i + 1)*x(i)))) + 1);
end
end 

function xl = get_xl(nx)
    xl = -5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function fmin = get_fmin(nx)
    fmin = -(exp(1) + 1)*(nx - 1);
end

function xmin = get_xmin(nx)
    xmin = 2*ones(nx, 1);
end
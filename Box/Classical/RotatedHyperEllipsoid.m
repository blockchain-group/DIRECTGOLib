function y = RotatedHyperEllipsoid(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Rotated_H_Ellip.m
%
% References:																							
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%
% Globally optimal solution:
%   f = 0
%   x(i) = 0, i = 1,...,n
%
% Default variable bounds:
%   -65.536 <= x(i) <= 65.536, i = 1,...,n
%    
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Uni-modal,
%   Convex, Non-plateau, Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 0, 1, 0, 1, 0];
    y.libraries = [0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 0;
for i = 1:length(x)
    y = y + sum(x(1:i).^2);
end
end

function xl = get_xl(nx)
    xl = -65.536*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 65.536*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
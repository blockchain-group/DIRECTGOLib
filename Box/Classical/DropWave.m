function y = DropWave(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   DropWave.m
%
% References:																				
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = -1
%   x = [0; 0]
% 
% Default variable bounds:
%   -5.12 <= x(i) <= 5.12, i = 1,...,n
%   
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
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
    y.features = [1, 0, 0, 1, 0, 0, 1, 1];
    y.libraries = [0, 1, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

frac1 = 1 + cos(12*sqrt(x(1)^2 + x(2)^2));
frac2 = 0.5*(x(1)^2 + x(2)^2) + 2;
y = -frac1/frac2;
end

function xl = get_xl(nx)
    xl = -5.12*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5.12*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end
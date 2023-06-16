function y = Grlee12(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Grlee12.m
%
% References:																		
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%
% Globally optimal solution:
%   f = -0.86901113498949988934
%   x = 0.54856344445071347771
%
% Default variable bounds:
%   0.5 <= x <= 2.5
%
% Problem Properties:
%   n  = 1;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Non-dfferentiable, Separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 1;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [0, 1, 0, 1, 0, 0, 0, 1];
    y.libraries = [0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sin(10*pi*x)/(2*x) + (x - 1)^4;
end  

function xl = get_xl(nx)
    xl = 0.5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 2.5*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -0.86901113498949988934;
end

function xmin = get_xmin(~)
    xmin = 0.54856344445071347771;
end
function y = Xor(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Xor.m
%
% References:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = 0.95975875701196144973;
%   x = [1; -1; 1; -1; -1; 1; 1; -1; 0.42145711595255291870]
%
% Default variable bounds:
%   -1 <= x(i) <= 1, i = 1,...,n
%
% Problem Properties:
%   n  = 9;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 9;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end  
if size(x, 2) > size(x, 1), x = x'; end

a1 = (1 + exp(-(x(7)/(1 + exp(-x(1) - x(2) - x(5)))) - (x(8)/(1 + exp(-x(3) - x(4) - x(6)))) - x(9)))^(-2);
a2 = (1 + exp(-(x(7)/(1 + exp(-x(5)))) - (x(8)/(1 + exp(-x(6)))) - x(9)))^(-2);
a3 = (1 - (1 + exp(-(x(7)/(1 + exp(-x(1) - x(5)))) - (x(8)/(1 + exp(-x(3) - x(6)))) - x(9)))^(-1))^2;
a4 = (1 - (1 + exp(-(x(7)/(1 + exp(-x(2) - x(5)))) - (x(8)/(1 + exp(-x(4) - x(6)))) - x(9)))^(-1))^2;

y = a1 + a2 + a3 + a4;
end 

function xl = get_xl(nx)
    xl = -ones(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0.95975875701196144973;
end

function xmin = get_xmin(~)
    xmin = [1; -1; 1; -1; -1; 1; 1; -1; 0.42145711595255291870];
end
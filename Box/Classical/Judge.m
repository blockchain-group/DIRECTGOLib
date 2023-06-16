function y = Judge(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   JennrichSampson.m
%
% References:	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = 16.08173013296038433850
%   x = [0.86478728508855340351; 1.23574849975654821321]
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
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

A=[4.284,4.149,3.877,0.533,2.211,2.389,2.145,3.231,1.998,1.379,2.106,1.428,1.011,2.179,2.858,1.388,1.651,1.593,1.046,2.152];
B=[0.286,0.973,0.384,0.276,0.973,0.543,0.957,0.948,0.543,0.797,0.936,0.889,0.006,0.828,0.399,0.617,0.939,0.784,0.072,0.889];
C=[0.645,0.585,0.310,0.058,0.455,0.779,0.259,0.202,0.028,0.099,0.142,0.296,0.175,0.180,0.842,0.039,0.103,0.620,0.158,0.704];
y = 0;
for k = 1:20
    y = y + ((x(1) + B(k)*x(2) + C(k)*x(2)^2) - A(k))^2;
end
end

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 16.08173013296038433850;
end

function xmin = get_xmin(~)
    xmin = [0.86478728508855340351; 1.23574849975654821321];
end
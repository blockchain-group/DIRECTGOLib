function y = McCormick(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   McCormick.m
%
% References:																						
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%  - Rody Oldenhuis (2020): Test functions for global optimization algorithms
%    URL: https://github.com/rodyo/FEX-testfunctions/releases/tag/v1.5
%
% Globally optimal solution:
%   f = -1.91322295498103667200
%   x = [-0.54719754315734725481; -1.54719754470648629407]
%
% Default variable bounds:
%   -1.5 <= x(1) <= 4
%   -3 <= x(2) <= 4
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
    y.libraries = [0, 1, 0, 1, 1, 0, 1, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

term1 = sin(x(1) + x(2));
term2 = (x(1) - x(2))^2;
term3 = -1.5*x(1);
term4 = 2.5*x(2);
y = term1 + term2 + term3 + term4 + 1;
end

function xl = get_xl(~)
    xl = [-1.5; -3];
end

function xu = get_xu(~)
    xu = [4; 4];
end

function fmin = get_fmin(~)
    fmin = -1.91322295498103667200;
end

function xmin = get_xmin(~)
    xmin = [-0.54719754315734725481; -1.54719754470648629407];
end
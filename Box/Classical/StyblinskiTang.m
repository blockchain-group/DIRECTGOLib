function y = StyblinskiTang(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   StyblinskiTang.m
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
%   f = -39.166165703771426*n
%   x(i) = -2.9035340311065125, i = 1,...,n
%
% Default variable bounds:
%   -5 <= x(i) <= 5, i = 1,...,n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Non-scalable, Multi-modal,
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
    y.features = [1, 1, 1, 1, 0, 0, 0, 1];
    y.libraries = [0, 1, 0, 1, 1, 0, 1, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum(x.^4 - 16*x.^2 + 5*x)/2;
end

function xl = get_xl(nx)
    xl = -5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function fmin = get_fmin(nx)
    fmin = -39.166165703771426*nx;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*(-2.9035340311065125);
end
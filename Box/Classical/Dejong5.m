function y = Dejong5(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Dejong5.m
%
% References:																							
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%
% Globally optimal solution:
%   f = 0.99800383779444934440 
%   x = [-31.97833370393439622603; -31.97833490416763879693]
%
% Default variable bounds:
%   -65.536 <= x(i) <= 65.536, i = 1,...,n
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 1, 0, 0];
    y.libraries = [0, 1, 0, 0, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

A = zeros(2, 25);
a = [-32, -16, 0, 16, 32];
A(1, :) = repmat(a, 1, 5);
ar = repmat(a, 5, 1);
ar = ar(:)';
A(2, :) = ar;
sum = 0;
for ii = 1:25
    a1i = A(1, ii);
    a2i = A(2, ii);
    term1 = ii;
    term2 = (x(1) - a1i)^6;
    term3 = (x(2) - a2i)^6;
    new = 1 / (term1+term2+term3);
    sum = sum + new;
end
y = 1 / (0.002 + sum);
end 

function xl = get_xl(nx)
    xl = -65.536*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 65.536*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0.99800383779444934440;
end

function xmin = get_xmin(~)
    xmin = [-31.97833370393439622603; -31.97833490416763879693];
end
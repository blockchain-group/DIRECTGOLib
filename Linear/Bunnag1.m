function y = Bunnag1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bunnag1.m
%
% Original source: 
% - Bunnag D. and  Sun M. (2005, December). Genetic algorithm for 
%   constrained global optimization in continuous variables. Applied 
%   Mathematics and Computation, 171(1), 604 - 636.
%
% Globally optimal solution:
%   f* = 1/9
%   x* = [12/9; 7/9; 4/9]
%
% Default variable bounds:
%   0 <= x(i) <= 3, i = 1,...,n
%   
% Problem Properties:
%   n  = 3;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 9 - 8*x(1) - 6*x(2) - 4*x(3) + 2*x(1)^2 + 2*x(2)^2 + x(3)^2 +...
    2*x(1)*x(2) + 2*x(1)*x(3);
end

function [c, ceq] = funcon( x )
    c   = x(1) + x(2) + 2*x(3) - 3; 
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 3*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 1/9;
end

function xmin = get_xmin(~)
    xmin = [12/9; 7/9; 4/9];
end
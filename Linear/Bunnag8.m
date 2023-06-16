function y = Bunnag8(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bunnag8.m
%
% Original source: 
% - Bunnag D. and  Sun M. (2005, December). Genetic algorithm for 
%   constrained global optimization in continuous variables. Applied 
%   Mathematics and Computation, 171(1), 604 - 636.
%
% Globally optimal solution:
%   f* = -17
%   x* = (1; 1; 0; 1; 0) 
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,...,n
%   
% Problem Properties:
%   n  = 5;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = 42*x(1) + 44*x(2) + 45*x(3) + 47*x(4) + 47.5*x(5) - 50*transpose(x)*x;
end

function [c, ceq] = funcon( x )
    c   = 20*x(1) + 12*x(2) + 11*x(3) + 7*x(4) + 4*x(5) - 40; 
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -17;
end

function xmin = get_xmin(~)
    xmin = [1; 1; 0; 1; 0];
end
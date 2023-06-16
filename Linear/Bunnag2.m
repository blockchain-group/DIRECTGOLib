function y = Bunnag2(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bunnag2.m
%
% Original source: 
% - Bunnag D. and  Sun M. (2005, December). Genetic algorithm for 
%   constrained global optimization in continuous variables. Applied 
%   Mathematics and Computation, 171(1), 604 - 636.
%
% Globally optimal solution:
%   f* = -6.4052065000
%   x* = [1; 4; 0; 4]
%
% Default variable bounds:
%   0 <= x(i) <= 4, i = 1,...,n
%   
% Problem Properties:
%   n  = 4;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = x(1)^0.6 + 2*x(2)^0.6 - 2*x(2) + 2*x(3) - x(4);
end

function [c, ceq] = funcon( x )
    c(1) = x(1) + 2*x(3) - 4; 
    c(2) = -3*x(1) + x(4) - 1; 
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 4*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -6.4052065000;
end

function xmin = get_xmin(~)
    xmin = [1; 4; 0; 4];
end
function y = Bunnag5(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bunnag5.m
%
% Original source: 
% - Bunnag D. and  Sun M. (2005, December). Genetic algorithm for 
%   constrained global optimization in continuous variables. Applied 
%   Mathematics and Computation, 171(1), 604 - 636.
%
% Globally optimal solution:
%   f* = -11
%   x* = [0; 6; 0; 1; 1; 0]
%
% Default variable bounds:
%   0 <= x(1, 3, 6) <= 2;
%   0 <= x(2) <= 8;
%   0 <= x(4, 5) <= 1;
%   
% Problem Properties:
%   n  = 6;
%   #g = 5;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
    y.ng = 5;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 6.5*x(1) - 0.5*x(1)^2 - x(2) - 2*x(3) - 3*x(4) - 2*x(5) - x(6); 
end

function [c, ceq] = funcon(x)
    c(1) = x(1) + 2*x(2) + 8*x(3) + x(4) + 3*x(5) + 5*x(6) - 16; 
    c(2) = -8*x(1) - 4*x(2) - 2*x(3) + 2*x(4) + 4*x(5) - x(6) + 1; 
    c(3) = 2*x(1) + 0.5*x(2) + 0.2*x(3) - 3*x(4) - x(5) - 4*x(6) - 24;
    c(4) = 0.2*x(1) + 2*x(2) + 0.1*x(3) - 4*x(4) + 2*x(5) + 2*x(6) - 12;
    c(5) = -0.1*x(1) - 0.5*x(2) + 2*x(3) + 5*x(4) - 5*x(5) + 3*x(6) - 3; 
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = -11;
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [2; 8; 2; 1; 1; 2];
end

function xmin = get_xmin(~)
    xmin = [0; 6; 0; 1; 1; 0];
end
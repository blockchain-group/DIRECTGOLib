function y = Bunnag3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bunnag3.m
%
% Original source: 
% - Bunnag D. and  Sun M. (2005, December). Genetic algorithm for 
%   constrained global optimization in continuous variables. Applied 
%   Mathematics and Computation, 171(1), 604 - 636.
%
% Globally optimal solution:
%   f* = -16.369269956672596
%   x* = [0; 0; 4; 12/9; 0]
%
% Default variable bounds:
%         0 <= x(1) <= 3;
%         0 <= x(2, 5) <= 2;
%         0 <= x(3, 4) <= 4;
%   
% Problem Properties:
%   n  = 5;
%   #g = 3;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 3;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = x(1)^0.6 + x(2)^0.6 + x(3)^0.6 - 4*x(3) - 2*x(4) + 5*x(5);
end

function [c, ceq] = funcon( x )
    c(1) = x(1) + 2*x(4) - 4; 
    c(2) = 3*x(1) + 3*x(4) + x(5) - 4; 
    c(3) = 2*x(2) + 4*x(4) + 2*x(5) - 6; 
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [3; 2; 4; 4; 2];
end

function fmin = get_fmin(~)
    fmin = -16.369269956672596;
end

function xmin = get_xmin(~)
    xmin = [0; 0; 4; 12/9; 0];
end
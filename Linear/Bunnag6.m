function y = Bunnag6(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bunnag6.m
%
% Original source: 
% - Bunnag D. and  Sun M. (2005, December). Genetic algorithm for 
%   constrained global optimization in continuous variables. Applied 
%   Mathematics and Computation, 171(1), 604 - 636.
%
% Globally optimal solution:
%   f* = -268.0146315415
%   x* = [1; 0.9075471698; 0; 1; 0.7150943396; 1; 0; 0.9169811321; 1; 1]
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,...,n
%   
% Problem Properties:
%   n  = 10;
%   #g = 11;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 10;
    y.ng = 11;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum(x(1:6).*[-20; -80; -20; -50; -60; -90]) + 10*sum(x(8:10)) - 5*sum(x(1:7).^2); 
end

function [c, ceq] = funcon( x )
    c(1) = -2*x(1) - 6*x(2) - x(3) - 3*x(5) - 3*x(6) - 2*x(7) - 6*x(8) - 2*x(9) - 2*x(10) + 4;
    c(2) = 6*x(1) - 5*x(2) + 8*x(3) - 3*x(4) + x(6) + 3*x(7) + 8*x(8) + 9*x(9) - 3*x(10) - 22;
    c(3) = -5*x(1) + 6*x(2) + 5*x(3) + 3*x(4) + 8*x(5) - 8*x(6) + 9*x(7) + 2*x(8) - 9*x(10) + 6;
    c(4) = 9*x(1) + 5*x(2) - 9*x(4) + x(5) - 8*x(6) + 3*x(7) - 9*x(8) - 9*x(9) - 3*x(10) + 23;
    c(5) = -8*x(1) + 7*x(2) - 4*x(3) - 5*x(4) - 9*x(5) + x(6) - 7*x(7) - x(8) + 3*x(9) - 2*x(10) + 12;
    c(6) = -7*x(1) - 5*x(2) - 2*x(3) - 6*x(5) - 6*x(6) - 7*x(7) - 6*x(8) + 7*x(9) + 7*x(10) + 3;
    c(7) = x(1) - 3*x(2) - 3*x(3) - 4*x(4) - x(5) - 4*x(7) + 6*x(9) - 1;
    c(8) = x(1) - 2*x(2) + 6*x(3) + 9*x(4) - 7*x(6) + 9*x(7) - 9*x(8) - 6*x(9) + 4*x(10) - 12;
    c(9) = -4*x(1) + 6*x(2) + 7*x(3) + 2*x(4) + 2*x(5) + 6*x(7) + 6*x(8) - 7*x(9) + 4*x(10) - 15;
    c(10) = sum(x) - 9;
    suma = 0;
    for i = 1:10
        suma = suma + x(i);
    end
    c(11) = -suma + 1;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -268.0146315415;    
end

function xmin = get_xmin(~)
    xmin = [1; 0.9075471698; 0; 1; 0.7150943396; 1; 0; 0.9169811321; 1; 1];
end
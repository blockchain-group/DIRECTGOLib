function y = Bunnag12(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bunnag12.m
%
% Original source: 
% - Bunnag D. and  Sun M. (2005, December). Genetic algorithm for 
%   constrained global optimization in continuous variables. Applied 
%   Mathematics and Computation, 171(1), 604 - 636.
%
% Globally optimal solution:
%   f* = -8695.0122483188
%   x* = [0; 0; 28.8023973416; 0; 0; 4.1792072158; 0; 0; 0; 0; 0; 0; 0; 0; 0.6186802753; 4.0932826964;0; 2.3064324709; 0; 0]
%
% Default variable bounds:
%   0 <= x(i) <= 100, i = 1,...,n
%   
% Problem Properties:
%   n  = 20;
%   #g = 10;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 20;
    y.ng = 10;
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
y = -10*sum((x).^2);
end

function [c, ceq] = funcon( x )
    c(1)  = 3*x(1) + 7*x(2) - 5*x(4) + x(5) + x(6) + 2*x(8) - x(9) - x(10) - 9*x(11) + 3*x(12) + 5*x(13) + x(16) + 7*x(17) - 7*x(18) - 4*x(19) - 6*x(20) + 5;
    c(2)  = 7*x(1) - 5*x(3) + x(4) + x(5) + 2*x(7) - x(8) - x(9) - 9*x(10) + 3*x(11) + 5*x(12) + x(15) + 7*x(16) - 7*x(17) - 4*x(18) - 6*x(19) - 3*x(20) - 2;
    c(3)  = -5*x(2) + x(3) + x(4) + 2*x(6) - x(7) - x(8) - 9*x(9) + 3*x(10) + 5*x(11) + x(14) + 7*x(15) - 7*x(16) - 4*x(17) - 6*x(18) - 3*x(19) + 7*x(20) + 1;
    c(4)  = -5*x(1) + x(2) + x(3) + 2*x(5) - x(6) - x(7) - 9*x(8) + 3*x(9) + 5*x(10) + x(13) + 7*x(14) - 7*x(15) - 4*x(16) - 6*x(17) - 3*x(18) + 7*x(19) + 3;
    c(5)  = x(1) + x(2) + 2*x(4) - x(5) - x(6) - 9*x(7) + 3*x(8) + 5*x(9) + x(12) + 7*x(13) - 7*x(14) - 4*x(15) - 6*x(16) - 3*x(17) + 7*x(18) - 5*x(20) - 5;
    c(6)  = x(1) + 2*x(3) - x(4) - x(5) - 9*x(6) + 3*x(7) + 5*x(8) + x(11) + 7*x(12) - 7*x(13) - 4*x(14) - 6*x(15) - 3*x(16) + 7*x(17) - 5*x(19) + x(20) - 4;
    c(7)  = 2*x(2) - x(3) - x(4) - 9*x(5) + 3*x(6) + 5*x(7) + x(10) + 7*x(11) - 7*x(12) - 4*x(13) - 6*x(14) - 3*x(15) + 7*x(16) - 5*x(18) + x(19) + x(20) + 1;
    c(8)  = 2*x(1) - x(2) - x(3) - 9*x(4) + 3*x(5) + 5*x(6) + x(9) + 7*x(10) - 7*x(11) - 4*x(12) - 6*x(13) - 3*x(14) + 7*x(15) - 5*x(17) + x(18) + x(19);
    c(9)  = -x(1) - x(2) - 9*x(3) + 3*x(4) + 5*x(5) + x(8) + 7*x(9) - 7*x(10) - 4*x(11) - 6*x(12) - 3*x(13) + 7*x(14) - 5*x(16) + x(17) + x(18) + 2*x(20) - 9;
    c(10) = sum(x) - 40;
    ceq   = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -8695.0122483188;
end

function xmin = get_xmin(~)
    xmin = [0; 0; 28.8023973416; 0; 0; 4.1792072158; 0; 0; 0; 0; 0; 0; 0; 0; 0.6186802753; 4.0932826964;0; 2.3064324709; 0; 0];
end
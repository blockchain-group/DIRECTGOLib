function y = Three_bar_truss(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Three_bar_truss.m
%
% Original source: 
% - L. C. Cagnina, S. C. Esquivel and C. A. Coello Coello: Solving 
%   Engineering Optimization Problems with the Simple Constrained Particle 
%   Swarm Optimizer, Informatica (Slovenia), Vol.3, No.32, pp. 319-326, 2008. 
%
% Known optimal solution:
%   f* = 263.8958433764917686
%   x* = [0.788675136247114; 0.408248285790449]
%
% Problem Properties:
%   n  = 2;
%   #g = 3;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 3;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) Three_bar_trussc(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = (2*sqrt(2)*x(1) + x(2))*100;
end

function [c, ceq] = Three_bar_trussc( x )
    c(1) = ((sqrt(2)*x(1) + x(2))/(sqrt(2)*x(1)^2 + 2*x(1)*x(2)))*2 - 2; 
    c(2) = ((x(2))/(sqrt(2)*x(1)^2 + 2*x(1)*x(2)))*2 - 2; 
    c(3) = ((1)/(x(1) + sqrt(2)*x(2)))*2 - 2; 
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 263.8958433764684;
end

function xmin = get_xmin(~)
    xmin = [0.788675136247114; 0.408248285790449];
end
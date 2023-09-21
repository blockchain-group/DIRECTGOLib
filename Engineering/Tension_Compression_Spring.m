function y = Tension_Compression_Spring(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Tension_Compression_Spring.m
%
% Original source: 
% - L. C. Cagnina, S. C. Esquivel and C. A. Coello Coello: Solving 
%   Engineering Optimization Problems with the Simple Constrained Particle 
%   Swarm Optimizer, Informatica (Slovenia), Vol.3, No.32, pp. 319-326, 2008. 
%
% Known optimal solution:
%   f* = 0.012678676871298
%   x* = [0.0517044381603090; 0.357088612132426; 11.2813519848793]
%
% Problem Properties:
%   n  = 3;
%   #g = 4;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 4;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) Tension_Compression_Springc(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = x(1)^2*x(2)*(x(3) + 2);
end

function [c, ceq] = Tension_Compression_Springc( x )
    c(1) = 1 - (((x(2)^3)*x(3))/(71875*x(1)^4));
    c(2) = (((4*x(2)-x(1))*x(2))/(12566*(x(1)^3)*(x(2) - x(1)))) + (2.46/(12566*x(1)^2)) - 1;
    c(3) = 1 - ((140.54*x(1))/(x(3)*x(2)^2));
    c(4) = ((x(1) + x(2))/1.5) - 1; 
    ceq = [];
end

function xl = get_xl(~)
    xl = [0.05; 0.25; 2];
end

function xu = get_xu(~)
    xu = [0.2; 1.3; 15];
end

function fmin = get_fmin(~)
    fmin = 0.012678676871298;
end

function xmin = get_xmin(~)
    xmin = [0.0517044381603090; 0.357088612132426; 11.2813519848793];
end
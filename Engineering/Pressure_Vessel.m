function y = Pressure_Vessel(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Pressure_Vessel.m
%
% Original source: 
% - L. C. Cagnina, S. C. Esquivel and C. A. Coello Coello: Solving 
%   Engineering Optimization Problems with the Simple Constrained Particle 
%   Swarm Optimizer, Informatica (Slovenia), Vol.3, No.32, pp. 319-326, 2008. 
%
% Globally optimal solution:
%   f* = 7163.739568875251
%   x* = [1.1; 0.625; 56.9948186528498; 51.0012517339097]
%   
% Problem Properties:
%   n  = 4;
%   #g = 6;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 6;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = 0.6224*x(1)*x(3)*x(4) + 1.7781*x(2)*x(3)^2 + 3.1661*x(1)^2*x(4) + 19.84*x(1)^2*x(3); 
end

function [c, ceq] = ConFun( x )
    c(1) = -x(1) + 0.0193*x(3);
    c(2) = -x(2) + 0.00954*x(3);  
    c(3) = -pi*x(3)^2*x(4) - (4/3)*pi*x(3)^3 + 1296000; 
    c(4) = x(4) - 240; 
    c(5) = 1.1 - x(1);
    c(6) = 0.6 - x(2);
    ceq = [];
end

function xl = get_xl(~)
    xl = [1; 0.625; 25; 25];
end

function xu = get_xu(~)
    xu = [1.375; 1; 150; 240];
end

function fmin = get_fmin(~)
    fmin = 7163.739568875251;
end

function xmin = get_xmin(~)
    xmin = [1.1; 0.625; 56.9948186528498; 51.0012517339097];
end
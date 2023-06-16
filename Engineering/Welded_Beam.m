function y = Welded_Beam(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Welded_Beam.m
%
% Original source: 
% - L. C. Cagnina, S. C. Esquivel and C. A. Coello Coello: Solving 
%   Engineering Optimization Problems with the Simple Constrained Particle 
%   Swarm Optimizer, Informatica (Slovenia), Vol.3, No.32, pp. 319-326, 2008. 
%
% Globally optimal solution:
%   f* = 1.7248523725928164
%   x* = (0.205729631527588; 3.47048892954990; 9.03662399165770; 0.205729643343445) 
%
% Box constraints:
%   0.1 <= x(1) <= 2;
%   0.1 <= x(2) <= 10;
%   0.1 <= x(3) <= 10;
%   0.1 <= x(4) <= 2;
%   
% Problem Properties:
%   n  = 4;
%   #g = 7;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 7;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) Welded_Beamc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 1.10471*x(1)^2*x(2) + 0.04811*x(3)*x(4)*(14.0 + x(2));
end

function [c, ceq] = Welded_Beamc( x )
t_max = 13600; s_max = 30000; d_max = 0.25;
P = 6000; L = 14; E = 30e+6; G = 12e+6;
M = P*(L+(x(2)/2)); 
J = 2*(sqrt(2)*x(1)*x(2)*(x(2)^2/12+0.25*(x(1)+x(3))^2));
P_c = (4.013*E/(6*L^2))*x(3)*x(4)^3*(1-0.25*x(3)*sqrt(E/G)/L);
R = sqrt(((x(2)^2)/4)+((x(1)+x(3))/2)^2);
t1 = P/(sqrt(2)*x(1)*x(2)); t2 = M*R/J;
t = sqrt(t1^2+t1*t2*x(2)/R+t2^2);
s = 6*P*L/(x(4)*x(3)^2);
d = 4*P*L^3/(E*x(4)*x(3)^3);

c(1) = t-t_max;
c(2) = s-s_max;
c(3) = x(1)-x(4);
c(4) = 0.10471*x(1)^2+0.04811*x(3)*x(4)*(14.0+x(2))-5.0;
c(5) = d-d_max;
c(6) = P-P_c;
c(7) = 0.125 - x(1);
ceq = [];
end

function xl = get_xl(nx)
    xl = 0.1*ones(nx, 1);
end

function xu = get_xu(~)
    xu = [2; 10; 10; 2];
end

function fmin = get_fmin(~)
    fmin = 1.7248523725928164;
end

function xmin = get_xmin(~)
    xmin = [0.205729631527588; 3.47048892954990; 9.03662399165770;...
        0.205729643343445];
end
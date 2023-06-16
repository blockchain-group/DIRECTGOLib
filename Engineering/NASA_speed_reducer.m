function y = NASA_speed_reducer(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   NASA_speed_reducer.m
%
% Original source: 
% - L. C. Cagnina, S. C. Esquivel and C. A. Coello Coello: Solving 
%   Engineering Optimization Problems with the Simple Constrained Particle 
%   Swarm Optimizer, Informatica (Slovenia), Vol.3, No.32, pp. 319-326, 2008. 
%
% Globally optimal solution:
%   f* = 2996.3481692405475769
%   x* = [3.5; 0.7; 17; 7.3; 7.8; 3.35021467476924; 5.28668323300007] 
%
% Default variable bounds:
%   2.6 <= x(1) <= 3.6;
%   0.7 <= x(2) <= 0.8;
%   17  <= x(3) <= 28;
%   7.3 <= x(4) <= 8.3;
%   7.8 <= x(5) <= 8.3;
%   2.9 <= x(6) <= 3.9;    
%   5   <= x(7) <= 5.5;
%   
% Problem Properties:
%   n  = 7;
%   #g = 11;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 7;
    y.ng = 11;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) NASA_speed_reducerc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 0.7854*x(1)*x(2)^2*(3.3333*x(3)^2 + 14.9334*x(3)-43.0934) -...
    1.508*x(1)*(x(6)^2 + x(7)^2) + 7.4777*(x(6)^3 + x(7)^3) +...
    0.7854*(x(4)*x(6)^2 + x(5)*x(7)^2);
end

function [c, ceq] = NASA_speed_reducerc( x )
c(1) = (27/(x(1)*x(2)^2*x(3))) - 1;
c(2) = (397.5/(x(1)*x(2)^2*x(3)^2)) - 1;  
c(3) = ((1.93*x(4)^3)/(x(2)*x(3)*x(6)^4)) - 1;  
c(4) = ((1.93*x(5)^3)/(x(2)*x(3)*x(7)^4)) - 1;  
c(5) = ((sqrt((((745*x(4))/(x(2)*x(3)))^2) + 16.9 * 10^6)) * (1/(110 * x(6)^3))) - 1; 
c(6) = (((((745*x(5))/(x(2)*x(3)))^2 + 157.5 * 10^6)^(1/2))/(85 * x(7)^3)) - 1 ; 
c(7) = ((x(2)*x(3))/(40)) - 1;   
c(8) = ((5*x(2))/(x(1))) - 1; 
c(9) = ((x(1))/(12*x(2))) - 1; 
c(10) = (((1.5*x(6) + 1.9))/(x(4))) - 1; 
c(11) = ((1.1*x(7) + 1.9)/(x(5))) - 1; 
ceq = [];
end

function xl = get_xl(~)
    xl = [2.6; 0.7; 17; 7.3; 7.8; 2.9; 5];
end

function xu = get_xu(~)
    xu = [3.6; 0.8; 28; 8.3; 8.3; 3.9; 5.5];
end

function fmin = get_fmin(~)
    fmin = 2996.3481692405475769;
end

function xmin = get_xmin(~)
    xmin = [3.5; 0.7; 17; 7.3; 7.8; 3.35021467476924; 5.28668323300007];
end
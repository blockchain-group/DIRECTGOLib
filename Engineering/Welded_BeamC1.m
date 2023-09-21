function y = Welded_BeamC1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Welded_BeamC1.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 1.670217726279856
%   x* = [0.198832307224329; 3.33736529864610; 9.19202432248105; 0.198832307224329];
%    
% Problem Properties:
%   n  = 4;
%   #g = 5;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 4;
    y.ng = 5;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = 1.10471*x(1)^2*x(2) + 0.04811*x(3)*x(4)*(14 + x(2));
end

function [g, ceq] = ConFun( x )
    P = 6000; L = 14; delta_max = 0.25; E = 30*1e6; G = 12*1e6;
    T_max = 13600; sigma_max = 30000;
    Pc = 4.013*E*sqrt(x(3)^2*x(4)^6/30)/L^2*(1 - x(3)/(2*L)*sqrt(E/(4*G)));
    sigma = 6*P*L/(x(4)*x(3)^2);
    delta = 6*P*L^3/(E*x(3)^2*x(4));
    J = 2*(sqrt(2)*x(1)*x(2)*(x(2)^2/4 + (x(1) + x(3))^2/4));
    R = sqrt(x(2)^2/4 + (x(1) + x(3))^2/4);
    M = P*(L + x(2)/2);
    ttt = M*R/J;
    tt = P/(sqrt(2)*x(1)*x(2));
    t  = sqrt(tt^2 + 2*tt*ttt*x(2)/(2*R) + ttt^2);
    g(1) = t - T_max;
    g(2) = sigma - sigma_max;
    g(3) = x(1) - x(4);
    g(4) = delta - delta_max;
    g(5) = P - Pc;
    ceq = [];
end

function xl = get_xl(~)
    xl = [0.125; 0.1; 0.1; 0.1];
end

function xu = get_xu(~)
    xu = [2; 10; 10; 2];
end

function fmin = get_fmin(~)
    fmin = 1.670217726279856;
end

function xmin = get_xmin(~)
    xmin = [0.198832307224329; 3.33736529864610; 9.19202432248105; 0.198832307224329];
end
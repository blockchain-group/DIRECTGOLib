function y = Tension_Compression_SpringC1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Tension_Compression_SpringC1.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 0.012665239412801
%   x* = [0.0517081220631298; 0.357176470054297; 11.2621224112237]
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
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = x(1)^2*x(2)*(x(3) + 2);
end

function [g, ceq] = ConFun( x )
    g(1) = 1 - (x(2)^3*x(3))/(71785*x(1)^4);
    g(2) = (4*x(2)^2 - x(1)*x(2))/(12566*(x(2)*x(1)^3 - x(1)^4)) + 1/(5108*x(1)^2) - 1;
    g(3) = 1 - 140.45*x(1)/(x(2)^2*x(3));
    g(4) = (x(1) + x(2))/1.5 - 1;
    ceq = [];
end

function xl = get_xl(~)
    xl = [0.05; 0.25; 2.00];
end

function xu = get_xu(~)
    xu = [2; 1.3; 15.0];
end

function fmin = get_fmin(~)
    fmin = 0.012665239412801;
end

function xmin = get_xmin(~)
    xmin = [0.0517081220631298; 0.357176470054297; 11.2621224112237];
end
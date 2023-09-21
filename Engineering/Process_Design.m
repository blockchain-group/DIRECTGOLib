function y = Process_Design(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Process_Design.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 26887.42221075205
%   x* = [38.7919323195184; 27; 45; 78.0269208460161; 32.5108526027715]
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
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = -5.357854*x(1)^2 - 0.835689*round(x(4))*x(3) - 37.29329*round(x(4)) + 40792.141;
end

function [g, ceq] = ConFun( x )
    a = [85.334407, 0.0056858, 0.0006262, 0.0022053, 80.51249, 0.0071317,....
         0.0029955, 0.0021813, 9.300961, 0.0047026, 0.0012547, 0.0019085];
    g(1) = a(1) + a(2)*round(x(5))*x(3) + a(3)*round(x(4))*x(2) - a(4)*round(x(4))*round(x(4)).*x(3) - 92;
    g(2) = a(5) + a(6)*round(x(5))*x(3) + a(7)*round(x(4))*x(2) + a(8)*x(1)^2 -90 -20;
    g(3) = a(9) + a(10)*round(x(4))*x(2) + a(11)*round(x(4))*x(1) + a(12)*x(1)*x(2) - 20 - 5;
    ceq = [];
end

function xl = get_xl(~)
    xl = [27; 27; 27; 77.51; 32.51];
end

function xu = get_xu(~)
    xu = [45; 45; 45; 102.49; 45.49];
end

function fmin = get_fmin(~)
    fmin = 26887.42221075205;
end

function xmin = get_xmin(~)
    xmin = [38.7919323195184; 27; 45; 78.0269208460161; 32.5108526027715];
end
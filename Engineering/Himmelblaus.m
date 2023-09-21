function y = Himmelblaus(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Himmelblaus.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = -30665.53867178333
%   x* = [77.999999999999990; 33; 29.995256025681550; 44.999999999999940; 
%         36.775812905788350]
%     
% Problem Properties:
%   n  = 5;
%   #g = 6;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 5;
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
y = 5.3578547*x(3)^2 + 0.8356891*x(1)*x(5) + 37.293239*x(1) - 40792.141;
end

function [g, ceq] = ConFun( x )
    G1 = 85.334407 + 0.0056858*x(2)*x(5) + 0.0006262*x(1)*x(4) - 0.0022053*x(3)*x(5);
    G2 = 80.51249 + 0.0071317*x(2)*x(5) + 0.0029955*x(1)*x(2) + 0.0021813*x(3)^2;
    G3 = 9.300961 + 0.0047026*x(3)*x(5) + 0.0012547*x(1)*x(3) + 0.0019085*x(3)*x(4);
    g(1) = G1 - 92;
    g(2) = -G1;
    g(3) = G2 - 110;
    g(4) = -G2 + 90;
    g(5) = G3 - 25;
    g(6) = -G3 + 20;
    ceq = [];
end

function xl = get_xl(~)
    xl = [78; 33; 27; 27; 27];
end

function xu = get_xu(~)
    xu = [102; 45; 45; 45; 45];
end

function fmin = get_fmin(~)
    fmin = -30665.53867178333;    
end

function xmin = get_xmin(~)
    xmin = [77.999999999999990; 33; 29.995256025681550; 44.999999999999940; 36.775812905788350];
end
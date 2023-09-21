function y = Operation_Of_Alkylation_Unit(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Operation_Of_Alkylation_Unit.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = -4529.119739531005
%   x* = [2000; 0; 2576.38655036785; 0; 58.1606388688429; 1.25996893915121; 41.1851240822016];
%   
% Problem Properties:
%   n  = 7;
%   #g = 14;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 7;
    y.ng = 14;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = -1.715*x(1) - 0.035*x(1)*x(6) - 4.0565*x(3) - 10*x(2) + 0.063*x(3)*x(5);
end

function [g, ceq] = ConFun( x )
    g(1) = 0.0059553571*x(6)^2*x(1) + 0.88392857*x(3) - 0.1175625*x(6)*x(1) - x(1);
    g(2) = 1.1088*x(1) + 0.1303533*x(1)*x(6) - 0.0066033*x(1)*x(6)^2 - x(3);
    g(3) = 6.66173269*x(6)^2 + 172.39878*x(5) - 56.596669*x(4) - 191.20592*x(6) - 10000;
    g(4) = 1.08702*x(6) + 0.32175*x(4) - 0.03762*x(6)^2 - x(5) + 56.85075;
    g(5) = 0.006198*x(7)*x(4)*x(3) + 2462.3121*x(2) - 25.125634*x(2)*x(4) - x(3)*x(4);
    g(6) = 161.18996*x(3)*x(4) + 5000*x(2)*x(4) - 489510*x(2) - x(3)*x(4)*x(7);
    g(7) = 0.33*x(7) - x(5) + 44.333333;
    g(8) = 0.022556*x(5) - 0.007595*x(7) - 1;
    g(9) = 0.00061*x(3) - 0.0005*x(1) - 1;
    g(10) = 0.819672*x(1) - x(3) + 0.819672;
    g(11) = 24500*x(2) - 250*x(2)*x(4) - x(3)*x(4);
    g(12) = 1020.4082*x(4)*x(2) + 1.2244898*x(3)*x(4) - 100000*x(2);
    g(13) = 6.25*x(1)*x(6) + 6.25*x(1) - 7.625*x(3) - 100000;
    g(14) = 1.22*x(3) - x(6)*x(1) - x(1) + 1;
    ceq = [];
end

function xl = get_xl(~)
    xl = [1000; 0; 2000; 0; 0; 0; 0];
end

function xu = get_xu(~)
    xu = [2000; 100; 4000; 100; 100; 20; 200];
end

function fmin = get_fmin(~)
    fmin = -4529.119739531005;
end

function xmin = get_xmin(~)
    xmin = [2000; 0; 2576.38655036785; 0; 58.1606388688429; 1.25996893915121; 41.1851240822016];
end
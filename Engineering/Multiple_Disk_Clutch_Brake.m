function y = Multiple_Disk_Clutch_Brake(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Multiple_Disk_Clutch_Brake.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 0.235242457900804
%   x* = [70; 90; 1; 166.192359694601; 2]
%  
% Problem Properties:
%   n  = 5;
%   #g = 8;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 5;
    y.ng = 8;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = pi*(x(2)^2 - x(1)^2)*x(3)*(x(5) + 1)*0.0000078;
end

function [g, ceq] = ConFun(x)
    % Constants and parameters
    Mf = 3;
    Ms = 40;
    Iz = 55;
    n = 250;
    Tmax = 15;
    s = 1.5;
    delta = 0.5;
    Vsrmax = 10;
    pmax = 1;
    mu = 0.6;
    Lmax = 30;
    delR = 20;

    % Calculate intermediate variables
    Rsr = 2/3 * (x(2)^3 - x(1)^3) / (x(2)^2 * x(1)^2);
    Vsr = pi * Rsr * n / 30;
    A = pi * (x(2)^2 - x(1)^2);
    Prz = x(4) / A;
    w = pi * n / 30;
    Mh = 2/3 * mu * x(4) * x(5) * (x(2)^3 - x(1)^3) / (x(2)^2 - x(1)^2);
    T = Iz * w / (Mh + Mf);

    % Constraints
    g(1) = -x(2) + x(1) + delR; 
    g(2) = (x(5) + 1) * (x(3) + delta) - Lmax; 
    g(3) = Prz - pmax; 
    g(4) = Prz * Vsr - pmax * Vsrmax; 
    g(5) = Vsr - Vsrmax; 
    g(6) = T - Tmax; 
    g(7) = s * Ms - Mh;
    g(8) = -T; 

    % No equality constraints
    ceq = [];
end

function xl = get_xl(~)
    xl = [60; 90; 1; 0; 2];
end

function xu = get_xu(~)
    xu = [80; 110; 3; 1000; 9];
end

function fmin = get_fmin(~)
    fmin = 0.235242457900804;
end

function xmin = get_xmin(~)
    xmin = [70; 90; 1; 166.192359694601; 2];
end
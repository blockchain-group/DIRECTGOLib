function y = Hydro_Static_Thrust_Bearing(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hydro_Static_Thrust_Bearing.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 1616.119765050755
%   x* = [5.95551137149357; 5.38871591180826; 5.35869726574408e-06; 2.25663797867580]
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
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

% Constants and parameters
gamma = 0.0307;
C = 0.5;
n = -3.55;
C1 = 10.04;
N = 750;

% Variable assignments
R = x(1);
Ro = x(2);
mu = x(3);
Q = x(4);

% Calculations
P = (log10(log10(8.122e6 * mu + 0.8)) - C1) / n;
delT = 2 * (10^P - 560);
Ef = 9336 * Q * gamma * C * delT;
h = (2 * pi * N / 60)^2 * 2 * pi * mu / Ef * (R^4 / 4 - Ro^4 / 4) - 1e-5;
Po = (6 * mu * Q / (pi * h^3)) * log(R / Ro);

% Final result
y = (Q * Po / 0.7 + Ef) / 12;
end

function [g, ceq] = ConFun(x)
    % Constants and parameters
    gamma = 0.0307;
    C = 0.5;
    n = -3.55;
    C1 = 10.04;
    gg = 386.4;
    Ws = 101000;
    Pmax = 1000;
    delTmax = 50;
    hmin = 0.001;
    N = 750;

    % Variable assignments
    R = x(1);
    Ro = x(2);
    mu = x(3);
    Q = x(4);

    % Calculations
    P = (log10(log10(8.122e6 * mu + 0.8)) - C1) / n;
    delT = 2 * (10^P - 560);
    Ef = 9336 * Q * gamma * C * delT;
    h = (2 * pi * N / 60)^2 * 2 * pi * mu / Ef * (R^4 / 4 - Ro^4 / 4) - 1e-5;
    Po = (6 * mu * Q / (pi * h^3)) * log(R / Ro);
    W = pi * Po / 2 * (R^2 - Ro^2) / (log(R / Ro) - 1e-5);

    % Constraints
    g(1) = Ws - W; % Constraint 1: Ws >= W
    g(2) = Po - Pmax; % Constraint 2: Po <= Pmax
    g(3) = delT - delTmax; % Constraint 3: delT <= delTmax
    g(4) = hmin - h; % Constraint 4: h >= hmin
    g(5) = Ro - R; % Constraint 5: Ro >= R
    g(6) = gamma / (gg * Po) * (Q / (2 * pi * R * h)) - 0.001; % Constraint 6: (gamma / (gg * Po)) * (Q / (2 * pi * R * h)) <= 0.001
    g(7) = W / (pi * (R^2 - Ro^2) + 1e-5) - 5000; % Constraint 7: W / (pi * (R^2 - Ro^2)) <= 5000

    % Replace inf values with a large value for optimization purposes
    g(isinf(g)) = 1e+100;

    % No equality constraints
    ceq = [];
end


function xl = get_xl(~)
    xl = [1; 1; 1e-6; 1];
end

function xu = get_xu(~)
    xu = [16; 16; 16*1e-6; 16];
end

function fmin = get_fmin(~)
    fmin = 1616.119765050755;
end

function xmin = get_xmin(~)
    xmin = [5.95551137149357; 5.38871591180826; 5.35869726574408e-06; 2.25663797867580];
end
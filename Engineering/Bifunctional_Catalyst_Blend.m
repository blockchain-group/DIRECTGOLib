function y = Bifunctional_Catalyst_Blend(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Bifunctional_Catalyst_Blend.m
%
% References:				
%  - Das, Swagatam, and Ponnuthurai N. Suganthan. "Problem definitions and 
%    evaluation criteria for CEC 2011 competition on testing evolutionary 
%    algorithms on real world optimization problems." Jadavpur University, 
%    Nanyang Technological University, Kolkata (2010): 341-359.																			
%
% Known optimal solution:
%   f* = 0.00001151489058353534
%   x* = 0.789156270452730
%
% Problem Properties:
%   n  = 1
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 1;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 1) > size(x, 2), x = x'; end

% Set the tolerance and time span for solving ODEs
tol = 1.0e-1;
tspan = [0, 0.78];

% Initial conditions for the ODE system
yo = [1, 0, 0, 0, 0, 0, 0];

% Extract the parameter vector 'u' from input 'x'
u = x;

% Set the relative tolerance for the ode45 solver
options = odeset('RelTol', tol);

% Solve the ODE system using ode45 solver
[~, Y] = ode45(@(t, y) Solvethis(t, y, u), tspan, yo, options);

% Get the size of the solution matrix Y
w = size(Y);

% Calculate the fitness value 'y' based on the solution
y = Y(w(1), w(2)) * 1e+003;

% Check for NaN value and set a large value if necessary
if isnan(y)
    y = 10^100;
end
end

function xl = get_xl(~)
    xl = 0.6;
end

function xu = get_xu(~)
    xu = 0.9;
end

function fmin = get_fmin(~)
    fmin = 0.00001151489058353534;
end

function xmin = get_xmin(~)
    xmin = 0.789156270452730;
end

function dy = Solvethis(~, x, u)
    c = [0.002918487,-0.008045787,0.006749947,-0.001416647;9.509977,-35.00994,42.83329,-17.33333;
        26.82093,-95.56079,113.0398,-44.29997;208.7241,-719.8052,827.7466,-316.6655;
        1.350005,-6.850027,12.16671,-6.666689;0.01921995,-0.07945320,0.1105660,-0.05033333;
        0.1323596,-0.4692550,0.5539323,-0.2166664;7.339981,-25.27328,29.93329,-11.99999;
        -0.3950534,1.679353,-1.777829,0.4974987;-2.504665e-05,0.01005854,-0.01986696,0.009833470];
    ml = [1, u, u.^2, u.^3]; mlt = repmat(ml, 10, 1); k = sum(c.*mlt, 2);
    dy = zeros(7, 1); 
    dy(1) = -k(1)*x(1);
    dy(2) = k(1)*x(1) - (k(2) + k(3))*x(2) + k(4)*x(5);
    dy(3) = k(2)*x(2);
    dy(4) = -k(6)*x(4) + k(5)*x(5);
    dy(5) = k(3)*x(2) + k(6)*x(4) - (k(4) + k(5) + k(8) + k(9))*x(5) + k(7)*x(6) + k(10)*x(7);
    dy(6) = k(8)*x(5) - k(7)*x(6);
    dy(7) = k(9)*x(5) - k(10)*x(7);
end
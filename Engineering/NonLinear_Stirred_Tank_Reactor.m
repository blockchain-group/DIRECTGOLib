function y = NonLinear_Stirred_Tank_Reactor(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   NonLinear_Stirred_Tank_Reactor.m
%
% References:				
%  - Das, Swagatam, and Ponnuthurai N. Suganthan. "Problem definitions and 
%    evaluation criteria for CEC 2011 competition on testing evolutionary 
%    algorithms on real world optimization problems." Jadavpur University, 
%    Nanyang Technological University, Kolkata (2010): 341-359.																			
%
% Known optimal solution:
%   f* = 13.7707622367024
%   x* = 0.959709873845397
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
tol = 1.0e-01;
tspan = [0, 0.78];

% Initial conditions for the ODE system
yo = [0.09, 0.09]';

% Extract the parameter vector 'u' from input 'x'
u = x;

% Set the relative tolerance for the ode45 solver
options = odeset('RelTol', tol);

% Solve the ODE system using ode45 solver
[~, Y] = ode45(@(t, y) Solvethis(t, y, u), tspan, yo, options);

% Calculate the fitness value 'y' based on the solution
y = sum(sum(Y.^2, 2) + (0.1)*(u).*(u));

% Check for NaN value and set a large value if necessary
if isnan(y)
    y = 10^100;
end
end

function xl = get_xl(~)
    xl = 0;
end

function xu = get_xu(~)
    xu = 5;
end

function fmin = get_fmin(~)
    fmin = 13.7707622367024;
end

function xmin = get_xmin(~)
    xmin = 0.959709873845397;
end

function dy = Solvethis(~, x, u)
    dy = zeros(2, 1);
    dy(1) = -(2 + u)*(x(1) + 0.25) + (x(2) + 0.5)*exp(25*x(1)/(x(1) + 2));
    dy(2) = 0.5 - x(2) - (x(2) + 0.5)*exp(25*x(1)/(x(1) + 2));
end
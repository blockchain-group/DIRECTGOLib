function y = Robot_Gripper(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Robot_Gripper.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 2.54378556704650
%   x* = [149.9999999952330;149.8828542479652;199.9999999999659;
%         4.057542871015412e-09;149.9999997047260;100.9427598018905;2.297411715042342];
%
% Problem Properties:
%   n  = 7;
%   #g = 7;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 7;
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
y = -OBJ11(x, 2) - OBJ11(x, 1); tt = imag(y)~=0; y(tt) = 1e4;
end

function [g, ceq] = ConFun(x)
    % Extract the variables from the input vector x
    a = x(1); b = x(2); c = x(3); e = x(4); ff = x(5); l = x(6); delta = x(7);
    
    % Constants and constraints
    Ymin = 50; Ymax = 100; YG = 150; Zmax = 99.9999;
    
    % Compute angles beta_0 and beta_m
    beta_0 = acos((b^2 + l^2 + e^2 - a^2) / (2 * b * sqrt(l^2 + e^2))) - atan(e / l);
    beta_m = acos((b^2 + (l - Zmax)^2 + e^2 - a^2) / (2 * b * sqrt((l - Zmax)^2 + e^2))) - atan(e / (l - Zmax));
    
    % Compute Yxmin and Yxmax
    Yxmin = 2 * (e + ff + c * sin(beta_m + delta));
    Yxmax = 2 * (e + ff + c * sin(beta_0 + delta));
    
    % Inequality constraints
    g(1) = Yxmin - Ymin;     
    g(2) = -Yxmin;          
    g(3) = Ymax - Yxmax;    
    g(4) = Yxmax - YG;      
    g(5) = l^2 + e^2 - (a + b)^2;     
    g(6) = b^2 - (a - e)^2 - (l - Zmax)^2; 
    g(7) = Zmax - l;       
    
    % Handling any imaginary values (invalid constraints)
    tt = imag(g) ~= 0;
    g(tt) = 1e4;
    
    ceq = []; % No equality constraints in this case
end


function xl = get_xl(~)
    xl = [10; 10; 100; 0; 10; 100; 1];
end

function xu = get_xu(~)
    xu = [150; 150; 200; 50; 150; 300; 3.14];
end

function fmin = get_fmin(~)
    fmin = 2.54378556704650;
end

function xmin = get_xmin(~)
    xmin = [149.9999999952330;149.8828542479652;199.9999999999659;4.057542871015412e-09;149.9999997047260;100.9427598018905;2.297411715042342];
end

function ff = OBJ11(x, n)
    % Extract the variables from the input vector x
    a = x(1); b = x(2); c = x(3); e = x(4); l = x(6); Zmax = 99.9999; P = 100;
    
    % Check the value of parameter n to determine the optimization type
    if n == 1
        % Minimization case
        fhd = @(z) P * b * sin(acos((a^2 + (l - z)^2 + e^2 - b^2) / (2 * a * sqrt((l - z)^2 + e^2)))...
            + acos((b^2 + (l - z)^2 + e^2 - a^2) / (2 * b * sqrt((l - z)^2 + e^2)))) / ...
           (2 * c * cos(acos((a^2 + (l - z)^2 + e^2 - b^2) / (2 * a * sqrt((l - z)^2 + e^2))) + atan(e / (l - z))));
    else
        % Maximization case
        fhd = @(z) -(P * b * sin(acos((a^2 + (l - z)^2 + e^2 - b^2) / (2 * a * sqrt((l - z)^2 + e^2)))...
            + acos((b^2 + (l - z)^2 + e^2 - a^2) / (2 * b * sqrt((l - z)^2 + e^2)))) / ...
           (2 * c * cos(acos((a^2 + (l - z)^2 + e^2 - b^2) / (2 * a * sqrt((l - z)^2 + e^2))) + atan(e / (l - z)))));
    end
    
    % Set options for the optimization
    options = optimset('Display', 'off');
    
    % Perform minimization or maximization using fminbnd
    [~, ff] = fminbnd(fhd, 0, Zmax, options);
end
function y = Tension_Compression_SpringC2(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Tension_Compression_SpringC2.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 2.65855916596960
%   x* = [9.03762267857646; 1.22304100996381; 36.1456694801825]
%    
% Problem Properties:
%   n  = 3;
%   #g = 8;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 3;
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
d  = [0.009, 0.0095, 0.0104, 0.0118, 0.0128, 0.0132, 0.014,....
      0.015, 0.0162, 0.0173, 0.018,  0.020,  0.023,  0.025,...
      0.028, 0.032,  0.035,  0.041,  0.047,  0.054,  0.063,....
      0.072, 0.080,  0.092,  0.0105, 0.120,  0.135,  0.148,....
      0.162, 0.177,  0.192,  0.207,  0.225,  0.244,  0.263,....
      0.283, 0.307,  0.331,  0.362,  0.394,  0.4375, 0.500];
x3 = d(max(1, min(42, round(x(3))))); x3 = x3(:); x1 = round(x(1)); x2 = x(2);
y = (pi^2*x2*x3^2*(x1 + 2))/4;
end

function [g, ceq] = ConFun(x)
    % Define the diameter values (d) array
    d = [0.009, 0.0095, 0.0104, 0.0118, 0.0128, 0.0132, 0.014, ...
         0.015, 0.0162, 0.0173, 0.018,  0.020,  0.023,  0.025, ...
         0.028, 0.032,  0.035,  0.041,  0.047,  0.054,  0.063, ...
         0.072, 0.080,  0.092,  0.0105, 0.120,  0.135,  0.148, ...
         0.162, 0.177,  0.192,  0.207,  0.225,  0.244,  0.263, ...
         0.283, 0.307,  0.331,  0.362,  0.394,  0.4375, 0.500];
     
    % Round x(3) to the nearest value in d
    x3 = d(max(1, min(42, round(x(3)))));
    x3 = x3(:); % Ensure x3 is a column vector
    x1 = round(x(1));
    x2 = x(2);
    
    % Calculate constants cf, K, and lf
    cf = (4 * x2 / x3 - 1) / (4 * x2 / x3 - 4) + 0.615 * x3 / x2;
    K = (11.5 * 10^6 * x3^4) / (8 * x1 * x2^3);
    lf = 1000 / K + 1.05 * (x1 + 2) * x3;
    
    % Calculate the value of the design stress sigp
    sigp = 300 / K;
    
    % Set the inequality constraints (g)
    g(1) = (8000 * cf * x2) / (pi * x3^3) - 189000;
    g(2) = lf - 14;
    g(3) = 0.2 - x3;
    g(4) = x2 - 3;
    g(5) = 3 - x2 / x3;
    g(6) = sigp - 6;
    g(7) = sigp + 700 / K + 1.05 * (x1 + 2) * x3 - lf;
    g(8) = 1.25 - 700 / K;
    
    % No equality constraints, set ceq as an empty array
    ceq = [];
end

function xl = get_xl(~)
    xl = [0.51; 0.6; 0.51];
end

function xu = get_xu(~)
    xu = [70.49; 3; 42.49];
end

function fmin = get_fmin(~)
    fmin = 2.65855916596960;
end

function xmin = get_xmin(~)
    xmin = [9.03762267857646; 1.22304100996381; 36.1456694801825];
end
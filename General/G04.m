function y = G04(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G04.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251�256. https://doi.org/c
%
% Globally optimal solution:
%   f* = -30665.538671783317113
%   x* = [78; 33; 29.9952560256815985; 45; 36.7758129057882073]
%
% Default variable bounds:
%   78 <= x(1) <= 102;
%   33 <= x(2) <= 45
%   27 <= x(3) <= 45, i = 3,...n
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
    y.confun = @(i) G04c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 5.3578547*x(3)^2 + 0.8356891*x(1)*x(5) + 37.293239*x(1)-40792.141;  
end

function [c, ceq] = G04c( x )
c(1) = 85.334407 + 0.0056858*x(2)*x(5) + 0.0006262*x(1)*x(4) - 0.0022053*x(3)*x(5) - 92;
c(2) = -85.334407 - 0.0056858*x(2)*x(5) - 0.0006262*x(1)*x(4) + 0.0022053*x(3)*x(5);
c(3) = 80.51249 + 0.0071317*x(2)*x(5) + 0.0029955*x(1)*x(2) + 0.0021813*x(3)^2 - 110;
c(4) = -80.51249 - 0.0071317*x(2)*x(5) - 0.0029955*x(1)*x(2) - 0.0021813*x(3)^2 + 90;
c(5) = 9.300961 + 0.0047026*x(3)*x(5) + 0.0012547*x(1)*x(3) + 0.0019085*x(3)*x(4) - 25;
c(6) = -9.300961 - 0.0047026*x(3)*x(5) - 0.0012547*x(1)*x(3) - 0.0019085*x(3)*x(4) + 20;
ceq = [];
end

function xl = get_xl(~)
    xl = [78; 33; 27; 27; 27];
end

function xu = get_xu(~)
    xu = [102; 45; 45; 45; 45];
end

function fmin = get_fmin(~)
    fmin = -30665.538671783317113;
end

function xmin = get_xmin(~)
    xmin = [78; 33; 29.9952560256815985; 45; 36.7758129057882073];
end
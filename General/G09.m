function y = G09(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G09.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251–256. https://doi.org/c
%
% Globally optimal solution:
%   f* = 680.6300574143741642
%   x* = [2.3304992306299512; 1.9513723940865404; 
%        -0.4775424544823565; 4.3657262070385316; 
%        -0.6244866883631869; 1.0381310307857059; 1.5942267351598556];
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1,...n
%   
% Problem Properties:
%   n  = 7;
%   #g = 4;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 7;
    y.ng = 4;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) G09c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = (x(1) - 10)^2 + 5*(x(2) - 12)^2 + x(3)^4 + 3*(x(4) - 11)^2 +...
    10*x(5)^6 + 7*x(6)^2 + x(7)^4 - 4*x(6)*x(7) - 10*x(6) - 8*x(7);  
end

function [c, ceq] = G09c( x )
c(1) = -127 + 2*x(1)^2 + 3*x(2)^4 + x(3) + 4*x(4)^2 + 5*x(5);
c(2) = -282 + 7*x(1) + 3*x(2) + 10*x(3)^2 + x(4) - x(5);  
c(3) = -196 + 23*x(1) + x(2)^2 + 6*x(6)^2 - 8*x(7);  
c(4) = 4*x(1)^2 + x(2)^2 -3*x(1)*x(2) + 2*x(3)^2 + 5*x(6) - 11*x(7);   
ceq = [];
end

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 680.6300574143741642;
end

function xmin = get_xmin(~)
    xmin = [2.3304992306299512; 1.9513723940865404;...
        -0.4775424544823565; 4.3657262070385316;...
        -0.6244866883631869; 1.0381310307857059; 1.5942267351598556];
end
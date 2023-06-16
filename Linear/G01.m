function y = G01(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G01.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251–256. https://doi.org/c
%
% Globally optimal solution:
%   f* = -15
%   x* = [1; 1; 1; 1; 1; 1; 1; 1; 1; 3; 3; 3; 1]
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,2,3...,9,13
%   0 <= x(10, 11, 12) <= 100;
%   
% Problem Properties:
%   n  = 13;
%   #g = 9;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 13;
    y.ng = 9;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 5*sum(x(1:4)) - 5*sum(x(1:4).^2) - sum(x(5:13));  
end

function [c, ceq] = funcon( x )
    c(1) = 2*x(1) + 2*x(2) + x(10) + x(11) - 10; 
    c(2) = 2*x(1) + 2*x(3) + x(10) + x(12) - 10; 
    c(3) = 2*x(2) + 2*x(3) + x(11) + x(12) - 10;  
    c(4) = -8*x(1) + x(10); 
    c(5) = -8*x(2) + x(11);
    c(6) = -8*x(3) + x(12); 
    c(7) = -2*x(4) - x(5) + x(10);
    c(8) = -2*x(6) - x(7) + x(11);  
    c(9) = -2*x(8) - x(9) + x(12);  
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [ones(9, 1); 100; 100; 100; 1];
end

function fmin = get_fmin(~)
    fmin = -15;
end

function xmin = get_xmin(~)
    xmin = [1; 1; 1; 1; 1; 1; 1; 1; 1; 3; 3; 3; 1];
end
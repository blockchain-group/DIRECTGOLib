function y = G06(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G06.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251–256. https://doi.org/c
%
% Globally optimal solution:
%   f* = -6961.8138751273809248
%   x* = [14.0950000002011322; 0.8429607896175201]
%
% Default variable bounds:
%   13 <= x(1) <= 100;
%   0  <= x(2) <= 100;
%   
% Problem Properties:
%   n  = 2;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) G06c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = (x(1) - 10)^3 + (x(2) - 20)^3;  
end

function [c, ceq] = G06c( x )
c(1) = -(x(1) - 5)^2 - (x(2) - 5)^2 + 100;  
c(2) = (x(1) - 6)^2 + (x(2) - 5)^2 - 82.81;   
ceq=[];
end

function xl = get_xl(~)
    xl = [13; 0];
end

function xu = get_xu(nx)
    xu = 100*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -6961.8138751273809248;
end

function xmin = get_xmin(~)
    xmin = [14.0950000002011322; 0.8429607896175201];
end
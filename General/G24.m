function y = G24(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G24.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251–256. https://doi.org/c
%
% Globally optimal solution:
%   f* = -5.5080124715950696
%   x* = [2.3295202619441824; 3.1784922096508876]
%
% Default variable bounds:
%   0 <= x(1) <= 3;
%   0 <= x(2) <= 4;
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
    y.confun = @(i) G24c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -x(1) - x(2);
end

function [c, ceq] = G24c( x )
c(1) = -2*x(1)^4 + 8*x(1)^3 - 8*x(1)^2 + x(2) - 2;  
c(2) = -4*x(1)^4 + 32*x(1)^3 - 88*x(1)^2 + 96*x(1) + x(2) - 36;  
ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [3; 4];
end

function fmin = get_fmin(~)
    fmin = -5.5080124715950696;
end

function xmin = get_xmin(~)
    xmin = [2.3295202619441824; 3.1784922096508876];
end
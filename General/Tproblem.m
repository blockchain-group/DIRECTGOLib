function y = Tproblem(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Tproblem.m
%
% Original source: 
% - Finkel D. E. (2005). Global Optimization with the DIRECT 
%   Algorithm. Raleigh, North Carolina State University.
%
% Globally optimal solution:
%   f* = -n
%   x(i)* = -1, i = 1,...,n
%
% Default variable bounds:
%   -4 <= x(i) <= 4, i = 1,...,n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) Tproblemc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum(x);
end

function [c, ceq] = Tproblemc( x )
n = length(x);
ff = 0;
for i = 1:n
    ff = ff + x(i)^2;
end
c = ff - n;
ceq = [];
end

function xl = get_xl(nx)
    xl = -4*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 4*ones(nx, 1);
end

function fmin = get_fmin(nx)
    fmin = -nx;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*(-1);
end
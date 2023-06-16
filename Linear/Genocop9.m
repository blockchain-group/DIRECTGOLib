function y = Genocop9(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Genocop9.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -2.47142857142857153
%   x* = [1; 0; 0]
%
% Default variable bounds:
%   0 <= x(1) <= 3, i = 1,...,n
%   
% Problem Properties:
%   n  = 3;
%   #g = 5;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 5;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -((3*x(1) + x(2) - 2*x(3) + 0.8)/(2*x(1) - x(2) + x(3)) + (4*x(1) -...
    2*x(2) + x(3))/(7*x(1) + 3*x(2) - x(3)));
end

function [c, ceq] = funcon(x)
    c(1) = x(1) + x(2) - x(3) - 1; 
    c(2) = -x(1) + x(2) - x(3) + 1; 
    c(3) = 12*x(1) + 5*x(2) + 12*x(2) - 34.8;
    c(4) = 12*x(1) + 12*x(2) + 7*x(3) - 29.1;
    c(5) = -6*x(1) + x(2) + x(3) + 4.1; 
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 3*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -2.47142857142857153;
end

function xmin = get_xmin(~)
    xmin = [1; 0; 0];
end
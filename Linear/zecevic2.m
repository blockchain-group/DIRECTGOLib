function y = zecevic2(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   zecevic2.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -4.1250
%   x* = [1.75; 0.25]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
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
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = 2*x(2)^2 - 2*x(1) - 3*x(2);
end

function [c, ceq] = funcon(x)
    c(1) = x(1) + x(2) - 2;  
    c(2) = x(1) + 4*x(2) - 4; 
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -4.1250;
end

function xmin = get_xmin(~)
    xmin = [1.75; 0.25];
end
function y = Genocop7(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Genocop7.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -413
%   x* = [0; 1; 0; 1; 1; 20]
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,...,5
%   0 <= x(6) <= 100;
%   
% Problem Properties:
%   n  = 6;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
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
y = -10.5*x(1) - 7.5*x(2) - 3.5*x(3) - 2.5*x(4) - 1.5*x(5) - 10*x(6) - 0.5*sum(x.^2);
end

function [c, ceq] = funcon(x)
    c(1) = 6*x(1) + 3*x(2)+3*x(3) + 2*x(4) + x(5) - 6.5;
    c(2) = 10*x(1) + 10*x(3) + x(6) - 20;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [1; 1; 1; 1; 1; 100];
end

function fmin = get_fmin(~)
    fmin = -413;
end

function xmin = get_xmin(~)
    xmin = [0; 1; 0; 1; 1; 20];
end
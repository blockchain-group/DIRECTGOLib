function y = hs038(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs038.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 0
%   x* = [1; 1; 1; 1]
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 4;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = 100*((x(2) - x(1)^2)^2)+ ((1 - x(1))^2) + 90*((x(4) - x(3)^2)^2) +...
    ((1 - x(3))^2) + 10.1*(((x(2) - 1)^2)+ ((x(4) - 1)^2)) +...
    19.8*(x(2) - 1)*(x(4) - 1);
end

function [c, ceq] = funcon( x )
    c(1) = x(1) + 2*x(2) + 2*x(3) - 72;
    c(2) = -x(1) - 2*x(2) - 2*x(3);
    ceq = [];
end

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [1; 1; 1; 1];
end
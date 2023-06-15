function y = Michalewicz1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Michalewicz1.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -1
%   x* = [0.2197; 0]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 2;
%   #g = 3;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 3;
    y.nh = 0;
    y.xl = @(i) 0; 
    y.xu = @(i) 10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
if x(1) < 2
    y = (x(2) + 1e-5*(x(2) - x(1))^2 - 1) ;
else 
    if x(1) < 4
        y = (1/(27*sqrt(3))*((x(1) - 3)^2 - 9)*x(2)^3) ;
    else
        y = (1/3*(x(1) - 2)^3 + x(2) - 11/3);
    end
end
end

function [c, ceq] = funcon( x )
    c(1) = -(x(1)/sqrt(3) - x(2));
    c(2) = -(-x(1) - sqrt(3)*x(2) + 6);
    c(3) = x(1) - 6;
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(~)
    xmin = [0.2197; 0];
end
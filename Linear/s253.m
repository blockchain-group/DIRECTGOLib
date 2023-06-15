function y = s253(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s253.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 120
%   x* = [1.8519; 9.6555; 5.1898]
%
% Default variable bounds:
%   0 <= x(i) <= 100, i = 1,...,n
%   
% Problem Properties:
%   n  = 3;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(i) 0; 
    y.xu = @(i) 100;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
c = ones(1, 8);
a = [0,0,0;10,0,0;10,10,0;0,10,0;0,0,10;10,0,10;10,10,10;0,10,10];
y = 0;
for j = 1:8
    for i = 1:3
        y = y + c(j)*((a(j, i) - x(i))^2)^0.5;
    end
end
end

function [c, ceq] = funcon( x )
    c = -(30 - 3*x(1) - 3*x(3));
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = 120;
end

function xmin = get_xmin(~)
    xmin = [1.8519; 9.6555; 5.1898];
end
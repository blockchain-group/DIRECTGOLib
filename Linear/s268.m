function y = s268(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s268.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 7.0912886041
%   x* = [0.8721195413; 1.7246338259; 0; 1.6196771742; 0.7835694585]
%
% Default variable bounds:
%   0 <= x(i) <= 2, i = 1,...,n
%
% Problem Properties:
%   n  = 5;
%   #g = 5;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 5;
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
D = [-74,80,18,-11,-4;
     14,-69, 21,28,0;
     66,-72,-5,7,1;
     -12,66,-30,-23,3;
     3,8,-7,-4,1;
     4,-12,4,4,0];
d = [51,-61,-56,69,10,-12];
DtD = zeros(5, 5);

for i = 1:5
    for j = 1:5
        for k = 1:6
            DtD(i, j) = DtD(i, j) + D(k, i)*D(k, j);
        end
    end
end

y2 = 0;
for i = 1:5
    y1 = 0;
    for j = 1:5
        y1 = y1 + DtD(i, j)*x(j);
    end
    y2 = y2 + x(i)*y1;
end

y3 = 0;
for i = 1:6
    y1 = 0;
    for j = 1:5
        y1 = y1 + D(i, j)*x(j);
    end
    y3 = y3 + d(i)*y1;
end
y = y2 - 2*y3 + sum(d.^2);
end

function [c, ceq] = funcon( x )
    c(1) = -(-1*x(1) - x(2) - x(3) - x(4) - x(5) + 5);
    c(2) = -(10*x(1) + 10*x(2) - 3*x(3) + 5*x(4) + 4*x(5) - 20);
    c(3) = -(-8*x(1) + x(2) - 2*x(3) - 5*x(4) + 3*x(5) + 40);
    c(4) = -(8*x(1) - x(2) + 2*x(3) + 5*x(4) - 3*x(5) - 11);
    c(5) = -(-4*x(1) - 2*x(2) + 3*x(3) - 5*x(4) + x(5) + 30);
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 2*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 7.0912886041;
end

function xmin = get_xmin(~)
    xmin = [0.8721195413; 1.7246338259; 0; 1.6196771742; 0.7835694585];
end
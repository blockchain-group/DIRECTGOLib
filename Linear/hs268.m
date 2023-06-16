function y = hs268(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs118.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -63126.1111111111
%   x* = [16/9; 29/9; 0; 0; 0]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
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
D = [10197,-12454,-1013,1948,329;
-12454,20909,-1733,-4914,-186;
-1013,-1733,1755,1089,-174;
1948,-4914,1089,1515,-22;
329,-186,-174,-22,27];
B = [-9170, 17099, -2271, -4336, -43];
aa = 0;
for i = 1:5
    for j = 1:5
        y = D(i, j)*x(i)*x(j);
    end
    aa = aa + B(i)*x(i);
end
y = 14463.0 + y -2*aa;
end

function [c, ceq] = funcon( x )
    c(1) =  -(-sum(x) + 5);
    c(2) =  -(10*x(1) + 10*x(2) - 3*x(3) + 5*x(4) + 4*x(5) - 20);
    c(3) =  -(-8*x(1) + x(2) - 2*x(3) - 5*x(4) + 3*x(5) + 40);
    c(4) =  -(8*x(1) - x(2) + 2*x(3) + 5*x(4) - 3*x(5) - 11);
    c(5) =  -(-4*x(1) - 2*x(2) + 3*x(3) - 5*x(4) + x(5) + 30);
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -63126.1111111111;
end

function xmin = get_xmin(~)
    xmin = [16/9; 29/9; 0; 0; 0];
end
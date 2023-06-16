function y = hs086(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs086.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -351.7236428062
%   x* = [0.8660879265; 0.9531960940; 1.1925974938; 0.9005681174; 0.8814168849]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 5;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 1;
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
e = [-15,-27,-36,-18,-12];
d = [4,8,10,6,2];
c = [30,-20,-10,32,-10;
     -20,39,-6,-31,32;
     -10,-6,10,-6,-10;
     32,-31,-6,39,-20;
     -10,32,-10,-20,30;];
y = 0;
for i = 1:5
    for j = 1:5
        y = y + c(j, i)*x(i)*x(j) + (e(j)*x(j)+d(j)*x(j)^3);
    end
end
end

function [c, ceq] = funcon( x )
    a = [-16, 0, -3.5, 0, 0, 2, -1, -1, 1, 1;
         2, -2, 0, -2, -9, 0, -1, -2, 2, 1;
         0, 0, 2, 0, -2, -4, -1, -3, 3, 1;
         1, 4, 0, -4, 1, 0, -1, -2, 4, 1;
         0, 2, 0, -1, -2.8, 0, -1, -1, 5, 1;];
    b = [-40, -2, -0.25, -4, -4, -1, -40, -60, 5, 1];
    c = 0;
    for i = 1:10
        for j = 1:5
            c = c + (-(a(j,  i)*x(j) - b(i)));
        end
    end
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -351.7236428062;
end

function xmin = get_xmin(~)
    xmin = [0.8660879265; 0.9531960940; 1.1925974938; 0.9005681174; 0.8814168849];
end
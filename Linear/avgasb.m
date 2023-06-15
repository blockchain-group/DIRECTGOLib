function y = avgasb(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   avgasb.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -4.4832193647
%   x* = [0.1567940597; 0.8432059402; 0.5314007635; 0.4685992364; 0.5439233126; 0.1248689012; 0.7464026512; 0.0000000000]
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,...,n
%   
% Problem Properties:
%   n  = 8;
%   #g = 10;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 8;
    y.ng = 10;
    y.nh = 0;
    y.xl = @(i) 0; 
    y.xu = @(i) 1;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
a = [2, 2, 2, 2, 2, 2, 2, 2]';
b = [-1, -1, -1, -1, -1, -1, -1];
c = [-2, -2, -1, -3, -2, -4, -3, -5];
t1 = 0; t2 = 0;
for j = 1:7
    t1 = t1 + b(j)*x(j)*x(j + 1);
    t2 = t2 + c(j + 1)*x(j + 1);
end
y = sum(a.*x.^2) + t1 + t2;
end

function [c, ceq] = funcon( x )
    c    = zeros(1, 10);
    c(1) = -(2*x(1) + x(3) - x(7));
    c(2) = -(5*x(1) + 3*x(3) - 3*x(5) - x(7));
    c(3) = -(x(2) - x(4) - 3*x(6) - 5*x(8));
    c(4) = -(x(2) - 3*x(6) - 2*x(8));
    c(5) = x(2*1 - 1) + x(2*1) - 1;
    c(6) = x(2*2 - 1) + x(2*2) - 1;
    c(7) = x(2*3 - 1) + x(2*3) - 1;
    c(8) = x(2*4 - 1) + x(2*4) - 1;
    for i = 1:4
        c(9) = c(9) + x(2*i) - 2;
        c(10) = c(10) + x(2*i - 1) - 2;
    end
    ceq  = [];
end

function fmin = get_fmin(~)
    fmin = -4.4832193647;
end

function xmin = get_xmin(~)
    xmin = [0.1567940597; 0.8432059402; 0.5314007635; 0.4685992364; 0.5439233126; 0.1248689012; 0.7464026512; 0.0000000000];
end
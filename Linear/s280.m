function y = s280(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s280.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 13.3754280635
%   x* = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 10;
%   #g = 10;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 10;
    y.ng = 10;
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
N = 10;
c = zeros(N, 1);
for i = 1:N
    for j = 1:N
        c(i) = c(i) + 1/(i + j - 1);
    end
end
y = sum(c.*x);
end

function [c, ceq] = funcon( x )
    if size(x, 2) > size(x, 1)
        x = x'; 
    end
    N = 10;
    A = zeros(N, N);
    b = zeros(1, N);
    for i = 1:N
        for j = 1:N
            A(i, j) = 1/(i + j - 1);
            b(i) = b(i) + 1/(i + j - 1);
        end
    end
    c(1) = -(sum(A(1, :)*x) - b(1));
    c(2) = -(sum(A(2, :)*x) - b(2));
    c(3) = -(sum(A(3, :)*x) - b(3));
    c(4) = -(sum(A(4, :)*x) - b(4));
    c(5) = -(sum(A(5, :)*x) - b(5));
    c(6) = -(sum(A(6, :)*x) - b(6));
    c(7) = -(sum(A(7, :)*x) - b(7));
    c(8) = -(sum(A(8, :)*x) - b(8));
    c(9) = -(sum(A(9, :)*x) - b(9));
    c(10) = -(sum(A(10, :)*x) - b(10));
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = 13.3754280635;
end

function xmin = get_xmin(~)
    xmin = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
end
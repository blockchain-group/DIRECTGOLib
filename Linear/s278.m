function y = s278(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s278.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 7.8385281385
%   x* = [1; 1; 1; 1; 1; 1]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 6;
%   #g = 6;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
    y.ng = 6;
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
N = 6;
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
    N = 6;
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
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 7.8385281385;
end

function xmin = get_xmin(~)
    xmin = [1; 1; 1; 1; 1; 1];
end
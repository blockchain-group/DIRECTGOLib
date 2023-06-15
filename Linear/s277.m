function y = s277(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s277.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 5.0761904762
%   x* = [1; 1; 1; 1]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 4;
%   #g = 4;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 4;
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
N = 4;
c = zeros(4, 1);
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
    N = 4;
    A = zeros(4, 4);
    b = zeros(1, 4);
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
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = 5.0761904762;
end

function xmin = get_xmin(~)
    xmin = [1; 1; 1; 1];
end
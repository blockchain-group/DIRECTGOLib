function y = Dejong5(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Dejong5.m
%
% Original source:
%  - https://www.sfu.ca/~ssurjano/dejong5.html
%
% Globally optimal solution:
%   f = 0.9980038378 
%   x = [-31.9783323849747; -31.9783354340291]
%
% Default variable bounds:
%   -65.536 <= x(1) <= 65.536
%   -65.536 <= x(2) <= 65.536
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -65.536;
    y.xu = @(i) 65.536;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
A = zeros(2, 25);
a = [-32, -16, 0, 16, 32];
A(1, :) = repmat(a, 1, 5);
ar = repmat(a, 5, 1);
ar = ar(:)';
A(2, :) = ar;
sum = 0;
for ii = 1:25
    a1i = A(1, ii);
    a2i = A(2, ii);
    term1 = ii;
    term2 = (x(1) - a1i)^6;
    term3 = (x(2) - a2i)^6;
    new = 1 / (term1+term2+term3);
    sum = sum + new;
end
y = 1 / (0.002 + sum);
end 

function fmin = get_fmin(~)
    fmin = 0.9980038378;
end

function xmin = get_xmin(~)
    xmin = [-31.9783323849747; -31.9783354340291];
end
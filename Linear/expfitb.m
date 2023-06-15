function y = expfitb(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   expfitb.m
%
% Original source: 
% - M.J.D. Powell, "A tolerant algorithm for linearly constrained 
%   optimization calculations" Mathematical Programming 45(3), 
%   pp.561--562, 1989. 
%
% Globally optimal solution:
%   f* = 0.0860325607
%   x* = [16.9569409911; 13.4556303536; 1.6086432223; 0.6591650197; 0]
%
% Default variable bounds:
%   0 <= x(i) <= 20, i = 1,...,n
%   
% Problem Properties:
%   n  = 5;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(i) 0; 
    y.xu = @(i) 20;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
T  = arrayfun(@(i) 5*(i-1)/(51-1), 1:51)';
ET = arrayfun(@(i) exp(T(i)), 1:51)';
y = sum(arrayfun(@(i) ((x(1) + x(2)*T(i) + x(3)*T(i)^2)/(ET(i)*(1 + x(5)*(T(i) - 5) + x(4)*(T(i) - 5)^2)) -1)^2, 1:51));
end

function [c, ceq] = funcon( x )
    R  = 51;
    T  = arrayfun(@(i) 5*(i-1)/(R-1), 1:R)';
    ET = arrayfun(@(i) exp(T(i)), 1:R)';
    c(1) = sum(arrayfun(@(i) -(x(1)+x(2)*T(i)+x(3)*T(i)^2 - (T(i)-5)*ET(i)*x(5) - (T(i)-5)^2*ET(i)*x(4) -ET(i)), 1:R));
    c(2) = sum(arrayfun(@(i) -((T(i)-5)*x(5) + (T(i)-5)^2*x(4)+0.99999), 1:R));
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = 0.0860325607;
end

function xmin = get_xmin(~)
    xmin = [16.9569409911; 13.4556303536; 1.6086432223; 0.6591650197; 0];
end
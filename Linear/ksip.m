function y = ksip(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   ksip.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 12.1447812954
%   x* = [2.4558088988, 2.9897245538, 2.4610240456, 1.6736853308, 0.9398594388, 0.3535317863, 0, 0, 0, 0]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 10;
%   #g = 20;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 10;
    y.ng = 20;
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
y = 0;
for j = 1:length(x)
    y = y + ( x(j)^2/(2*j) + x(j)/j);
end
end

function [c, ceq] = funcon( x )
    m = 20;
    c = zeros(1, m);
    for i = 1:m
        for j = 1:length(x)
            c(i) = c(i) + (sin(i/m) - (i/m)^(j - 1)*x(j));
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
    fmin = 12.1447812954;
end

function xmin = get_xmin(~)
    xmin = [2.4558088988, 2.9897245538, 2.4610240456, 1.6736853308, 0.9398594388, 0.3535317863, 0, 0, 0, 0];
end
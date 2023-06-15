function y = s354(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s354.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 0.2595909747
%   x* = [0.3619578613; 0; 0.2828240586; 0.3552180801]
%
% Default variable bounds:
%   0 <= x(i) <= 20, i = 1,...,n
%   
% Problem Properties:
%   n  = 4;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 1;
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
y = (x(1) + 10*x(2))^2 + 5*(x(3) - x(4))^2 + (x(2) - 2*x(3))^4 + 10*(x(1) - x(4))^4;
end

function [c, ceq] = funcon( x )
    c = -(x(1) + x(2) + x(3) + x(4) - 1);
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = 0.2595909747;
end

function xmin = get_xmin(~)
    xmin = [0.3619578613; 0; 0.2828240586; 0.3552180801];
end
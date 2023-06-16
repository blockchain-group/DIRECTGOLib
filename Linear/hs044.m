function y = hs044(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs044.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -15
%   x* = [0; 3; 0; 4]
%
% Default variable bounds:
%   0 <= x(i) <= 42, i = 1,...,n
%   
% Problem Properties:
%   n  = 4;
%   #g = 6;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 6;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = x(1) - x(2) - x(3) - x(1)*x(3) + x(1)*x(4) + x(2)*x(3) - x(2)*x(4);
end

function [c, ceq] = funcon( x )
    c(1) = x(1) + 2*x(2) - 8;
    c(2) = 4*x(1) + x(2) - 12;
    c(3) = 3*x(1) + 4*x(2) - 12;
    c(4) = 2*x(3) + x(4) - 8;
    c(5) = x(3) + 2*x(4) - 8;
    c(6) = x(3) + x(4) - 5;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 42*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -15;
end

function xmin = get_xmin(~)
    xmin = [0; 3; 0; 4];
end
function y = biggsc4(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   biggsc4.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -24.5
%   x* = [4; 3.5; 3.5; 3]
%
% Default variable bounds:
%   0 <= x(i) <= 5, i = 1,...,n
%   
% Problem Properties:
%   n  = 4;
%   #g = 13;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 13;
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
y = -x(1)*x(3) - x(2)*x(4);
end

function [c, ceq] = funcon( x )
    c(1)  = -(x(1) + x(2) - 2.5);
    c(2)  = -(x(1) + x(3) - 2.5);
    c(3)  = -(x(1) + x(4) - 2.5);
    c(4)  = -(x(2) + x(3) - 2.0);
    c(5)  = -(x(2) + x(4) - 2.0);
    c(6)  = -(x(3) + x(4) - 1.5);
    c(7)  = x(1) + x(2) - 2.5 - 5.0;
    c(8)  = x(1) + x(3) - 2.5 - 5.0;
    c(9)  = x(1) + x(4) - 2.5 - 5.0;
    c(10) = x(2) + x(3) - 2.0 - 5.0;
    c(11) = x(2) + x(4) - 2.0 - 5.0;
    c(12) = x(3) + x(4) - 1.5 - 5.0;
    c(13) = -(x(1) + x(2) + x(3) + x(4) - 5.0);
    ceq   = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -24.5;
end

function xmin = get_xmin(~)
    xmin = [4; 3.5; 3.5; 3];
end
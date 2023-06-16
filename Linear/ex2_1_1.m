function y = ex2_1_1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   ex2_1_1.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -4525
%   x* = [0; 0; 0; 0; 10]
%
% Default variable bounds:
%   0 <= x(i) <= 20, i = 1,...,n
%   
% Problem Properties:
%   n  = 5;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 1;
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
y = 42*x(1) - 0.5*(100*x(1)^2 + 100*x(2)^2 + 100*x(3)^2 + 100*x(4)^2 + 100*x(5)^2) + 44*x(2) + 45*x(3) + 47*x(4) + 47.5*x(5);
end

function [c, ceq] = funcon( x )
    c = 20*x(1) + 12*x(2) + 11*x(3) + 7*x(4) + 4*x(5) - 40;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 20*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -4525;
end

function xmin = get_xmin(~)
    xmin = [0; 0; 0; 0; 10];
end
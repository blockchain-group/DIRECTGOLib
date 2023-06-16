function y = hs021(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs021.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -99.96
%   x* = [2; 0]
%
% Default variable bounds:
%   2   <= x(1) <= 50;
%   -50 <= x(2) <= 50;
%   
% Problem Properties:
%   n  = 2;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = x(1)^2/100 + x(2)^2 - 100;
end

function [c, ceq] = funcon( x )
    c   = -10*x(1) + x(2) + 10;
    ceq = [];
end

function xl = get_xl(~)
    xl = [2; -50];
end

function xu = get_xu(nx)
    xu = 50*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -99.96;
end

function xmin = get_xmin(~)
    xmin = [2; 0];
end
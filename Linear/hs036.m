function y = hs036(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs036.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -3300
%   x* = [20; 11; 15]
%
% Default variable bounds:
%   0 <= x(1) <= 20;
%   0 <= x(2) <= 11;
%   0 <= x(3) <= 15;
%   
% Problem Properties:
%   n  = 3;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
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
y = -x(1)*x(2)*x(3);
end

function [c, ceq] = funcon( x )
    c   = x(1) + 2*x(2) + 2*x(3) - 72;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [20; 11; 15];
end

function fmin = get_fmin(~)
    fmin = -3300;
end

function xmin = get_xmin(~)
    xmin = [20; 11; 15];
end
function y = hs024(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs024.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -1
%   x* = [3; 1.732050807568876971131999]
%
% Default variable bounds:
%   0 <= x(i) <= 5, i = 1,...,n
%   
% Problem Properties:
%   n  = 2;
%   #g = 3;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 3;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = (((x(1) - 3)^2) - 9)*((x(2)^3)/(27*sqrt(3)));
end

function [c, ceq] = funcon( x )
    c(1) = -x(1)/sqrt(3) + x(2);
    c(2) = -x(1) - sqrt(3)*x(2); 
    c(3) = x(1) + sqrt(3)*x(2) - 6; 
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end


function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(~)
    xmin = [3; 1.732050807568876971131999];
end
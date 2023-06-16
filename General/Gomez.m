function y = Gomez(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Gomez.m
%
% Original source: 
% - Birgin, E. G., Floudas, C. A., Martínez, J. M. :Global minimization 
%   usingan Augmented Lagrangian method with variable lower-level 
%   constraints. Math. Program. Ser. A 125(1), 139–162 (2010)
%
% Globally optimal solution:
%   f* = -0.9714759185876088
%   x* = [0.1092819737821463; -0.6237579513444821]
%
% Default variable bounds:
%   -1 <= x(i) <= 1, i = 1,...n
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
    y.confun = @(i) Gomezc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = (4 - 2.1*x(1)^2 + (x(1)^4)/3)*x(1)^2 + x(1)*x(2) + (-4 +...
    4*x(2)^2)*x(2)^2;
end

function [c, ceq] = Gomezc(x)
c   = -sin(4*3.14*x(1)) + 2*sin(2*3.14*x(2))^2; 
ceq = [];
end

function xl = get_xl(nx)
    xl = -ones(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -0.9714759185876088;
end

function xmin = get_xmin(~)
    xmin = [0.1092819737821463; -0.6237579513444821];
end
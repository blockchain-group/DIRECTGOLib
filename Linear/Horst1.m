function y = Horst1(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Horst1.m
%
% Original source: 
% - Horst, R., Pardalos, P.M., Thoai, N.V. (1995). Introduction to  
%   Global Optimization. Nonconvex Optimization and Its Application. 
%   Kluwer, Dordrecht  
%
% Globally optimal solution:
%   f* = -1.0625
%   x* = [0.75; 2]
%
% Default variable bounds:
%   0 <= x(1) <= 3;
%   0 <= x(2) <= 2;
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
y = -x(1)^2 - 4*x(2)^2 + 4*x(1)*x(2) + 2*x(1) + 4*x(2);
end

function [c, ceq] = funcon( x )
    c(1) = -4*x(1) + 2*x(2) - 1; 
    c(2) = x(1) + x(2) - 4;
    c(3) = x(1) - 4*x(2) - 1;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [3; 2];
end

function fmin = get_fmin(~)
    fmin = -1.0625;
end

function xmin = get_xmin(~)
    xmin = [0.75; 2];
end
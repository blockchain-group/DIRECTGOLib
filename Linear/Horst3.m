function y = Horst3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Horst3.m
%
% Original source: 
% - Horst, R., Pardalos, P.M., Thoai, N.V. (1995). Introduction to  
%   Global Optimization. Nonconvex Optimization and Its Application. 
%   Kluwer, Dordrecht  
%
% Globally optimal solution:
%   f* = -(4/9)
%   x* = [0; 0]
%
% Default variable bounds:
%   0 <= x(1) <= 1;
%   0 <= x(2) <= 1.5;
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
y = -x(1)^2 + (4/3)*x(1) + ((log(1 + x(2)))/(log(exp(1)))) - (4/9);
end

function [c, ceq] = funcon( x )
    c(1) = -2*x(1) + x(2) - 1; 
    c(2) = x(1) + x(2) - (3/2);
    c(3) = x(1) + (1/10)*x(2) - 1;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [1; 1.5];
end

function fmin = get_fmin(~)
    fmin = -(4/9);
end

function xmin = get_xmin(~)
    xmin = [0; 0];
end
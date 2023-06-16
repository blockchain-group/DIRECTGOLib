function y = Horst7(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Horst7.m
%
% Original source: 
% - Horst, R., Pardalos, P.M., Thoai, N.V. (1995). Introduction to  
%   Global Optimization. Nonconvex Optimization and Its Application. 
%   Kluwer, Dordrecht  
%
% Globally optimal solution:
%   f* = -52.8774169979695188
%   x* = [6; 0; 3]
%
% Default variable bounds:
%   0 <= x(1) <= 6;
%   0 <= x(2, 3) <= 3;
%   
% Problem Properties:
%   n  = 3;
%   #g = 4;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 4;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -((x(1) + (1/2)*x(3) - 2)^2) - (abs(x(1) + (1/2)*x(2) +...
    (2/3)*x(3)))^(3/2);
end

function [c,ceq] = funcon( x )
    c(1) = -x(1) - x(2) + (1/2)*x(3) - 1;
    c(2) = x(1) + 2*x(2) - 6;
    c(3) = -2*x(1) - 4*x(2) - 2*x(3) + 1;
    c(4) = x(3) - 3;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [6; 3; 3];
end

function fmin = get_fmin(~)
    fmin = -52.8774169979695188;
end

function xmin = get_xmin(~)
    xmin = [6; 0; 3];
end
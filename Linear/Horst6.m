function y = Horst6(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Horst6.m
%
% Original source: 
% - Horst, R., Pardalos, P.M., Thoai, N.V. (1995). Introduction to  
%   Global Optimization. Nonconvex Optimization and Its Application. 
%   Kluwer, Dordrecht  
%
% Globally optimal solution:
%   f* = -32.5793248372817317
%   x* = [5.2106555627868909; 5.0279; 0]
%
% Default variable bounds:
%   0 <= x(1) <= 6;
%   0 <= x(2) <= 5.0279;
%   0 <= x(3) <= 2.6;
%   
% Problem Properties:
%   n  = 3;
%   #g = 7;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 7;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

Q = [0.992934 -0.640117 0.337286; -0.640117 -0.814622 0.960807;...
    0.337286 0.960807 0.500874];
p = [-0.992372 -0.046466 0.891766];
y = (transpose(x)*Q*x + p*x);
end

function [c,ceq] = funcon( x )
    c(1) = 0.488509*x(1) + 0.063565*x(2) + 0.945686*x(3) - 2.865062;
    c(2) = -0.578592*x(1) - 0.324014*x(2) - 0.501754*x(3) + 1.491608;
    c(3) = -0.719203*x(1) + 0.099562*x(2) + 0.445225*x(3)-0.519588;
    c(4) = -0.346896*x(1) + 0.637939*x(2)-0.257623*x(3) - 1.584087; 
    c(5) = -0.202821*x(1) + 0.647361*x(2) + 0.920135*x(3) - 2.198036;
    c(6) = -0.983091*x(1) - 0.886420*x(2) - 0.802444*x(3) + 1.301853;
    c(7) = -0.305441*x(1) - 0.180123*x(2) - 0.515399*x(3) + 0.738290;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [6; 5.0279; 2.6];
end

function fmin = get_fmin(~)
    fmin = -32.5793248372817317;
end

function xmin = get_xmin(~)
    xmin = [5.2106555627868909; 5.0279; 0];
end
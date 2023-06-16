function y = Goldstein_and_PriceC(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Goldstein_and_PriceC.m
%
% Original source: 
% - Na, J., Lim, Y., & Han, C. (2017). A modified DIRECT algorithm 
%   for hidden constraints in an LNG process optimization. Energy, 
%   126, 488–500. https://doi.org/10.1016/j.energy.2017.03.047  
%
% Globally optimal solution:
%   f* = 3.5389358964718735656163
%   x* = [0.0486962985939948; -0.9846352613587941]
%
% Default variable bounds:
%   -2 <= x(i) <= 2, i = 1,...n
%   
% Problem Properties:
%   n  = 2;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) Goldstein_and_Pricecc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = (1 + (x(1) + x(2) + 1).^2.*(19 - 14.*x(1) + 3.*x(1).^2-14.*x(2) +...
    6.*x(1).*x(2) + 3.*x(2).^2)).*(30 + (2.*x(1) -...
    3.*x(2)).^2.*(18-32.*x(1) + 12.*x(1).^2 + 48.*x(2) - 36.*x(1).*x(2)...
    + 27.*x(2).^2));
end

function [c, ceq] = Goldstein_and_Pricecc( x )
c(1) = -((x(1) - 1)^2) - ((x(2) - 1)^2) + 0.9;
c(2) = -((x(1) + 1)^2) - ((x(2) + 1)^2) + 1.1;
ceq = [];
end

function xl = get_xl(nx)
    xl = -2*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 2*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 3.5389358964718735656163;
end

function xmin = get_xmin(~)
    xmin = [0.0486962985939948; -0.9846352613587941];
end
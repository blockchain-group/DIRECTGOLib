function y = Non_Reg_n3_T100(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Non_Reg_n3_T100.m
%
% Original source: 
% - Gillard, J.W., Kvasov, D.E., 2017. Lipschitz optimization methods for
%   fitting a sum of damped sinusoids to a series of observations. Statistics
%   and its Interface doi:10.4310/SII.2017.v10.n1.a6.. 
%
% Globally optimal solution:
%   f* = 0
%   x* = [-0.2; 0.4; 0.3]
%
% Box constraints:
%   -1 <= x(1) <= 0;
%   0  <= x(2) <= 1;
%   0  <= x(3) <= 1;
%   
% Problem Properties:
%   n  = 3;
%   #g = 0;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum((exp(-0.2*(1:100)).*sin(2*pi*0.4*(1:100) + 0.3) - ...
    exp(x(1)*(1:100)).*sin(2*pi*x(2)*(1:100) + x(3))).^2);
end

function xl = get_xl(~)
    xl = [-1; 0; 0];
end

function xu = get_xu(~)
    xu = [0; 1; 1];
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [-0.2; 0.4; 0.3];
end
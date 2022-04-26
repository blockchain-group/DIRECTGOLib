function y = Non_Reg_n9_T100(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Non_Reg_n9_T100.m
%
% Original source: 
% - Gillard, J.W., Kvasov, D.E., 2017. Lipschitz optimization methods for
%   fitting a sum of damped sinusoids to a series of observations. Statistics
%   and its Interface doi:10.4310/SII.2017.v10.n1.a6.. 
%
% Globally optimal solution:
%   f* = 0
%   x* = - 
%
% Box constraints:
%   -1 <= x(1,4,7) <= 0;
%   0  <= x(2,5,8) <= 1;
%   0  <= x(3,6,9) <= 1;
%   
% Problem Properties:
%   n  = 9;
%   #g = 0;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 9;
    y.ng = 0;
    y.nh = 0;
    bounds = [-1, 0; 0, 1; 0, 1; -1, 0; 0, 1; 0, 1; -1, 0; 0, 1; 0, 1];
    y.xl = @(i) bounds(i, 1);
    y.xu = @(i) bounds(i, 2);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

T = 100; 
zhig_y4 = zeros(1,T);
for j=1:T
  zhig_y4(j) = 1*exp(-0.2*j)*sin(2*pi*0.4*j + 0.3) +...
      1*exp(-0.3*j)*sin(2*pi*0.3*j + 0.1) +...
      1*exp(-0.4*j)*sin(2*pi*0.6*j + 0.2);
end
xt = zeros(1,T);
for j=1:T
   xt(j) = exp(x(1)*j)*sin(2*pi*x(2)*j + x(3)) +...
       exp(x(4)*j)*sin(2*pi*x(5)*j + x(6)) +...
       exp(x(7)*j)*sin(2*pi*x(8)*j + x(9));
end
y = 0.0;
for j=1:T
  zz_temp = (zhig_y4(j) - xt(j))^2;
  y = y + zz_temp;
end
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = [-0.4; 0.6; 0.2; -0.3; 0.3; 0.1; -0.2; 0.4; 0.3];
end
function y = McCormick(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   McCormick.m
%
% Original source:
%  - https://www.sfu.ca/~ssurjano/mccorm.html
%
% Globally optimal solution:
%   f = -1.9132229549810367
%   x = [-0.5471975491332747; -1.5471975514037524]
%
% Default variable bounds:
%   -1.5 <= x(1) <= 4
%   -3 <= x(2) <= 4
%
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    xl = [-1.5; -3];
    y.xl = @(i) xl(i);
    xu = [4; 4];
    y.xu = @(i) xu(i);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

term1 = sin(x(1) + x(2));
term2 = (x(1) - x(2))^2;
term3 = -1.5*x(1);
term4 = 2.5*x(2);
y = term1 + term2 + term3 + term4 + 1;
end

function fmin = get_fmin(~)
    fmin = -1.9132229549810367;
end

function xmin = get_xmin(~)
    xmin = [-0.5471975491332747; -1.5471975514037524];
end
function y = Hump(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hump.m
%
% Original source:
%  - http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page1621.htm
%
% Globally optimal solution:
%   f = -1.0316284534898776
%   x = [-0.0898420093243573; 0.7126564036390750]
%
% Default variable bounds:
%   -5 <= x(i) <= 5, i = 1...2
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
    y.xl = @(i) -5;
    y.xu = @(i) +5;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = 4*x(1)^2 - 2.1*x(1)^4 + x(1)^6/3 + x(1)*x(2) - 4*x(2)^2 + 4*x(2)^4;
end

function fmin = get_fmin(~)
    fmin = -1.0316284534898776;
end

function xmin = get_xmin(~)
    xmin = [-0.0898420093243573; 0.7126564036390750];
end
function y = Shubert(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Shubert.m
%
% Original source:
%  - http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page2530.htm
%
% Globally optimal solution:
%   f = -186.7309088310239247
%   x = (4.8580568801531943, -7.0835064061884561)     
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...2
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
    y.xl = @(i) -10;
    y.xu = @(i) +10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

sum1 = 0; 
sum2 = 0;
for i = 1:5
 sum1 = sum1 + i.*cos((i + 1).*x(1) + i);
 sum2 = sum2 + i.*cos((i + 1).*x(2) + i);
end
y = sum1.*sum2;
end

function fmin = get_fmin(~)
    fmin = -186.7309088310239247;
end

function xmin = get_xmin(~)
    xmin = [4.8580568801531943; -7.0835064061884561];
end
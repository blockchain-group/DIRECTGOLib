function y = hs118(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs118.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 553.9246000000
%   x* = [61.2634789847; 50.9069621822; 82.9752265393; 0; 57; 0; 0; 64; 6; 2; 71; 12; 4; 78; 18]
%
% Default variable bounds:
%   0 <= x(i) <= 100, i = 1,...,n
%   
% Problem Properties:
%   n  = 15;
%   #g = 17;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 15;
    y.ng = 17;
    y.nh = 0;
    y.xl = @(i) 0; 
    y.xu = @(i) 100;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = 0;
for k = 1:4
    y = y + (2.3*x(3*k+1) + 0.0001*x(3*k+1)^2 + 1.7*x(3*k+2) + 0.0001*x(3*k+2)^2 + 2.2*x(3*k+3) + 0.00015*x(3*k+3)^2);
end
end

function [c, ceq] = funcon( x )
    c(1) = x(3*1 + 1) - x(3*1 - 2) + 7 - 13;
    c(2) = x(3*2 + 1) - x(3*2 - 2) + 7 - 13;
    c(3) = x(3*3 + 1) - x(3*3 - 2) + 7 - 13;
    c(4) = x(3*4 + 1) - x(3*4 - 2) + 7 - 13;
    c(5) = x(3*1 + 2) - x(3*1 - 1) + 7 - 14;
    c(6) = x(3*2 + 2) - x(3*2 - 1) + 7 - 14;
    c(7) = x(3*3 + 2) - x(3*3 - 1) + 7 - 14;
    c(8) = x(3*4 + 2) - x(3*4 - 1) + 7 - 14;
    c(9) = x(3*1 + 3) - x(3*1) + 7 - 13;
    c(10) = x(3*2 + 3) - x(3*2) + 7 - 13;
    c(11) = x(3*3 + 3) - x(3*3) + 7 - 13;
    c(12) = x(3*4 + 3) - x(3*4) + 7 - 13;
    c(13) = -x(1) - x(2) - x(3) + 60;
    c(14) = -x(4) - x(5) - x(6) + 50;
    c(15) = -x(7) - x(8) - x(9) + 70;
    c(16) = -x(10) - x(11) - x(12) + 85;
    c(17) = -x(13) - x(14) - x(15) + 100;
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = 553.9246000000;
end

function xmin = get_xmin(~)
    xmin = [61.2634789847; 50.9069621822; 82.9752265393; 0; 57; 0; 0; 64; 6; 2; 71; 12; 4; 78; 18];
end
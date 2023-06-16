function y = s359(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s359.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -563335.5486151027
%   x* = [0.5; 1.2; 10; 4.65; 3.5]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 5;
%   #g = 14;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 14;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
A = [-8720288.849,150512.5253,-156.6950325,476470.3222,729482.8271];
y = -1*sum(A*x - 24345);
end

function [c, ceq] = funcon( x )
    if size(x, 2) > size(x, 1)
        x = x'; 
    end
    B = [-145421.402,2931.1506,-40.427932,5106.192,15711.36];
    C = [-155011.1084,4360.53352,12.9492344,10236.884,13176.786];
    D = [-326669.5104,7390.68412,-27.8986976,16643.076,30988.146];
    c(1) = -(2.4*x(1) - x(2));
    c(2) = -(-1.2*x(1) + x(2));
    c(3) = -(60*x(1) - x(3));
    c(4) = -(-20*x(1) + x(3));
    c(5) = -(9.3*x(1) - x(4));
    c(6) = -(-9.0*x(1) + x(4));
    c(7) = -(7.0*x(1) - x(5));
    c(8) = -(-6.5*x(1) + x(5));
    c(9) = -(sum(B*x));
    c(10) = -(sum(C*x));
    c(11) = -(sum(D*x));
    c(12) = -(-1*sum(B*x) + 294000);
    c(13) = -(-1*sum(C*x) + 294000);
    c(14) = -(-1*sum(D*x) + 294000);
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -563335.5486151027;
end

function xmin = get_xmin(~)
    xmin = [0.5; 1.2; 10; 4.65; 3.5];
end
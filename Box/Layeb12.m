function y = Layeb12(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb12.m
%
% Original source:
%  - abdesslem layeb (2022). New hard benchmark functions for global 
%    optimization (https://www.mathworks.com/matlabcentral/fileexchange/
%    106450-new-hard-benchmark-functions-for-global-optimization), 
%    MATLAB Central File Exchange. Retrieved February 16, 2022.
%
% Globally optimal solution:
%   f = -(exp(1) + 1)*(n - 1)
%   x = 2, i = 1...n
%
% Default variable bounds:
%   -5 <= x(i) <= 5, i = 1...n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
 if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -5;
    y.xu = @(i) 5;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
 end
 if size(x, 2) > size(x, 1)
    x = x'; 
end
cos_rad = @(theta) cosd(theta/pi*180) ;
y = 0;
dim=length(x);
for i = 1:dim - 1
    y = y - ((cos_rad((x(i)*pi/2 - x(i + 1)*pi/4 - pi/2))*...
        exp(cos_rad(2*pi*x(i + 1)*x(i)))) + 1);
end
end 

function fmin = get_fmin(nx)
    fmin = -(exp(1) + 1)*(nx - 1);
end

function xmin = get_xmin(nx)
    xmin = 2*ones(nx, 1);
end
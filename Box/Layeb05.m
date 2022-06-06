function y = Layeb05(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Layeb05.m
%
% Original source:
%  - abdesslem layeb (2022). New hard benchmark functions for global 
%    optimization (https://www.mathworks.com/matlabcentral/fileexchange/
%    106450-new-hard-benchmark-functions-for-global-optimization), 
%    MATLAB Central File Exchange. Retrieved February 16, 2022.
%
% Globally optimal solution:
%   f = (log(0.001) - 1)*(n - 1)
%   x = 2*pi, i = 1...n
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...n
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
    y.xl = @(i) -10;
    y.xu = @(i) 10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
 end
 if size(x, 2) > size(x, 1)
    x = x'; 
end
cos_rad = @(theta) cosd(theta/pi*180);
sin_rad = @(theta) sind(theta/pi*180);
dim = length(x);
y = 0;
for i = 1:dim - 1 
    y = y + (log(abs(sin_rad(x(i) - pi/2) + cos_rad(x(i + 1) - pi)) +...
        0.001))/(abs(cos_rad(2*x(i) - x(i + 1) + pi/2)) + 1); 
end   
end 

function fmin = get_fmin(nx)
    fmin = (log(0.001))*(nx - 1);
end

function xmin = get_xmin(nx)
    xmin = 2*pi*ones(nx, 1);
    for i = 1:nx
        if mod(i, 2) == 0
            xmin(i) = pi;
        end
    end
end  
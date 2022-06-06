function y = Hartman4(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hartman4.m
%
% Original source:
%  - https://www.sfu.ca/~ssurjano/hart4.html
%
% Globally optimal solution:
%   f = -3.1344941412
%   x = [0.187395272127409; 0.194151531890199; 0.557917783679737; 0.264779624074325]
%
% Variable bounds:
%   0 <= x(i) <= 1, i = 1...3
%   
% Problem Properties:
%   n  = 4;
%   #g = 0;
%   #h = 0;
% ------------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -0;
    y.xu = @(i) +1;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
alpha = [1.0, 1.2, 3.0, 3.2]';
A = [10, 3, 17, 3.5, 1.7, 8;
     0.05, 10, 17, 0.1, 8, 14;
     3, 3.5, 1.7, 10, 17, 8;
     17, 8, 0.05, 10, 0.1, 14];
P = 10^(-4) * [1312, 1696, 5569, 124, 8283, 5886;
               2329, 4135, 8307, 3736, 1004, 9991;
               2348, 1451, 3522, 2883, 3047, 6650;
               4047, 8828, 8732, 5743, 1091, 381];

outer = 0;
for ii = 1:4
	inner = 0;
	for jj = 1:4
		xj = x(jj);
		Aij = A(ii, jj);
		Pij = P(ii, jj);
		inner = inner + Aij*(xj-Pij)^2;
	end
	new = alpha(ii) * exp(-inner);
	outer = outer + new;
end
y = (1.1 - outer) / 0.839;
end

function fmin = get_fmin(~)
    fmin = -3.1344941412;
end

function xmin = get_xmin(~)
    xmin = [0.187395272127409; 0.194151531890199; 0.557917783679737; 0.264779624074325];
end
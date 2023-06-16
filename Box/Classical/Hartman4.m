function y = Hartman4(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hartman4.m
%
% References:					
%  - Hedar, A. (2005): Test functions for unconstrained global optimization. 
%    URL: http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO.htm																				
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%
% Globally optimal solution:
%   f = -3.13449414122240010983
%   x = [0.18739527207721953794; 0.19415153036300392131; 
%        0.55791778262575753011; 0.26477962366563889685];
%
% Variable bounds:
%   0 <= x(i) <= 1, i = 1,...,n
%   
% Problem Properties:
%   n  = 4;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% ------------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 0, 0];
    y.libraries = [1, 1, 0, 0, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

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

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -3.13449414122240010983;
end

function xmin = get_xmin(~)
    xmin = [0.18739527207721953794; 0.19415153036300392131; 
            0.55791778262575753011; 0.26477962366563889685];
end
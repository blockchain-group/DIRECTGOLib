function y = Shubert01(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Shubert01.m
%
% References:				
%  - Hedar, A. (2005): Test functions for unconstrained global optimization. 
%    URL: http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO.htm																				
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -186.73090883102392467663
%   x = [-7.08350640751865512357; 4.85805687872907476788]
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-Separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 0, 1];
    y.libraries = [1, 1, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

sum1 = 0; 
sum2 = 0;
for i = 1:5
 sum1 = sum1 + i.*cos((i + 1).*x(1) + i);
 sum2 = sum2 + i.*cos((i + 1).*x(2) + i);
end
y = sum1.*sum2;
end

function xl = get_xl(nx)
    xl = -10*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -186.73090883102392467663;
end

function xmin = get_xmin(~)
    xmin = [-7.08350640751865512357; 4.85805687872907476788];
end
function y = Hartman6(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hartman6.m
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
%   f = -3.32236801141551563177
%   x = [0.20168951105045376804; 0.15001069194240773674; 0.47687397419114102570;
%        0.27533243046651384445; 0.31165161659771911662; 0.65730053409130584363] 
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,...,n
%   
% Problem Properties:
%   n  = 6;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Non-scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 6;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 0, 1, 0, 0, 0, 0];
    y.libraries = [1, 1, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

a(1,1) = 10.0; a(1,2) = 3.0;  a(1,3) = 17.0; a(1,4) = 3.5;  a(1,5) = 1.7;  a(1,6) = 8.0;
a(2,1) = 0.05; a(2,2) = 10.0; a(2,3) = 17.0; a(2,4) = 0.1;  a(2,5) = 8.0;  a(2,6) = 14.0;
a(3,1) = 3.0;  a(3,2) = 3.5;  a(3,3) = 1.7;  a(3,4) = 10.0; a(3,5) = 17.0; a(3,6) = 8.0;
a(4,1) = 17.0; a(4,2) = 8.0;  a(4,3) = 0.05; a(4,4) = 10.0; a(4,5) = 0.1;  a(4,6) = 14.0;
c(1) = 1.0;    c(2) = 1.2;    c(3) = 3.0;    c(4) = 3.2;
p(1,1) = 0.1312; p(1,2) = 0.1696; p(1,3) = 0.5569; p(1,4) = 0.0124;	p(1,5) = 0.8283; p(1,6) = 0.5886;
p(2,1) = 0.2329; p(2,2) = 0.4135; p(2,3) = 0.8307; p(2,4) = 0.3736;	p(2,5) = 0.1004; p(2,6) = 0.9991;
p(3,1) = 0.2348; p(3,2) = 0.1451; p(3,3) = 0.3522; p(3,4) = 0.2883;	p(3,5) = 0.3047; p(3,6) = 0.6650;
p(4,1) = 0.4047; p(4,2) = 0.8828; p(4,3) = 0.8732; p(4,4) = 0.5743;	p(4,5) = 0.1091; p(4,6) = 0.0381;
s = 0;
for i = 1:4
   sm=0;
   for j = 1:6
      sm = sm + a(i, j)*(x(j) - p(i, j))^2;
   end
   s = s + c(i)*exp(-sm);
end
y = -s;
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -3.32236801141551563177;
end

function xmin = get_xmin(~)
    xmin = [0.20168951105045376804; 0.15001069194240773674; 0.47687397419114102570;...
            0.27533243046651384445; 0.31165161659771911662; 0.65730053409130584363];
end
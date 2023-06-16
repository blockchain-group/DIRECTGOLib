function y = Michalewicz(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Michalewicz.m
%
% References:				
%  - Hedar, A. (2005): Test functions for unconstrained global optimization. 
%    URL: http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO.htm																				
%  - Surjanovic, S., Bingham, D. (2013): Virtual library of simulation 
%    experiments: Test functions and datasets. 
%    URL: http://www.sfu.ca/~ssurjano/index.html	
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%
% Globally optimal solution:
%   f = Depends on dimension n
%   x = Depends on dimension n
%
% Default variable bounds:
%   0 <= x(i) <= pi, i = 1,...,n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 1, 1, 1, 0, 0, 0, 0];
    y.libraries = [1, 1, 0, 1, 0, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

n = length(x);
m = 10;
s = 0;
for i = 1:n
    s = s + sin(x(i))*(sin(i*x(i)^2/pi))^(2*m);
end
y = -s;
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = pi*ones(nx, 1);
end

function fmin = get_fmin(nx)
    fmin = michalewicz_minimum(nx);
end

function xmin = get_xmin(nx)
xmin = zeros(nx, 1);
for i = 1:nx
    xmin(i) = michalewicz_xmin(i);
end
end

%--------------------------------------------------------------------------
% Compute numerically the minimum of the Michalewicz function for a given
% dimension.
%--------------------------------------------------------------------------
function fmin = michalewicz_minimum(dim)
    fmin = 0;
    xmin = zeros(1,dim);
% compute the minimum for each dimension
    for d = 1:dim
% compute the location of the peak, which is very close to the minimum
        n = round(0.25*d -0.5);
        fraction = sqrt((2*n+1)/(2*d));
        
% if the fraction equals 0.5, the peak is located at the minimum.
        if fraction == 0.5
            fmin = fmin  + -1;
            xmin(d) = 0.5*pi;
            continue;
        end
        
% determine the search domain for ternary search
        if (fraction < 0.5)
            x0 = fraction*pi;
            x3 = 0.5*pi;
        else
            x0 = 0.5*pi;
            x3 = fraction*pi;
        end
        
% ternary search
        while(abs(x3-x0) > 1e-14)
            x1 = x0+(x3-x0)/3;
            f1 = -sin(x1).*(sin(d*x1.^2/pi).^20);
            
            x2 = x3-(x3-x0)/3;
            f2 = -sin(x2).*(sin(d*x2.^2/pi).^20);
            
            % update the search range
            if( f2 < f1 )
                x0 = x1;
            else
                x3 = x2;
            end
        end
        
        % update the values of the minimum
        xmin(d) = (x3+x0)/2;
        f = -sin(xmin(d)).*(sin(d*xmin(d).^2/pi).^20);
        fmin = fmin + f;
    end
end  
%--------------------------------------------------------------------------
% Compute numerically the minimum of the Michalewicz function for a given
% dimension.
%--------------------------------------------------------------------------
function xmin = michalewicz_xmin(dim)
    fmin = 0;
    xmin = zeros(1,dim);
% compute the minimum for each dimension
    for d = 1:dim
% compute the location of the peak, which is very close to the minimum
        n = round(0.25*d -0.5);
        fraction = sqrt((2*n+1)/(2*d));
        
% if the fraction equals 0.5, the peak is located at the minimum.
        if fraction == 0.5
            fmin = fmin  + -1;
            xmin(d) = 0.5*pi;
            continue;
        end
        
% determine the search domain for ternary search
        if (fraction < 0.5)
            x0 = fraction*pi;
            x3 = 0.5*pi;
        else
            x0 = 0.5*pi;
            x3 = fraction*pi;
        end
        
% ternary search
        while(abs(x3-x0) > 1e-14)
            x1 = x0+(x3-x0)/3;
            f1 = -sin(x1).*(sin(d*x1.^2/pi).^20);
            
            x2 = x3-(x3-x0)/3;
            f2 = -sin(x2).*(sin(d*x2.^2/pi).^20);
            
            % update the search range
            if( f2 < f1 )
                x0 = x1;
            else
                x3 = x2;
            end
        end
        
        % update the values of the minimum
        xmin(d) = (x3+x0)/2;
        f = -sin(xmin(d)).*(sin(d*xmin(d).^2/pi).^20);
        fmin = fmin + f;
    end
    xmin = xmin(dim);
end  
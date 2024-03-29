function y = G16(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G16.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251�256. https://doi.org/c
%
% Globally optimal solution:
%   f* = -1.9051548363831916
%   x* = [705.1745677092834512; 68.6000040237833986;
%         102.9000008427522346; 282.3249302342787246; 
%         37.5836012630766021];
%
% Default variable bounds:
%   704.4148 <= x(1) <= 906.3855;
%   68.6     <= x(2) <= 288.88;
%   0        <= x(3) <= 134.75;
%   193      <= x(4) <= 287.0966;
%   25       <= x(5) <= 84.1988;
%   
% Problem Properties:
%   n  = 5;
%   #g = 38;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 38;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) G16c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y1 = (x(2) + x(3) + 41.6);
c1 = (0.024*x(4) - 4.62);
y2 = ((12.5/(c1)) + 12);
c2 = (0.0003535*(x(1)^2) + 0.5311*x(1) + 0.08705*(y2)*x(1));
c3 = (0.052*x(1) + 78 + 0.002377*(y2)*x(1));
y3 = ((c2)/(c3));
y4 = (19*(y3));
c4 = (0.04782*(x(1) - (y3)) + ((0.1956*(x(1) - (y3))^2)/x(2)) + 0.6376*(y4) + 1.594*(y3));
c5 = (100*x(2));
c6 = (x(1) - (y3) - (y4));
c7 = (0.950 - ((c4)/(c5)));
y5 = ((c6)*(c7));
y6 = (x(1) - (y5) - (y4) - (y3));
c8 = (((y5) + (y4))*0.995);
y7 = ((c8)/(y1));
y8 = ((c8)/(3798));
c9 = ((y7) - ((0.0663*(y7))/(y8)) - 0.3153);
y9 = ((96.82/(c9)) + 0.321*(y1));
y10 = (1.29*(y5) + 1.258*(y4) + 2.29*(y3) + 1.71*(y6));
y11 = (1.71*(x(1)) - 0.452*(y4) + 0.580*(y3));
c10 = (12.3/752.3);
c11 = ((1.75*(y2))*(0.995*(x(1))));
c12 = (0.995*(y10) + 1998);
y12 = ((c10)*x(1) + (c11)/(c12));
y13 = ((c12) - 1.75*(y2));
y14 = (3623 + 64.4*(x(2)) + 58.4*x(3) + (146312/((y9) + x(5))));
c13 = (0.995*(y10) + 60.8*x(2) + 48*x(4) - 0.1121*(y14) - 5095);
y15 = ((y13)/(c13));
y16 = (148000 - 331000*(y15) + 40*(y13) - 61*(y15)*(y13));
c14 = (2324*(y10) - 28740000*(y2));
y17 = (14130000 - 1328*(y10) - 531*(y11) + ((c14)/(c12)));
c15 = (((y13)/(y15)) - ((y13)/0.52));
c16 = (1.104 - 0.72*(y15));
c17 = ((y9) + x(5)); 
y = 0.000117*(y14) + 0.1365 + 0.00002358*(y13) + 0.000001502*(y16) + 0.0321*(y12) + 0.004324*(y5) + 0.0001*((c15)/(c16)) + 37.48*((y2)/(c12)) - 0.0000005843*(y17);
end

function xl = get_xl(~)
    xl = [704.4148; 68.6; 0; 193; 25];
end

function xu = get_xu(~)
    xu = [906.3855; 288.88; 134.75; 287.0966; 84.1988];
end

function [c, ceq] = G16c( x )
y1 = (x(2) + x(3) + 41.6);
c1 = (0.024*x(4) - 4.62);
y2 = ((12.5/(c1)) + 12);
c2 = (0.0003535*(x(1)^2) + 0.5311*x(1) + 0.08705*(y2)*x(1));
c3 = (0.052*x(1) + 78 + 0.002377*(y2)*x(1));
y3 = ((c2)/(c3));
y4 = (19*(y3));
c4 = (0.04782*(x(1) - (y3)) + ((0.1956*(x(1) - (y3))^2)/x(2)) + 0.6376*(y4) + 1.594*(y3));
c5 = (100*x(2));
c6 = (x(1) - (y3) - (y4));
c7 = (0.950 - ((c4)/(c5)));
y5 = ((c6)*(c7));
y6 = (x(1) - (y5) - (y4) - (y3));
c8 = (((y5) + (y4))*0.995);
y7 = ((c8)/(y1));
y8 = ((c8)/(3798));
c9 = ((y7) - ((0.0663*(y7))/(y8)) - 0.3153);
y9 = ((96.82/(c9)) + 0.321*(y1));
y10 = (1.29*(y5) + 1.258*(y4) + 2.29*(y3) + 1.71*(y6));
y11 = (1.71*(x(1)) - 0.452*(y4) + 0.580*(y3));
c10 = (12.3/752.3);
c11 = ((1.75*(y2))*(0.995*(x(1))));
c12 = (0.995*(y10) + 1998);
y12 = ((c10)*x(1) + (c11)/(c12));
y13 = ((c12) - 1.75*(y2));
y14 = (3623 + 64.4*(x(2)) + 58.4*x(3) + (146312/((y9) + x(5))));
c13 = (0.995*(y10) + 60.8*x(2) + 48*x(4) - 0.1121*(y14) - 5095);
y15 = ((y13)/(c13));
y16 = (148000 - 331000*(y15) + 40*(y13) - 61*(y15)*(y13));
c14 = (2324*(y10) - 28740000*(y2));
y17 = (14130000 - 1328*(y10) - 531*(y11) + ((c14)/(c12)));
c15 = (((y13)/(y15)) - ((y13)/0.52));
c16 = (1.104 - 0.72*(y15));
c17 = ((y9) + x(5)); 
c(1) = (0.28/0.72)*(y5) - (y4);
c(2) = x(3) - 1.5*x(2);  
c(3) = 3496*((y2)/(c12)) - 21;   
c(4) = 110.6 + y1 - (62212/c17) ;  
c(5) = 213.1 - y1 ; 
c(6) = y1 - 405.23;  
c(7) = 17.505 - y2 ; 
c(8) = y2 - 1053.6667;  
c(9) = 11.275 - y3 ;
c(10) = y3 - 35.03;
c(11) = 214.228 - y4 ; 
c(12) = y4 - 665.585;   
c(13) = 7.458 - y5 ;    
c(14) = y5 - 584.463;   
c(15) = 0.961 - y6 ; 
c(16) = y6 - 265.916;   
c(17) = 1.612 - y7 ;  
c(18) = y7 - 7.046;   
c(19) = 0.146 - y8; 
c(20) = y8 - 0.222; 
c(21) = 107.99 - y9 ; 
c(22) = y9 - 273.366;  
c(23) = 922.693 - y10 ;   
c(24) = y10 - 1286.105;  
c(25) = 926.832 - y11 ;  
c(26) = y11 - 1444.046;   
c(27) = 18.766 - y12 ; 
c(28) = y12 - 537.141;   
c(29) = 1072.163 - y13 ; 
c(30) = y13 - 3247.039; 
c(31) = 8961.448 - y14 ; 
c(32) = y14 - 26844.086; 
c(33) = 0.063 - y15 ;   
c(34) = y15 - 0.386;  
c(35) = 71084.33 - y16 ; 
c(36) = -140000 + y16  ;  
c(37) = 2802713 - y17 ; 
c(38) = y17 - 12146108;  
ceq = [];
end

function fmin = get_fmin(~)
    fmin = -1.9051548363831916;
end

function xmin = get_xmin(~)
    xmin = [705.1745677092834512; 68.6000040237833986;...
        102.9000008427522346; 282.3249302342787246; 37.5836012630766021];
end
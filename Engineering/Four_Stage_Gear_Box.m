function y = Four_Stage_Gear_Box(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Four_Stage_Gear_Box.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 35.3676905240189
%   x* = [18.0960498862046;36.4766831198579;20.6565107103415;44.7541124875989;
%         22.2091334494337;47.3638340910337;20.0457299336354;42.8390805938834;
%         0.629265314657840;0.914346638366681;0.851024779664636;0.624768157011791;
%         6.65622896462916;3.96590851684381;4.18932703903823;3.77188137188885;
%         4.05378642726586;4.03536875257909;4.17919123945762;5.13023554731496;
%         5.46107054974288;5.48799078695515];
%    
% Problem Properties:
%   n  = 22;
%   #g = 86;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 22;
    y.ng = 86;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) confun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
x = round(x);
Np1 = x(1); Ng1 = x(2); Np2 = x(3); Ng2 = x(4);
Np3 = x(5); Ng3 = x(6); Np4 = x(7); Ng4 = x(8);
Pvalue = [ 3.175, 5.715, 8.255, 12.7];
b1 = Pvalue(x(9))'; b2 = Pvalue(x(10))'; b3 = Pvalue(x(11))';
b4 = Pvalue(x(12))';
XYvalue = [ 12.7,25.4,38.1,50.8,63.5,76.2,88.9,101.6,114.3];
xp1 = XYvalue(x(13))'; xg1 = XYvalue(x(14))';
xg2 = XYvalue(x(15))'; xg3 = XYvalue(x(16))';
xg4 = XYvalue(x(17))'; yp1 = XYvalue(x(18))';
yg1 = XYvalue(x(19))'; yg2 = XYvalue(x(20))';
yg3 = XYvalue(x(21))'; yg4 = XYvalue(x(22))';
c1 = sqrt((xg1 - xp1)^2 + (yg1 - yp1)^2);
c2 = sqrt((xg2 - xp1)^2 + (yg2 - yp1)^2);
c3 = sqrt((xg3 - xp1)^2 + (yg3 - yp1)^2);
c4 = sqrt((xg4 - xp1)^2 + (yg4 - yp1)^2);
y = pi/1000*(b1*c1^2*(Np1^2 + Ng1^2)/(Np1 + Ng1)^2 + b2*c2^2*(Np2^2 + Ng2^2)/(Np2 + Ng2)^2 ...
    + b3*c3^2*(Np3^2 + Ng3^2)/(Np3 + Ng3)^2 + b4*c4^2*(Np4^2 + Ng4^2)/(Np4 + Ng4)^2);
end

function [g, ceq] = confun( x )
    x = round(x);
    Np1 = x(1); Ng1 = x(2); Np2 = x(3); Ng2 = x(4);
    Np3 = x(5); Ng3 = x(6); Np4 = x(7); Ng4 = x(8);
    Pvalue = [ 3.175, 5.715, 8.255, 12.7];
    b1 = Pvalue(x(9))'; b2 = Pvalue(x(10))'; b3 = Pvalue(x(11))';
    b4 = Pvalue(x(12))';
    XYvalue = [12.7, 25.4, 38.1, 50.8, 63.5, 76.2, 88.9, 101.6, 114.3];
    xp1 = XYvalue(x(13))'; xg1 = XYvalue(x(14))';
    xg2 = XYvalue(x(15))'; xg3 = XYvalue(x(16))';
    xg4 = XYvalue(x(17))'; yp1 = XYvalue(x(18))';
    yg1 = XYvalue(x(19))'; yg2 = XYvalue(x(20))';
    yg3 = XYvalue(x(21))'; yg4 = XYvalue(x(22))';
    c1 = sqrt((xg1 - xp1)^2 + (yg1 - yp1)^2);
    c2 = sqrt((xg2 - xp1)^2 + (yg2 - yp1)^2);
    c3 = sqrt((xg3 - xp1)^2 + (yg3 - yp1)^2);
    c4 = sqrt((xg4 - xp1)^2 + (yg4 - yp1)^2);
    CRmin = 1.4; dmin = 25.4; phi = 20*pi/180; W = 55.9; JR = 0.2; Km = 1.6; Ko = 1.5; Lmax = 127;
    sigma_H = 3290; sigma_N = 2090; w1 = 5000; wmin = 245; wmax = 255; Cp = 464;
    g(1) = (366000/(pi*w1) + 2*c1*Np1/(Np1 + Ng1))*((Np1 + Ng1)^2/(4*b1*c1^2*Np1)) - sigma_N*JR/(0.0167*W*Ko*Km);
    g(2) = (366000*Ng1/(pi*w1*Np1) + 2*c2*Np2/(Np2 + Ng2))*((Np2 + Ng2)^2/(4*b2*c2^2*Np2)) - sigma_N*JR/(0.0167*W*Ko*Km);
    g(3) = (366000*Ng1*Ng2/(pi*w1*Np1*Np2) + 2*c3*Np3/(Np3 + Ng3))*((Np3 + Ng3)^2/(4*b3*c3^2*Np3)) - sigma_N*JR/(0.0167*W*Ko*Km);
    g(4) = (366000*Ng1*Ng2*Ng3/(pi*w1*Np1*Np2*Np3) + 2*c4*Np4/(Np4 + Ng4))*((Np4 + Ng4)^2/(4*b4*c4^2*Np4)) - sigma_N*JR/(0.0167*W*Ko*Km);
    g(5) = (366000/(pi*w1) + 2*c1*Np1/(Np1 + Ng1))*((Np1 + Ng1)^3/(4*b1*c1^2*Ng1*Np1^2)) - (sigma_H/Cp)^2*(sin(phi)*cos(phi))/(0.0334*W*Ko*Km);
    g(6) = (366000*Ng1/(pi*w1*Np1) + 2*c2*Np2/(Np2 + Ng2))*((Np2 + Ng2)^3/(4*b2*c2^2*Ng2*Np2^2)) - (sigma_H/Cp)^2*(sin(phi)*cos(phi))/(0.0334*W*Ko*Km);
    g(7) = (366000*Ng1*Ng2/(pi*w1*Np1*Np2) + 2*c3*Np3/(Np3 + Ng3))*((Np3 + Ng3)^3/(4*b3*c3^2*Ng3*Np3^2)) - (sigma_H/Cp)^2*(sin(phi)*cos(phi))/(0.0334*W*Ko*Km);
    g(8) = (366000*Ng1*Ng2*Ng3/(pi*w1*Np1*Np2*Np3) + 2*c4*Np4/(Np4 + Ng4))*((Np4 + Ng4)^3/(4*b4*c4^2*Ng4*Np4^2)) - (sigma_H/Cp)^2*(sin(phi)*cos(phi))/(0.0334*W*Ko*Km);
    g(9) = CRmin*pi*cos(phi) - Np1*sqrt(sin(phi)^2/4 + 1/Np1 + (1/Np1)^2) - Ng1*sqrt(sin(phi)^2/4 + 1/Ng1 + (1/Ng1)^2) + sin(phi)*(Np1 + Ng1)/2;
    g(10) = CRmin*pi*cos(phi) - Np2*sqrt(sin(phi)^2/4 + 1/Np2 + (1/Np2)^2) - Ng2*sqrt(sin(phi)^2/4 + 1/Ng2 + (1/Ng2)^2) + sin(phi)*(Np2 + Ng2)/2;
    g(11) = CRmin*pi*cos(phi) - Np3*sqrt(sin(phi)^2/4 + 1/Np3 + (1/Np3)^2) - Ng3*sqrt(sin(phi)^2/4 + 1/Ng3 + (1/Ng3)^2) + sin(phi)*(Np3 + Ng3)/2;
    g(12) = CRmin*pi*cos(phi) - Np4*sqrt(sin(phi)^2/4 + 1/Np4 + (1/Np4)^2) - Ng4*sqrt(sin(phi)^2/4 + 1/Ng4 + (1/Ng4)^2) + sin(phi)*(Np4 + Ng4)/2;
    g(13) = dmin - 2*c1*Np1/(Np1 + Ng1);
    g(14) = dmin - 2*c2*Np2/(Np2 + Ng2);
    g(15) = dmin - 2*c3*Np3/(Np3 + Ng3);
    g(16) = dmin - 2*c4*Np4/(Np4 + Ng4);
    g(17) = dmin - 2*c1*Ng1/(Np1 + Ng1);
    g(18) = dmin - 2*c2*Ng2/(Np2 + Ng2);
    g(19) = dmin - 2*c3*Ng3/(Np3 + Ng3);
    g(20) = dmin - 2*c4*Ng4/(Np4 + Ng4);
    g(21) = xp1 + ((Np1 + 2)*c1/(Np1 + Ng1)) - Lmax;
    g(22) = xg2 + ((Np2 + 2)*c2/(Np2 + Ng2)) - Lmax;
    g(23) = xg3 + ((Np3 + 2)*c3/(Np3 + Ng3)) - Lmax;
    g(24) = xg4 + ((Np4 + 2)*c4/(Np4 + Ng4)) - Lmax;
    g(25) = -xp1 + ((Np1 + 2)*c1/(Np1 + Ng1));
    g(26) = -xg2 + ((Np2 + 2)*c2/(Np2 + Ng2));
    g(27) = -xg3 + ((Np3 + 2)*c3/(Np3 + Ng3));
    g(28) = -xg4 + ((Np4 + 2)*c4/(Np4 + Ng4));
    g(29) = yp1 + ((Np1 + 2)*c1/(Np1 + Ng1)) - Lmax;
    g(30) = yg2 + ((Np2 + 2)*c2/(Np2 + Ng2)) - Lmax;
    g(31) = yg3 + ((Np3 + 2)*c3/(Np3 + Ng3)) - Lmax;
    g(32) = yg4 + ((Np4 + 2)*c4/(Np4 + Ng4)) - Lmax;
    g(33) = -yp1 + ((Np1 + 2)*c1/(Np1 + Ng1));
    g(34) = -yg2 + ((Np2 + 2)*c2/(Np2 + Ng2));
    g(35) = -yg3 + ((Np3 + 2)*c3/(Np3 + Ng3));
    g(36) = -yg4 + ((Np4 + 2)*c4/(Np4 + Ng4));
    g(37) = xg1 + ((Ng1 + 2)*c1/(Np1 + Ng1)) - Lmax;
    g(38) = xg2 + ((Ng2 + 2)*c2/(Np2 + Ng2)) - Lmax;
    g(39) = xg3 + ((Ng3 + 2)*c3/(Np3 + Ng3)) - Lmax;
    g(40) = xg4 + ((Ng4 + 2)*c4/(Np4 + Ng4)) - Lmax;
    g(41) = -xg1 + ((Ng1 + 2)*c1/(Np1 + Ng1));
    g(42) = -xg2 + ((Ng2 + 2)*c2/(Np2 + Ng2));
    g(43) = -xg3 + ((Ng3 + 2)*c3/(Np3 + Ng3));
    g(44) = -xg4 + ((Ng4 + 2)*c4/(Np4 + Ng4));
    g(45) = yg1 + ((Ng1 + 2)*c1/(Np1 + Ng1)) - Lmax;
    g(46) = yg2 + ((Ng2 + 2)*c2/(Np2 + Ng2)) - Lmax;
    g(47) = yg3 + ((Ng3 + 2)*c3/(Np3 + Ng3)) - Lmax;
    g(48) = yg4 + ((Ng4 + 2)*c4/(Np4 + Ng4)) - Lmax;
    g(49) = -yg1 + ((Ng1 + 2)*c1/(Np1 + Ng1));
    g(50) = -yg2 + ((Ng2 + 2)*c2/(Np2 + Ng2));
    g(51) = -yg3 + ((Ng3 + 2)*c3/(Np3 + Ng3));
    g(52) = -yg4 + ((Ng4 + 2)*c4/(Np4 + Ng4));
    g(53) = (0.945*c1 - Np1 - Ng1)*(b1 - 5.715)*(b1 - 8.255)*(b1 - 12.70)*(-1);
    g(54) = (0.945*c2 - Np2 - Ng2)*(b2 - 5.715)*(b2 - 8.255)*(b2 - 12.70)*(-1);
    g(55) = (0.945*c3 - Np3 - Ng3)*(b3 - 5.715)*(b3 - 8.255)*(b3 - 12.70)*(-1);
    g(56) = (0.945*c4 - Np4 - Ng4)*(b4 - 5.715)*(b4 - 8.255)*(b4 - 12.70)*(-1);
    g(57) = (0.646*c1 - Np1 - Ng1)*(b1 - 3.175)*(b1 - 8.255)*(b1 - 12.70)*(+1);
    g(58) = (0.646*c2 - Np2 - Ng2)*(b2 - 3.175)*(b2 - 8.255)*(b2 - 12.70)*(+1);
    g(59) = (0.646*c3 - Np3 - Ng3)*(b3 - 3.175)*(b3 - 8.255)*(b3 - 12.70)*(+1);
    g(60) = (0.646*c4 - Np4 - Ng4)*(b4 - 3.175)*(b4 - 8.255)*(b4 - 12.70)*(+1);
    g(61) = (0.504*c1 - Np1 - Ng1)*(b1 - 3.175)*(b1 - 5.715)*(b1 - 12.70)*(-1);
    g(62) = (0.504*c2 - Np2 - Ng2)*(b2 - 3.175)*(b2 - 5.715)*(b2 - 12.70)*(-1);
    g(63) = (0.504*c3 - Np3 - Ng3)*(b3 - 3.175)*(b3 - 5.715)*(b3 - 12.70)*(-1);
    g(64) = (0.504*c4 - Np4 - Ng4)*(b4 - 3.175)*(b4 - 5.715)*(b4 - 12.70)*(-1);
    g(65) = (0.0*c1 - Np1 - Ng1)*(b1 - 3.175)*(b1 - 5.715)*(b1 - 8.255)*(+1);
    g(66) = (0.0*c2 - Np2 - Ng2)*(b2 - 3.175)*(b2 - 5.715)*(b2 - 8.255)*(+1);
    g(67) = (0.0*c3 - Np3 - Ng3)*(b3 - 3.175)*(b3 - 5.715)*(b3 - 8.255)*(+1);
    g(68) = (0.0*c4 - Np4 - Ng4)*(b4 - 3.175)*(b4 - 5.715)*(b4 - 8.255)*(+1);
    g(69) = (-1.812*c1 + Np1 + Ng1)*(b1 - 5.715)*(b1 - 8.255)*(b1 - 12.70)*(-1);
    g(70) = (-1.812*c2 + Np2 + Ng2)*(b2 - 5.715)*(b2 - 8.255)*(b2 - 12.70)*(-1);
    g(71) = (-1.812*c3 + Np3 + Ng3)*(b3 - 5.715)*(b3 - 8.255)*(b3 - 12.70)*(-1);
    g(72) = (-1.812*c4 + Np4 + Ng4)*(b4 - 5.715)*(b4 - 8.255)*(b4 - 12.70)*(-1);
    g(73) = (-0.945*c1 + Np1 + Ng1)*(b1 - 3.175)*(b1 - 8.255)*(b1 - 12.70)*(+1);
    g(74) = (-0.945*c2 + Np2 + Ng2)*(b2 - 3.175)*(b2 - 8.255)*(b2 - 12.70)*(+1);
    g(75) = (-0.945*c3 + Np3 + Ng3)*(b3 - 3.175)*(b3 - 8.255)*(b3 - 12.70)*(+1);
    g(76) = (-0.945*c4 + Np4 + Ng4)*(b4 - 3.175)*(b4 - 8.255)*(b4 - 12.70)*(+1);
    g(77) = (-0.646*c1 + Np1 + Ng1)*(b1 - 3.175)*(b1 - 5.715)*(b1 - 12.70)*(-1);
    g(78) = (-0.646*c2 + Np2 + Ng2)*(b2 - 3.175)*(b2 - 5.715)*(b2 - 12.70)*(-1);
    g(79) = (-0.646*c3 + Np2 + Ng3)*(b3 - 3.175)*(b3 - 5.715)*(b3 - 12.70)*(-1);
    g(80) = (-0.646*c4 + Np3 + Ng4)*(b4 - 3.175)*(b4 - 5.715)*(b4 - 12.70)*(-1);
    g(81) = (-0.504*c1 + Np1 + Ng1)*(b1 - 3.175)*(b1 - 5.715)*(b1 - 8.255)*(+1);
    g(82) = (-0.504*c2 + Np2 + Ng2)*(b2 - 3.175)*(b2 - 5.715)*(b2 - 8.255)*(+1);
    g(83) = (-0.504*c3 + Np3 + Ng3)*(b3 - 3.175)*(b3 - 5.715)*(b3 - 8.255)*(+1);
    g(84) = (-0.504*c4 + Np4 + Ng4)*(b4 - 3.175)*(b4 - 5.715)*(b4 - 8.255)*(+1);
    g(85) = wmin - w1*(Np1*Np2*Np3*Np4)/(Ng1*Ng2*Ng3*Ng4);
    g(86) = -wmax  + w1*(Np1*Np2*Np3*Np4)/(Ng1*Ng2*Ng3*Ng4);
    g(g == inf) = 1e6;
    g(g == -inf) = 1e6;
    ceq = [];
end

function xl = get_xl(~)
    xl = [6.51*ones(8,1); 0.51*ones(14,1)];
end

function xu = get_xu(~)
    xu = [76.49*ones(8,1); 4.49*ones(4,1); 9.49*ones(10,1)];
end

function fmin = get_fmin(~)
    fmin = 35.3676905240189;
end

function xmin = get_xmin(~)
    xmin = [18.0960498862046;36.4766831198579;20.6565107103415;44.7541124875989;22.2091334494337;47.3638340910337;20.0457299336354;42.8390805938834;0.629265314657840;0.914346638366681;0.851024779664636;0.624768157011791;6.65622896462916;3.96590851684381;4.18932703903823;3.77188137188885;4.05378642726586;4.03536875257909;4.17919123945762;5.13023554731496;5.46107054974288;5.48799078695515];
end
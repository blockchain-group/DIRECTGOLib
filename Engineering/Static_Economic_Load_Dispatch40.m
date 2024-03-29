function y = Static_Economic_Load_Dispatch40(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Static_Economic_Load_Dispatch40.m
%
% Original source: 
% - Das, S., & Suganthan, P. N. (2010). Problem definitions and evaluation 
%   criteria for CEC 2011 competition on testing evolutionary algorithms on 
%   real world optimization problems. Jadavpur University, Nanyang 
%   Technological University, Kolkata, 341-359.
%
% Known optimal solution:
%   f* = 133293.669192758
%   x* = [81.8406123458907;110.513282933909;86.9481559996661;175.104773691681;
%         72.5768758179996;101.272882713050;265.604081105545;267.589100501858;
%         296.912821480587;132.358800333974;314.903182822270;303.822432567270;
%         399.829402791677;453.465414833017;498.818973687708;356.658442338037;
%         396.436761457718;407.432546370718;487.523471528771;453.511780182701;
%         505.105080904927;436.578927393849;460.685942706686;545.035666011652;
%         490.227464865399;521.350022409262;74.4646258063070;14.5571727824657;
%         65.1142314558329;57.0319392129519;181.223830062486;189.431281494206;
%         139.562461187847;163.680321381935;146.005653177269;170.416970105122;
%         98.3502435009541;34.7355881431344;99.9664234403319;443.352358453333]
%  
% Problem Properties:
%   n  = 40;
%   #g = 2;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 40;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) confun(i);
    return
end
if size(x, 1) > size(x, 2), x = x'; end

% Extract data coefficients for the cost function
Data1 = get_data(x); 
Pmin = Data1(:, 1)'; 
a = Data1(:, 3)'; 
b = Data1(:, 4)';
c = Data1(:, 5)'; 
e = Data1(:, 6)'; 
f = Data1(:, 7)';

% Sum up the total cost
y = sum(a.*(x.^2) + b.*x + c + abs(e.*sin(f.*(Pmin - x))));
end

function [c, ceq] = confun(x)
    % Ensure x is a row vector
    if size(x, 1) > size(x, 2), x = x'; end

    % Power demand value
    Power_Demand = 10500;

    % Get data and B matrices from the get_data function
    [Data1, B1, B2, B3] = get_data(x);

    % Extract Pmax and Pmin from Data1
    Pmax = Data1(:, 2)';
    Pmin = Data1(:, 1)';

    % Calculate power loss
    Power_Loss = (x * B1 * x') + (B2 * x') + B3;
    Power_Loss = round(Power_Loss * 10000) / 10000;

    % Calculate the constraint values
    c(1) = abs(Power_Demand + Power_Loss - sum(x));
    c(2) = sum(abs(x - Pmin) - (x - Pmin)) + sum(abs(Pmax - x) - (Pmax - x));

    % No equality constraints, set ceq as an empty array
    ceq = [];
end


function xl = get_xl(~)
    xl = [36;36;60;80;47;68;110;135;135;130;94;94;125;125;125;125;220;220;242;242;254;254;254;254;254;254;10;10;10;47;60;60;60;90;90;90;25;25;25;242];
end

function xu = get_xu(~)
    xu = [114;114;120;190;97;140;300;300;300;300;375;375;500;500;500;500;500;500;550;550;550;550;550;550;550;550;150;150;150;97;190;190;190;200;200;200;110;110;110;550];
end

function fmin = get_fmin(~)
    fmin = 133293.669192758;
end

function xmin = get_xmin(~)
    xmin = [81.8406123458907;110.513282933909;86.9481559996661;175.104773691681;72.5768758179996;101.272882713050;265.604081105545;267.589100501858;296.912821480587;132.358800333974;314.903182822270;303.822432567270;399.829402791677;453.465414833017;498.818973687708;356.658442338037;396.436761457718;407.432546370718;487.523471528771;453.511780182701;505.105080904927;436.578927393849;460.685942706686;545.035666011652;490.227464865399;521.350022409262;74.4646258063070;14.5571727824657;65.1142314558329;57.0319392129519;181.223830062486;189.431281494206;139.562461187847;163.680321381935;146.005653177269;170.416970105122;98.3502435009541;34.7355881431344;99.9664234403319;443.352358453333];
end

function [Data1, B1, B2, B3] = get_data(x)
    Data1 = [36,114,0.0069,6.73,94.705,100,0.084;36,114,0.0069,6.73,94.705,100,0.084;
        60,120,0.02028,7.07,309.54,100,0.084;80,190,0.00942,8.18,369.03,150,0.063;
        47,97,0.0114,5.35,148.89,120,0.077;68,140,0.01142,8.05,222.33,100,0.084;
        110,300,0.00357,8.03,287.71,200,0.042;135,300,0.00492,6.99,391.98,200,0.042;
        135,300,0.00573,6.6,455.76,200,0.042;130,300,0.00605,12.9,722.82,200,0.042;
        94,375,0.00515,12.9,635.2,200,0.042;94,375,0.00569,12.8,654.69,200,0.042;
        125,500,0.00421,12.5,913.4,300,0.035;125,500,0.00752,8.84,1760.4,300,0.035;
        125,500,0.00708,9.15,1728.3,300,0.035;125,500,0.00708,9.15,1728.3,300,0.035;
        220,500,0.00313,7.97,647.85,300,0.035;220,500,0.00313,7.95,649.69,300,0.035;
        242,550,0.00313,7.97,647.83,300,0.035;242,550,0.00313,7.97,647.81,300,0.035;
        254,550,0.00298,6.63,785.96,300,0.035;254,550,0.00298,6.63,785.96,300,0.035;
        254,550,0.00284,6.66,794.53,300,0.035;254,550,0.00284,6.66,794.53,300,0.035;
        254,550,0.00277,7.1,801.32,300,0.035;254,550,0.00277,7.1,801.32,300,0.035;
        10,150,0.52124,3.33,1055.1,120,0.077;10,150,0.52124,3.33,1055.1,120,0.077;
        10,150,0.52124,3.33,1055.1,120,0.077;47,97,0.0114,5.35,148.89,120,0.077;
        60,190,0.0016,6.43,222.92,150,0.063;60,190,0.0016,6.43,222.92,150,0.063;
        60,190,0.0016,6.43,222.92,150,0.063;90,200,0.0001,8.95,107.87,200,0.042;
        90,200,0.0001,8.62,116.58,200,0.042;90,200,0.0001,8.62,116.58,200,0.042;
        25,110,0.0161,5.88,307.45,80,0.098;25,110,0.0161,5.88,307.45,80,0.098;
        25,110,0.0161,5.88,307.45,80,0.098;242,550,0.00313,7.97,647.83,300,0.035];
    B1 = zeros(length(x), length(x));
    B2 = zeros(1, length(x));
    B3 = 0;
end
function y = Static_Economic_Load_Dispatch15(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Static_Economic_Load_Dispatch15.m
%
% Original source: 
% - Das, S., & Suganthan, P. N. (2010). Problem definitions and evaluation 
%   criteria for CEC 2011 competition on testing evolutionary algorithms on 
%   real world optimization problems. Jadavpur University, Nanyang 
%   Technological University, Kolkata, 341-359.
%
% Known optimal solution:
%   f* = 32955.9206126027
%   x* = [441.646371834464;373.066493656330;123.732546177067;126.818807433321;
%         161.606519448746;417.407245856377;426.531726615785;135.485252536492;
%         148.406420219172;90.0980962070283;68.4228609163408;53.1758889579245;
%         35.6498589771666;27.5409857808133;35.7644253829755]
%  
% Problem Properties:
%   n  = 15;
%   #g = 4;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 15;
    y.ng = 4;
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
Data1 = get_data; 
a = Data1(:, 3)'; 
b = Data1(:, 4)'; 
c = Data1(:, 5)';

% Sum up the total cost
y = sum(a.*(x.^2) + b.*x + c);
end

function [c, ceq] = confun(x)
    % Ensure x is a row vector
    if size(x, 1) > size(x, 2), x = x'; end

    % Power demand value
    Power_Demand = 2630;

    % Get data from the get_data function
    [Data1, Data2, B1, B2, B3] = get_data;

    % Extract Pmax and Pmin from Data1
    Pmax = Data1(:, 2)';
    Pmin = Data1(:, 1)';

    % Extract initial generations and ramp rates from Data2
    Initial_Generations = Data2(:, 1)';
    Up_Ramp = Data2(:, 2)';
    Down_Ramp = Data2(:, 3)';

    % Calculate upper and lower ramp limits
    Up_Ramp_Limit = min(Pmax, Initial_Generations + Up_Ramp);
    Down_Ramp_Limit = max(Pmin, Initial_Generations - Down_Ramp);

    % Extract prohibited operating zone limits from Data2
    Prohibited_Operating_Zones_POZ = Data2(:, 4:end)';
    No_of_POZ_Limits = size(Prohibited_Operating_Zones_POZ, 1);
    POZ_Lower_Limits = Prohibited_Operating_Zones_POZ(1:2:No_of_POZ_Limits, :);
    POZ_Upper_Limits = Prohibited_Operating_Zones_POZ(2:2:No_of_POZ_Limits, :);

    % Calculate power loss
    Power_Loss = (x * B1 * x') + (B2 * x') + B3;
    Power_Loss = round(Power_Loss * 10000) / 10000;

    % Calculate the constraint values
    c(1) = abs(Power_Demand + Power_Loss - sum(x));
    c(2) = sum(abs(x - Pmin) - (x - Pmin)) + sum(abs(Pmax - x) - (Pmax - x));
    c(3) = sum(abs(x - Down_Ramp_Limit) - (x - Down_Ramp_Limit)) + sum(abs(Up_Ramp_Limit - x) - (Up_Ramp_Limit - x));
    temp_x = repmat(x, No_of_POZ_Limits/2, 1);
    c(4) = sum(sum((POZ_Lower_Limits < temp_x & temp_x < POZ_Upper_Limits) .* min(temp_x - POZ_Lower_Limits, POZ_Upper_Limits - temp_x)));

    % No equality constraints, set ceq as an empty array
    ceq = [];
end

function xl = get_xl(~)
    xl = [150;150;20;20;150;135;135;60;25;25;20;20;25;15;15];
end

function xu = get_xu(~)
    xu = [455;455;130;130;470;460;465;300;162;160;80;80;85;55;55];
end

function fmin = get_fmin(~)
    fmin = 32955.9206126027;
end

function xmin = get_xmin(~)
    xmin = [441.646371834464;373.066493656330;123.732546177067;126.818807433321;161.606519448746;417.407245856377;426.531726615785;135.485252536492;148.406420219172;90.0980962070283;68.4228609163408;53.1758889579245;35.6498589771666;27.5409857808133;35.7644253829755];
end

function [Data1, Data2, B1, B2, B3] = get_data(~)
    Data1 = [150,455,0.000299,10.1,671;150,455,0.000183,10.2,574;20,130,0.001126,8.8,374;
    20,130,0.001126,8.8,374;150,470,0.000205,10.4,461;135,460,0.000301,10.1,630;
    135,465,0.000364,9.8,548;60,300,0.000338,11.2,227;25,162,0.000807,11.2,173;
    25,160,0.001203,10.7,175;20,80,0.003586,10.2,186;20,80,0.005513,9.9,230;
    25,85,0.000371,13.1,225;15,55,0.001929,12.1,309;15,55,0.004447,12.4,323];
    Data2 = [400,80,120,150,150,150,150,150,150;300,80,120,185,255,305,335,420,450;105,130,130,20,20,20,20,20,20;
    100,130,130,20,20,20,20,20,20;90,80,120,180,200,305,335,390,420;400,80,120,230,255,365,395,430,455;
    350,80,120,135,135,135,135,135,135;95,65,100,60,60,60,60,60,60;105,60,100,25,25,25,25,25,25;
    110,60,100,25,25,25,25,25,25;60,80,80,20,20,20,20,20,20;40,80,80,30,40,55,65,20,20;
    30,80,80,25,25,25,25,25,25;20,55,55,15,15,15,15,15,15;20,55,55,15,15,15,15,15,15];
    B1 = [1.4,1.2,0.7,-0.1,-0.3,-0.1,-0.1,-0.1,-0.3,-0.5,-0.3,-0.2,0.4,0.3,-0.1;
    1.2,1.5,1.3,0,-0.5,-0.2,0,0.1,-0.2,-0.4,-0.4,0,0.4,1,-0.2;
    0.7,1.3,7.6,-0.1,-1.3,-0.9,-0.1,0,-0.8,-1.2,-1.7,0,-2.6,11.1,-2.8;
    -0.1,0,-0.1,3.4,-0.7,-0.4,1.1,5,2.9,3.2,-1.1,0,0.1,0.1,-2.6;
    -0.3,-0.5,-1.3,-0.7,9,1.4,-0.3,-1.2,-1,-1.3,0.7,-0.2,-0.2,-2.4,-0.3;
    -0.1,-0.2,-0.9,-0.4,1.4,1.6,0,-0.6,-0.5,-0.8,1.1,-0.1,-0.2,-1.7,0.3;
    -0.1,0,-0.1,1.1,-0.3,0,1.5,1.7,1.5,0.9,-0.5,0.7,0,-0.2,-0.8;
    -0.1,0.1,0,5,-1.2,-0.6,1.7,16.8,8.2,7.9,-2.3,-3.6,0.1,0.5,-7.8;
    -0.3,-0.2,-0.8,2.9,-1,-0.5,1.5,8.2,12.9,11.6,-2.1,-2.5,0.7,-1.2,-7.2;
    -0.5,-0.4,-1.2,3.2,-1.3,-0.8,0.9,7.9,11.6,20,-2.7,-3.4,0.9,-1.1,-8.8;
    -0.3,-0.4,-1.7,-1.1,0.7,1.1,-0.5,-2.3,-2.1,-2.7,14,0.1,0.4,-3.8,16.8;
    -0.2,0,0,0,-0.2,-0.1,0.7,-3.6,-2.5,-3.4,0.1,5.4,-0.1,-0.4,2.8;
    0.4,0.4,-2.6,0.1,-0.2,-0.2,0,0.1,0.7,0.9,0.4,-0.1,10.3,-10.1,2.8;
    0.3,1,11.1,0.1,-2.4,-1.7,-0.2,0.5,-1.2,-1.1,-3.8,-0.4,-10.1,57.8,-9.4;
    -0.1,-0.2,-2.8,-2.6,-0.3,0.3,-0.8,-7.8,-7.2,-8.8,16.8,2.8,2.8,-9.4,128.3];
    B1 = B1.*10^-5; B3 = 0.0055*10^(-2);   
    B2 = [-0.1,-0.2,2.8,-0.1,0.1,-0.3,-0.2,-0.2,0.6,3.9,-1.7,0,-3.2,6.7,-6.4].*10^-5;   
end
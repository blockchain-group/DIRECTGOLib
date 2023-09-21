function y = Hydrothermal_SchedulingC2(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hydrothermal_SchedulingC2.m
%
% Original source: 
% - Das, S., & Suganthan, P. N. (2010). Problem definitions and evaluation 
%   criteria for CEC 2011 competition on testing evolutionary algorithms on 
%   real world optimization problems. Jadavpur University, Nanyang 
%   Technological University, Kolkata, 341-359.
%
% Known optimal solution:
%   f* = 936160.9832087392
%   x* = [5.50073115958789;9.25160487468050;28.1635609266307;13.8175995755481;
%         5.17760441299913;8.59732633293901;27.8018613173456;14.5597321330361;
%         13.2480756995214;8.33885060568375;29.2879594755368;15.1105683739625;
%         7.33115780091698;8.70445908577098;21.9840840791332;13.1893195264515;
%         10.0013345314971;8.03017350762911;17.4792895653653;13.9511736252041;
%         6.36389987932073;6.83905106867821;16.6006067222572;14.8608755693578;
%         5.55969559341222;6.39464617158173;15.5042190828706;14.0403701639568;
%         12.4822252241023;6.06663539646317;12.3927150681107;13.6663131023512;
%         10.5965496546977;10.0271356054112;21.9111260411229;13.9696134001809;
%         6.81034354264621;6.44431197221812;18.8453234636830;13.9601690459253;
%         7.85931511687063;6.35374001582259;27.2244660003725;18.4761655510800;
%         11.3418829000757;10.8122886714362;16.6529435468134;13.2890051242613;
%         6.59908491423365;9.13109872714924;11.8981334818472;15.7123973718952;
%         5.11053895257464;9.53231196071795;13.4329062816079;13.1608714670945;
%         5.69878416486748;11.4695196678182;17.6900558384184;18.8623791393962;
%         6.85285268517039;6.20345217258491;17.8182556504855;13.0379371202132;
%         13.7792922835881;6.67074227772018;14.9923684174647;14.6542830633366;
%         6.33405183005533;6.86564517135328;20.1778493972455;21.6882815760326;
%         9.07302374223809;9.94108388998189;13.0989441444222;13.2908077365605;
%         10.1923750165899;12.4408715971232;14.4072519400638;15.6407452931969;
%         5.66199655161832;8.72713976004749;11.5379270806633;13.7478791874612;
%         11.3925673949957;6.46617951008585;12.0530665969983;15.7890970363802;
%         7.02401023531950;12.3190909843131;10.1227394553952;15.9486815257441;
%         5.00860671310095;6.37264097279021;11.0318180105367;19.7396547321701];
%  
% Problem Properties:
%   n  = 96;
%   #g = 6;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 96;
    y.ng = 6;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) confun(i);
    return
end
if size(x, 1) > size(x, 2)
    x = x';
end

No_of_Load_Hours = 24;
No_of_Units = 4;
Input_Discharges = reshape(x, No_of_Units, No_of_Load_Hours);
[Power_Demand, Inflow_Rate, Spillages, ~, ~, ~, ~, c1, c2, c3, c4, c5, c6, Delay_Time, No_of_Upstreams, ~, ~, V_Initial, ~, ~, ~, ~, ~] = get_data(No_of_Units, No_of_Load_Hours);

Storage_Volume = [V_Initial' zeros(No_of_Units, No_of_Load_Hours)];
Max_Delay = max(Delay_Time);
Initial_Discharges = zeros(No_of_Units, Max_Delay);
Initial_Spillages = zeros(No_of_Units, Max_Delay);
All_Spillages = [Initial_Spillages Spillages];
All_Discharges = [Initial_Discharges Input_Discharges];
Upstream_Carry = zeros(No_of_Units, No_of_Load_Hours);

% Calculate upstream carry and storage volume
for i = 1:No_of_Units
    for j = 1:No_of_Load_Hours
        Upstream_Volume = 0;
        for k = (i - No_of_Upstreams(i)):(i - 1)
            Upstream_Volume = Upstream_Volume + All_Discharges(k, j + Max_Delay - Delay_Time(k)) + All_Spillages(k, j + Max_Delay - Delay_Time(k));
        end
        Upstream_Carry(i, j) = Upstream_Volume;
        Storage_Volume(i, j + 1) = Storage_Volume(i, j) + Upstream_Volume - Input_Discharges(i, j) - Spillages(i, j) + Inflow_Rate(i, j);
    end
end

Current_Cost = zeros(No_of_Load_Hours, 1);
Power_Loss = zeros(No_of_Load_Hours, 1);

% Calculate hydro and thermal power generations, as well as current cost
for j = 1:No_of_Load_Hours
    q = Input_Discharges(:, j)';
    v = Storage_Volume(:, j + 1)';
    Ph = c1 .* (v.^2) + c2 .* (q.^2) + c3 .* (v .* q) + c4 .* (v) + c5 .* (q) + c6;
    Ph = Ph .* (Ph > 0);
    P_Thermal = Power_Demand(j) + Power_Loss(j) - sum(Ph);
    Current_Cost(j) = 5000 + 19.2 * P_Thermal + 0.002 * (P_Thermal^2);
end

% Calculate the total cost
y = sum(Current_Cost);
if isnan(y)
    y = 10^100;
end
end

function [c, ceq] = confun(x)
    if size(x, 1) > size(x, 2)
        x = x';
    end

    % Constants for the problem
    No_of_Load_Hours = 24;
    No_of_Units = 4;

    % Reshape the input vector to Discharges matrix
    Input_Discharges = reshape(x, No_of_Units, No_of_Load_Hours);

    % Get data for the problem
    [Power_Demand, Inflow_Rate, Spillages, Ptmin, Ptmax, PHmin, PHmax, c1, c2, c3, c4, c5, c6, Delay_Time, No_of_Upstreams, Vmin, Vmax, V_Initial, V_Final, Qmin, Qmax, POZ_Lower_Limits, POZ_Upper_Limits, No_of_POZ_Limits] = get_data(No_of_Units, No_of_Load_Hours);

    % Initialize matrices and arrays
    Storage_Volume = [V_Initial', zeros(No_of_Units, No_of_Load_Hours)];
    Max_Delay = max(Delay_Time);
    Initial_Discharges = zeros(No_of_Units, Max_Delay);
    Initial_Spillages = zeros(No_of_Units, Max_Delay);
    All_Spillages = [Initial_Spillages, Spillages];
    All_Discharges = [Initial_Discharges, Input_Discharges];
    Upstream_Carry = zeros(No_of_Units, No_of_Load_Hours);

    % Calculate Upstream Carry for each unit
    for i = 1:No_of_Units
        for j = 1:No_of_Load_Hours
            Upstream_Volume = 0;
            for k = (i - No_of_Upstreams(i)):(i - 1)
                Upstream_Volume = Upstream_Volume + All_Discharges(k, j + Max_Delay - Delay_Time(k)) + All_Spillages(k, j + Max_Delay - Delay_Time(k));
            end
            Upstream_Carry(i, j) = Upstream_Volume;
            Storage_Volume(i, j + 1) = Storage_Volume(i, j) + Upstream_Volume - Input_Discharges(i, j) - Spillages(i, j) + Inflow_Rate(i, j);
        end
    end

    % Initialize penalty arrays
    Discharge_Rate_Limits_Penalty = zeros(No_of_Load_Hours, 1);
    Storage_Volume_Limits_Penalty = zeros(No_of_Load_Hours, 1);
    POZ_Penalty = zeros(No_of_Load_Hours, 1);
    Capacity_Limits_Penalty_H = zeros(No_of_Load_Hours, 1);
    Capacity_Limits_Penalty_T = zeros(No_of_Load_Hours, 1);
    Power_Balance_Penalty = zeros(No_of_Load_Hours, 1);
    Power_Loss = zeros(No_of_Load_Hours, 1);
    Hydro_Generations = zeros(No_of_Load_Hours, No_of_Units);
    Thermal_Generations = zeros(No_of_Load_Hours, 1);

    % Calculate penalty and generation values for each load hour
    for j = 1:No_of_Load_Hours
        q = Input_Discharges(:, j)';
        v = Storage_Volume(:, j + 1)';
        Discharge_Rate_Limits_Penalty(j) = sum(abs(q - Qmin) - (q - Qmin)) + sum(abs(Qmax - q) - (Qmax - q));
        Storage_Volume_Limits_Penalty(j) = sum(abs(v - Vmin) - (v - Vmin)) + sum(abs(Vmax - v) - (Vmax - v));
        temp_q = repmat(q, No_of_POZ_Limits / 2, 1);
        POZ_Penalty(j) = sum(sum((POZ_Lower_Limits < temp_q & temp_q < POZ_Upper_Limits) .* min(temp_q - POZ_Lower_Limits, POZ_Upper_Limits - temp_q)));
        Ph = c1 .* (v.^2) + c2 .* (q.^2) + c3 .* (v .* q) + c4 .* (v) + c5 .* (q) + c6;
        Ph = Ph .* (Ph > 0);
        Hydro_Generations(j, :) = Ph;
        Capacity_Limits_Penalty_H(j) = sum(abs(Ph - PHmin) - (Ph - PHmin)) + sum(abs(PHmax - Ph) - (PHmax - Ph));
        P_Thermal = Power_Demand(j) + Power_Loss(j) - sum(Ph);
        Thermal_Generations(j) = P_Thermal;
        Capacity_Limits_Penalty_T(j) = sum(abs(P_Thermal - Ptmin) - (P_Thermal - Ptmin)) + sum(abs(Ptmax - P_Thermal) - (Ptmax - P_Thermal));
        Power_Balance_Penalty(j) = abs(Power_Demand(j) + Power_Loss(j) - sum(Ph) - P_Thermal);
    end

    % Calculate the constraint values
    c(1) = sum(Power_Balance_Penalty);
    c(2) = sum(Capacity_Limits_Penalty_H);
    c(3) = sum(Discharge_Rate_Limits_Penalty);
    c(4) = sum(Storage_Volume_Limits_Penalty);
    c(5) = sum(POZ_Penalty);
    c(6) = sum(abs(Storage_Volume(:, 1) - V_Initial')) + sum(abs(Storage_Volume(:, end) - V_Final'));

    % There are no equality constraints
    ceq = [];
end

function xl = get_xl(~)
    xl = repmat([5; 6; 10; 13], 24, 1);
end

function xu = get_xu(~)
    xu = repmat([15; 15; 30; 25], 24, 1);
end

function fmin = get_fmin(~)
    fmin = 936160.9832087392;
end

function xmin = get_xmin(~)
    xmin = [5.50073115958789;9.25160487468050;28.1635609266307;13.8175995755481;5.17760441299913;8.59732633293901;27.8018613173456;14.5597321330361;13.2480756995214;8.33885060568375;29.2879594755368;15.1105683739625;7.33115780091698;8.70445908577098;21.9840840791332;13.1893195264515;10.0013345314971;8.03017350762911;17.4792895653653;13.9511736252041;6.36389987932073;6.83905106867821;16.6006067222572;14.8608755693578;5.55969559341222;6.39464617158173;15.5042190828706;14.0403701639568;12.4822252241023;6.06663539646317;12.3927150681107;13.6663131023512;10.5965496546977;10.0271356054112;21.9111260411229;13.9696134001809;6.81034354264621;6.44431197221812;18.8453234636830;13.9601690459253;7.85931511687063;6.35374001582259;27.2244660003725;18.4761655510800;11.3418829000757;10.8122886714362;16.6529435468134;13.2890051242613;6.59908491423365;9.13109872714924;11.8981334818472;15.7123973718952;5.11053895257464;9.53231196071795;13.4329062816079;13.1608714670945;5.69878416486748;11.4695196678182;17.6900558384184;18.8623791393962;6.85285268517039;6.20345217258491;17.8182556504855;13.0379371202132;13.7792922835881;6.67074227772018;14.9923684174647;14.6542830633366;6.33405183005533;6.86564517135328;20.1778493972455;21.6882815760326;9.07302374223809;9.94108388998189;13.0989441444222;13.2908077365605;10.1923750165899;12.4408715971232;14.4072519400638;15.6407452931969;5.66199655161832;8.72713976004749;11.5379270806633;13.7478791874612;11.3925673949957;6.46617951008585;12.0530665969983;15.7890970363802;7.02401023531950;12.3190909843131;10.1227394553952;15.9486815257441;5.00860671310095;6.37264097279021;11.0318180105367;19.7396547321701];
end

function [Power_Demand, Inflow_Rate, Spillages, Ptmin, Ptmax, PHmin, PHmax, c1, c2, c3, c4, c5, c6, Delay_Time, No_of_Upstreams, Vmin, Vmax, V_Initial, V_Final, Qmin, Qmax, POZ_Lower_Limits, POZ_Upper_Limits, No_of_POZ_Limits] = get_data(No_of_Units, No_of_Load_Hours)
    % Power demand data (in MW)
    Power_Demand = [1370, 1390, 1360, 1290, 1290, 1410, 1650, 2000, 2240, 2320, 2230, 2310, 2230, 2200, 2130, 2070, 2130, 2140, 2240, 2280, 2240, 2120, 1850, 1590];

    % Inflow rate data
    Inflow_Rate = [
        10, 9, 8, 7, 6, 7, 8, 9, 10, 11, 12, 10, 11, 12, 11, 10, 9, 8, 7, 6, 7, 8, 9, 10;
        8, 8, 9, 9, 8, 7, 6, 7, 8, 9, 9, 8, 8, 9, 9, 8, 7, 6, 7, 8, 9, 9, 8, 8;
        8.1, 8.2, 4, 2, 3, 4, 3, 2, 1, 1, 1, 2, 4, 3, 3, 2, 2, 2, 1, 1, 2, 2, 1, 0;
        2.8, 2.4, 1.6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
    ];

    % Initialize Spillages matrix
    Spillages = zeros(No_of_Units, No_of_Load_Hours);

    % Parameters related to generator limits
    Ptmin = 500;        % Minimum thermal power
    Ptmax = 2500;       % Maximum thermal power
    PHmin = [0, 0, 0, 0];    % Minimum hydro power
    PHmax = [500, 500, 500, 500];   % Maximum hydro power

    % Coefficients for hydro and thermal power generation cost functions
    C_Coefficients = [
        -0.0042, -0.42, 0.030, 0.90, 10.0, -50;
        -0.0040, -0.30, 0.015, 1.14, 9.5, -70;
        -0.0016, -0.30, 0.014, 0.55, 5.5, -40;
        -0.0030, -0.31, 0.027, 1.44, 14.0, -90
    ];
    c1 = C_Coefficients(:, 1)';
    c2 = C_Coefficients(:, 2)';
    c3 = C_Coefficients(:, 3)';
    c4 = C_Coefficients(:, 4)';
    c5 = C_Coefficients(:, 5)';
    c6 = C_Coefficients(:, 6)';

    % Other parameters
    Delay_Time = [2, 3, 4, 0];    % Delay time for hydro units
    No_of_Upstreams = [0, 0, 2, 1];   % Number of upstream units for each unit
    Vmin = [80, 60, 100, 70];    % Minimum storage volume
    Vmax = [150, 120, 240, 160];    % Maximum storage volume
    V_Initial = [100, 80, 170, 120];    % Initial storage volume
    V_Final = [120, 70, 170, 140];    % Final storage volume
    Qmin = [5, 6, 10, 13];    % Minimum discharge rate
    Qmax = [15, 15, 30, 25];    % Maximum discharge rate

    % Prohibited Operating Zones (POZ) data
    Prohibited_Operating_Zones_POZ = [
        8, 9;
        7, 8;
        22, 27;
        16, 18
    ]';
    No_of_POZ_Limits = size(Prohibited_Operating_Zones_POZ, 1);
    POZ_Lower_Limits = Prohibited_Operating_Zones_POZ(1:2:No_of_POZ_Limits, :);
    POZ_Upper_Limits = Prohibited_Operating_Zones_POZ(2:2:No_of_POZ_Limits, :);
end
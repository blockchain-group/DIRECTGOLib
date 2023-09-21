function y = Hydrothermal_SchedulingC3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Hydrothermal_SchedulingC3.m
%
% Original source: 
% - Das, S., & Suganthan, P. N. (2010). Problem definitions and evaluation 
%   criteria for CEC 2011 competition on testing evolutionary algorithms on 
%   real world optimization problems. Jadavpur University, Nanyang 
%   Technological University, Kolkata, 341-359.
%
% Known optimal solution:
%   f* = 943801.2387174213
%   x* = [5.18062798625107;9.91295622937497;13.9831743786507;13.5345134942138;
%         9.74372344214675;8.92969280587280;29.4464878344107;14.1168401592056;
%         5.43568683301022;8.15454849995791;17.0811728391969;13.8437534039149;
%         5.08214768721787;8.46425448232694;16.0047770940194;13.4688332147776;
%         10.0026294779119;9.35379942631685;16.2450990628569;13.9821212218732;
%         9.48198319056705;8.89830719171694;15.8721415525080;13.1469806250555;
%         11.2496999943873;9.02757131304611;17.3790195288186;14.2743144647756;
%         5.35125576213585;6.33485375983152;21.3966329293356;14.3940443564192;
%         9.45440197519418;6.06970052515479;19.0268327303394;13.7228783492252;
%         9.12165043709133;8.46891606552260;15.8467658961395;18.0507586706769;
%         9.03964974764415;8.87091403461090;28.5985184588891;13.4420056493805;
%         13.5462476190713;8.55837454506584;10.5480315094660;14.2835229709924;
%         9.43611313411840;8.84419999773955;21.0289608590702;13.4009971307318;
%         5.32528607442993;6.05477587371412;13.5867212665577;13.0188817035132;
%         5.13330003303510;10.2935640782990;17.4675097233404;13.2211337199571;
%         9.01492320270874;6.68658409545937;20.6187604242117;13.1697933907512;
%         9.86756874025920;9.55542742917312;19.7361334560729;19.7011056531299;
%         5.38986569427098;9.37018428718003;15.7233087909271;14.8580579176268;
%         5.47637489792332;8.40604765636456;27.5474531708338;13.8815401394596;
%         12.9783371597917;8.58806687268942;14.6294982296835;19.0808874401443;
%         14.3510165442233;8.19401062520198;11.5401376462574;18.4680526843146;
%         5.04355399741729;8.24100981875844;11.4001020474488;14.2418503087904;
%         5.26205293035769;8.00484431075375;19.2482533145002;21.7645816407774;
%         5.03190343883547;8.71739607586855;10.0873006818915;13.4995514256214];
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
    c(5) = 1e5*sum(POZ_Penalty);
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
    fmin = 943801.2387174213;
end

function xmin = get_xmin(~)
    xmin = [5.18062798625107;9.91295622937497;13.9831743786507;13.5345134942138;9.74372344214675;8.92969280587280;29.4464878344107;14.1168401592056;5.43568683301022;8.15454849995791;17.0811728391969;13.8437534039149;5.08214768721787;8.46425448232694;16.0047770940194;13.4688332147776;10.0026294779119;9.35379942631685;16.2450990628569;13.9821212218732;9.48198319056705;8.89830719171694;15.8721415525080;13.1469806250555;11.2496999943873;9.02757131304611;17.3790195288186;14.2743144647756;5.35125576213585;6.33485375983152;21.3966329293356;14.3940443564192;9.45440197519418;6.06970052515479;19.0268327303394;13.7228783492252;9.12165043709133;8.46891606552260;15.8467658961395;18.0507586706769;9.03964974764415;8.87091403461090;28.5985184588891;13.4420056493805;13.5462476190713;8.55837454506584;10.5480315094660;14.2835229709924;9.43611313411840;8.84419999773955;21.0289608590702;13.4009971307318;5.32528607442993;6.05477587371412;13.5867212665577;13.0188817035132;5.13330003303510;10.2935640782990;17.4675097233404;13.2211337199571;9.01492320270874;6.68658409545937;20.6187604242117;13.1697933907512;9.86756874025920;9.55542742917312;19.7361334560729;19.7011056531299;5.38986569427098;9.37018428718003;15.7233087909271;14.8580579176268;5.47637489792332;8.40604765636456;27.5474531708338;13.8815401394596;12.9783371597917;8.58806687268942;14.6294982296835;19.0808874401443;14.3510165442233;8.19401062520198;11.5401376462574;18.4680526843146;5.04355399741729;8.24100981875844;11.4001020474488;14.2418503087904;5.26205293035769;8.00484431075375;19.2482533145002;21.7645816407774;5.03190343883547;8.71739607586855;10.0873006818915;13.4995514256214];
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
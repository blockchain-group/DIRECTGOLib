function y = Spacecraft_Trajectory_OptimizationC1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Spacecraft_Trajectory_OptimizationC1.m
%
% References:				
%  - Das, Swagatam, and Ponnuthurai N. Suganthan. "Problem definitions and 
%    evaluation criteria for CEC 2011 competition on testing evolutionary 
%    algorithms on real world optimization problems." Jadavpur University, 
%    Nanyang Technological University, Kolkata (2010): 341-359.																			
%
% Known optimal solution:
%   f* = 15.3594572890577
%   x* = [2100.08128842148;3.01670604074582;0.543184473911497;0.827185896458873;
%         166.402479296855;300.812884214805;164.207691916883;167.479550881471;
%         174.063913021389;178.176599095666;0.361685718640451;0.493975511863029;
%         0.372938068383885;0.155210079764264;0.558153736727125;0.332658639435046;
%         2.24950718894478;5.58114870700605;1.86519204389575;4.47209647919524;
%         5.57134202103338;-0.0134071931566093;0.348267803187163;0.348906240956525;
%        -1.51277829450409;-2.67601191028230];
%
% Problem Properties:
%   n  = 26
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 26;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 1) > size(x, 2)
    x = x'; 
end

y = mga_dsm(x);
if isnan(y) 
    y = 10^100; 
end
end

function xl = get_xl(~)
    xl = [1900;2.5;0;0;100;100;100;100;100;100;0.01;0.01;0.01;0.01;0.01;0.01;1.1;1.1;1.05;1.05;1.05;-pi;-pi;-pi;-pi;-pi];
end

function xu = get_xu(~)
    xu = [2300;4.05;1;1;500;500;500;500;500;600;0.99;0.99;0.99;0.99;0.99;0.99;6;6;6;6;6;pi;pi;pi;pi;pi];
end

function fmin = get_fmin(~)
    fmin = 15.3594572890577;
end

function xmin = get_xmin(~)
    xmin = [2100.08128842148;3.01670604074582;0.543184473911497;0.827185896458873;166.402479296855;300.812884214805;164.207691916883;167.479550881471;174.063913021389;178.176599095666;0.361685718640451;0.493975511863029;0.372938068383885;0.155210079764264;0.558153736727125;0.332658639435046;2.24950718894478;5.58114870700605;1.86519204389575;4.47209647919524;5.57134202103338;-0.0134071931566093;0.348267803187163;0.348906240956525;-1.51277829450409;-2.67601191028230];
end

function J = mga_dsm(t)
    sequence = [3,2,2,1,1,1,1];
    problem.objective.rp = 2640;
    problem.objective.e = 0.704;
    
    % Define target periapsis (rp_target) and eccentricity (e_target) based on the objective type
    rp_target = problem.objective.rp;
    e_target = problem.objective.e;
    
    % Gravitational constants for the solar system bodies
    mu(1) = 22321;          % Mercury
    mu(2) = 324860;         % Venus
    mu(3) = 398601.19;      % Earth
    mu(4) = 42828.3;        % Mars
    mu(5) = 126.7e6;        % Jupiter
    mu(6) = 37.93951970883e6; % Saturn
    muSUN = 1.32712428e+11; % Gravitational constant of the Sun
    
    % Radii of the planets (in km)
    RPL(1) = 2440; % Mercury
    RPL(2) = 6052; % Venus
    RPL(3) = 6378; % Earth
    RPL(4) = 3397; % Mars
    RPL(5) = 71492; % Jupiter
    RPL(6) = 60330; % Saturn
    
    tdep = t(1); % Departure time (days from the initial epoch)
    VINF = t(2); % Hyperbolic excess velocity (km/s)
    udir = t(3); % Unit direction vector for the spacecraft's asymptote direction
    vdir = t(4); % Unit direction vector for the spacecraft's out-of-plane direction
    
    N = length(sequence); % Number of planets in the mission sequence
    tof = zeros(N-1, 1); % Time of flight between planets (days)
    alpha = zeros(N-1, 1); % Fraction of time of flight at which DSM occurs
    
    % Extract time of flight and DSM fraction from the decision vector
    for i = 1:N-1
        tof(i) = t(i+4); % Planet-to-planet Time of Flight (ToF) (days)
        alpha(i) = t(N+i+3); % Fraction of ToF at which the DSM occurs
    end
    
    rp_non_dim = zeros(N-2, 1); % Periapsis flyby radius for planets P2..Pn-1 (non-dimensional)
    gamma = zeros(N-2, 1); % Rotation of the b-plane-component of the swingby outgoing velocity vector
    
    % Extract flyby radius and velocity rotation angle for each planet
    for i = 1:N-2
        rp_non_dim(i) = t(i+2*N+2); % Non-dimensional perigee fly-by radius of planets P2..Pn-1 (i=1 refers to the second planet)
        gamma(i) = t(3*N+i); % Rotation of the b-plane-component of the swingby outgoing velocity vector
    end
    
    % Calculate positions, velocities, and gravitational constants for the solar system bodies
    r = zeros(3, N);
    v = zeros(3, N);
    muvec = zeros(N, 1);
    Itime = zeros(N);
    dT = zeros(1, N);
    seq = abs(sequence);
    T = tdep;
    dT(1:N-1) = tof;
    
    for i = 1:N
        Itime(i) = T;
        if seq(i) < 10
            [r(:,i), v(:,i)] = pleph_an(T, seq(i)); % Positions and velocities of solar system planets
            muvec(i) = mu(seq(i)); % Gravitational constants
        else
            [r(:,i), v(:,i)] = CUSTOMeph(mjd20002jed(T), problem.customobject(seq(i)).epoch, ...
                problem.customobject(seq(i)).keplerian, 1); % Positions and velocities of custom object
            muvec(i) = problem.customobject(seq(i)).mu; % Gravitational constant of custom object
        end
        T = T + dT(i);
    end
    
    % Calculate flyby radii
    rp = zeros(N-2, 1);
    for i = 1:N-2
        rp(i) = rp_non_dim(i) * RPL(seq(i+1)); % Dimensional flyby radii (i=1 corresponds to the second planet)
    end
    
    vtemp= cross(r(:,1),v(:,1));
    iP1= v(:,1)/norm(v(:,1));
    zP1= vtemp/norm(vtemp);
    jP1= cross(zP1,iP1);
    theta=2*pi*udir;         %See Picking a Point on a Sphere
    phi=acos(2*vdir-1)-pi/2; %In this way: -pi/2<phi<pi/2 so phi can be used as out-of-plane rotation
    vinf=VINF*(cos(theta)*cos(phi)*iP1+sin(theta)*cos(phi)*jP1+sin(phi)*zP1);
    v_sc_pl_in(:,1)=v(:,1); %Spacecraft absolute incoming velocity at P1
    v_sc_pl_out(:,1)=v(:,1)+vinf; %Spacecraft absolute outgoing velocity at P1
    tDSM(1)=alpha(1)*tof(1);
    [rd(:,1),v_sc_dsm_in(:,1)]=propagateKEP(r(:,1),v_sc_pl_out(:,1),tDSM(1)*24*60*60,muSUN);
    lw=vett(rd(:,1),r(:,2));
    lw=sign(lw(3));
    if lw==1
        lw=0;
    else
        lw=1;
    end
    [v_sc_dsm_out(:,1),v_sc_pl_in(:,2)]=lambertI(rd(:,1),r(:,2),tof(1)*(1-alpha(1))*24*60*60,muSUN,lw);
    DV=zeros(N-1,1);
    DV(1)=norm(v_sc_dsm_out(:,1)-v_sc_dsm_in(:,1));
    tDSM=zeros(N-1,1);
    for i=1:N-2
        v_rel_in=v_sc_pl_in(:,i+1)-v(:,i+1);
        e=1+rp(i)/muvec(i+1)*v_rel_in'*v_rel_in;
        beta_rot=2*asin(1/e);              %velocity rotation
        ix=v_rel_in/norm(v_rel_in);
        iy=vett(ix,v(:,i+1)/norm(v(:,i+1)))';
        iy=iy/norm(iy);
        iz=vett(ix,iy)';
        iVout = cos(beta_rot) * ix + cos(gamma(i))*sin(beta_rot) * iy + sin(gamma(i))*sin(beta_rot) * iz;
        v_rel_out=norm(v_rel_in)*iVout;
        v_sc_pl_out(:,i+1)=v(:,i+1)+v_rel_out;
        tDSM(i+1)=alpha(i+1)*tof(i+1);
        [rd(:,i+1),v_sc_dsm_in(:,i+1)]=propagateKEP(r(:,i+1),v_sc_pl_out(:,i+1),tDSM(i+1)*24*60*60,muSUN);
        lw=vett(rd(:,i+1),r(:,i+2));
        lw=sign(lw(3));
        if lw==1
            lw=0;
        else
            lw=1;
        end
        [v_sc_dsm_out(:,i+1),v_sc_pl_in(:,i+2)]=lambertI(rd(:,i+1),r(:,i+2),tof(i+1)*(1-alpha(i+1))*24*60*60,muSUN,lw);
        DV(i+1)=norm(v_sc_dsm_out(:,i+1)-v_sc_dsm_in(:,i+1));
    end
    DVrel=norm(v(:,N)-v_sc_pl_in(:,N)); %Relative velocity at target planet
    DVper=sqrt(DVrel^2+2*muvec(N)/rp_target);  %Hyperbola
    DVper2=sqrt(2*muvec(N)/rp_target-muvec(N)/rp_target*(1-e_target)); %Ellipse
    DVarr=abs(DVper-DVper2);
    DV(N)=DVarr;
    DVtot=sum(DV);
    J = DVtot;
end

function [r, v] = propagateKEP(r0, v0, t, mu)
    DD = eye(3);
    h = vett(r0, v0); % Specific angular momentum vector
    
    ih = h / norm(h); % Normalized specific angular momentum vector
    
    % Check if the orbit is retrograde (ih = [0, 0, -1]) with a small tolerance.
    if abs(abs(ih(3)) - 1) < 1e-3
        % Random rotation matrix to make the Euler angles well defined for retrograde orbits
        DD = [1, 0, 0; 0, 0, 1; 0, -1, 0];
    
        % Rotate the initial position and velocity vectors
        r0 = DD * r0;
        v0 = DD * v0;
    end
    
    % Convert initial conditions to orbital elements
    E = IC2par(r0, v0, mu);
    
    % Calculate the mean anomaly at time t (M)
    M0 = E2M(E(6), E(2));
    if E(2) < 1
        M = M0 + sqrt(mu / E(1)^3) * t;
    else
        M = M0 + sqrt(-mu / E(1)^3) * t;
    end
    
    % Solve for eccentric anomaly (E) at time t
    E(6) = M2E(M, E(2));
    
    % Convert the updated orbital elements back to initial conditions (r0, v0)
    [r, v] = par2IC(E, mu);
    
    % Rotate the position and velocity vectors back to the original frame
    r = DD' * r;
    v = DD' * v;
end

function E = IC2par(r0, v0, mu)
    % Convert initial position and velocity vectors to orbital elements.
    
    k = [0, 0, 1]'; % Unit vector in the z-direction (assuming Earth-centered inertial frame)
    h = vett(r0, v0)'; % Specific angular momentum vector
    p = h' * h / mu; % Semi-latus rectum
    
    n = vett(k, h)'; % Unit vector in the ascending node direction
    n = n / norm(n);
    
    R0 = norm(r0); % Magnitude of initial position vector
    evett = vett(v0, h)' / mu - r0 / R0; % Eccentricity vector
    e = evett' * evett; % Eccentricity
    
    E(1) = p / (1 - e); % Semi-major axis
    E(2) = sqrt(e); % Eccentricity
    e = E(2);
    
    E(3) = acos(h(3) / norm(h)); % Inclination
    
    % Argument of periapsis (omega)
    E(5) = (acos((n' * evett) / e));
    
    % Check for quadrant and adjust the angle if necessary
    if evett(3) < 0
        E(5) = 2 * pi - E(5);
    end
    
    % Right ascension of the ascending node (Omega)
    E(4) = acos(n(1));
    if n(2) < 0
        E(4) = 2 * pi - E(4);
    end
    
    % True anomaly (theta)
    ni = real(acos((evett' * r0) / e / R0)); % Real is to avoid problems when ni~=pi
    if (r0' * v0) < 0
        ni = 2 * pi - ni;
    end
    
    % Solve for eccentric anomaly (E) from true anomaly (theta)
    E(6) = ni2E(ni, e);
end

function E = ni2E(ni, e)
    % Convert true anomaly (theta) to eccentric anomaly (E) using algebraic Kepler's equation for ellipse or hyperbolic equivalent.
    
    if e < 1
        E = 2 * atan(sqrt((1 - e) / (1 + e)) * tan(ni / 2)); % Algebraic Kepler's equation for ellipse
    else
        E = 2 * atan(sqrt((e - 1) / (e + 1)) * tan(ni / 2)); % Algebraic equivalent of Kepler's equation in terms of the Gudermannian for hyperbola
    end
end

function [r0, v0] = par2IC(E, mu)
    % Convert orbital elements (E) to initial position (r0) and velocity (v0) vectors.
    
    a = E(1);
    e = E(2);
    i = E(3);
    omg = E(4);
    omp = E(5);
    EA = E(6);
    
    % If the orbit is an ellipse
    if e < 1
        b = a * sqrt(1 - e^2);
        n = sqrt(mu / a^3);
    
        xper = a * (cos(EA) - e);
        yper = b * sin(EA);
    
        xdotper = -(a * n * sin(EA)) / (1 - e * cos(EA));
        ydotper = (b * n * cos(EA)) / (1 - e * cos(EA));
    else % If the orbit is a hyperbola
        b = -a * sqrt(e^2 - 1);
        n = sqrt(-mu / a^3);
        
        % Calculate the denominator for the hyperbolic case
        dNdzeta = e * (1 + tan(EA)^2) - (1 / 2 + 1 / 2 * tan(1 / 2 * EA + 1 / 4 * pi)^2) / tan(1 / 2 * EA + 1 / 4 * pi);
        
        xper = a / cos(EA) - a * e;
        yper = b * tan(EA);
        
        xdotper = a * tan(EA) / cos(EA) * n / dNdzeta;
        ydotper = b / cos(EA)^2 * n / dNdzeta;
    end
    
    % Rotation matrix for converting orbital elements to initial conditions
    R(1, 1) = cos(omg) * cos(omp) - sin(omg) * sin(omp) * cos(i);
    R(1, 2) = -cos(omg) * sin(omp) - sin(omg) * cos(omp) * cos(i);
    R(1, 3) = sin(omg) * sin(i);
    R(2, 1) = sin(omg) * cos(omp) + cos(omg) * sin(omp) * cos(i);
    R(2, 2) = -sin(omg) * sin(omp) + cos(omg) * cos(omp) * cos(i);
    R(2, 3) = -cos(omg) * sin(i);
    R(3, 1) = sin(omp) * sin(i);
    R(3, 2) = cos(omp) * sin(i);
    R(3, 3) = cos(i);
    
    r0 = R * [xper; yper; 0];
    v0 = R * [xdotper; ydotper; 0];
end

function [v1, v2, a, p, theta, iter] = lambertI(r1, r2, t, mu, lw, N, branch)
    % Check if the number of input arguments is 5 (N is not provided) and set N to 0 if true.
    if nargin == 5
        N = 0;
    end
    
    % Check if time t is negative and print a warning message if it is.
    if t <= 0
        warning('Negative time as input');
        v1 = [NaN; NaN; NaN];
        v2 = [NaN; NaN; NaN];
        return;
    end
    
    % Set the tolerance for Newton's iterations.
    tol = 1e-11;
    
    % Calculate the normalized radius and velocity magnitude.
    R = norm(r1);
    V = sqrt(mu / R);
    T = R / V;
    
    % Working with non-dimensional radii and time-of-flight.
    r1 = r1 / R;
    r2 = r2 / R;
    t = t / T;
    
    % Evaluation of the relevant geometry parameters in non-dimensional units.
    r2mod = norm(r2);
    theta = acos(r1' * r2 / r2mod);
    
    % If lw is true, set theta to its complementary angle.
    if lw
        theta = 2 * pi - theta;
    end
    
    c = sqrt(1 + r2mod^2 - 2 * r2mod * cos(theta)); % Non-dimensional chord
    s = (1 + r2mod + c) / 2; % Non-dimensional semi-perimeter
    am = s / 2; % Minimum energy ellipse semi-major axis
    lambda = sqrt(r2mod) * cos(theta / 2) / s; % Lambda parameter defined in BATTIN's book
    
    % Initialize variables for Newton iterations.
    iter = 0;
    
    % For N = 0, calculate x using Newton iterations.
    if N == 0
        inn1 = -0.5233; % First guess point
        inn2 = 0.5233; % Second guess point
        x1 = log(1 + inn1);
        x2 = log(1 + inn2);
        y1 = log(x2tof(inn1, s, c, lw, N)) - log(t);
        y2 = log(x2tof(inn2, s, c, lw, N)) - log(t);
        
        % Newton iterations
        err = 1;
        while err > tol && y1 ~= y2
            iter = iter + 1;
            xnew = (x1 * y2 - y1 * x2) / (y2 - y1);
            ynew = log(x2tof(exp(xnew) - 1, s, c, lw, N)) - log(t);
            x1 = x2;
            y1 = y2;
            x2 = xnew;
            y2 = ynew;
            err = abs(x1 - xnew);
        end
        x = exp(xnew) - 1;
    else
        % For N ~= 0, calculate x using Newton iterations for the given branch (long or short).
        if branch == 'l'
            inn1 = -0.5234;
            inn2 = -0.2234;
        else
            inn1 = 0.7234;
            inn2 = 0.5234;
        end
        x1 = tan(inn1 * pi / 2);
        x2 = tan(inn2 * pi / 2);
        y1 = x2tof(inn1, s, c, lw, N) - t;
        y2 = x2tof(inn2, s, c, lw, N) - t;
        
        err = 1;
        while err > tol && iter < 60 && y1 ~= y2
            iter = iter + 1;
            xnew = (x1 * y2 - y1 * x2) / (y2 - y1);
            ynew = x2tof(atan(xnew) * 2 / pi, s, c, lw, N) - t;
            x1 = x2;
            y1 = y2;
            x2 = xnew;
            y2 = ynew;
            err = abs(x1 - xnew);
        end
        x = atan(xnew) * 2 / pi;
    end
    
    a = am / (1 - x^2); % Solution semimajor axis
    
    % For ellipse, calculate beta, alfa, psi, and eta.
    if x < 1
        beta = 2 * asin(sqrt((s - c) / (2 * a)));
        if lw
            beta = -beta;
        end
        alfa = 2 * acos(x);
        psi = (alfa - beta) / 2;
        eta2 = 2 * a * sin(psi)^2 / s;
        eta = sqrt(eta2);
    else
        % For hyperbola, calculate beta, alfa, psi, and eta.
        beta = 2 * asinh(sqrt((c - s) / (2 * a)));
        if lw
            beta = -beta;
        end
        alfa = 2 * acosh(x);
        psi = (alfa - beta) / 2;
        eta2 = -2 * a * sinh(psi)^2 / s;
        eta = sqrt(eta2);
    end
    
    p = r2mod / am / eta2 * sin(theta / 2)^2; % Parameter of the solution
    sigma1 = 1 / eta / sqrt(am) * (2 * lambda * am - (lambda + x * eta));
    ih = vers(vett(r1, r2)'); % Normalized initial unit vector
    
    if lw
        ih = -ih;
    end
    
    % Calculate velocity components.
    vr1 = sigma1;
    vt1 = sqrt(p);
    v1 = vr1 * r1 + vt1 * vett(ih, r1)';
    
    vt2 = vt1 / r2mod;
    vr2 = -vr1 + (vt1 - vt2) / tan(theta / 2);
    v2 = vr2 * r2 / r2mod + vt2 * vett(ih, r2 / r2mod)';
    
    % Rescale the velocity vectors to dimensional units.
    v1 = v1 * V;
    v2 = v2 * V;
    a = a * R;
    p = p * R;
end

function t = x2tof(x, s, c, lw, N)  
    am = s / 2;
    a = am / (1 - x^2);
    if x < 1 % Ellipse
        beta = 2 * asin(sqrt((s - c) / (2 * a)));
        if lw
            beta = -beta;
        end
        alfa = 2 * acos(x);
    else % Hyperbola
        alfa = 2 * acosh(x);
        beta = 2 * asinh(sqrt((s - c) / (-2 * a)));
        if lw
            beta = -beta;
        end
    end
    t = tofabn(a, alfa, beta, N);
end

function t = tofabn(sigma, alfa, beta, N)
    if sigma > 0
        t = sigma * sqrt(sigma) * ((alfa - sin(alfa)) - (beta - sin(beta)) + N * 2 * pi);
    else
        t = -sigma * sqrt(-sigma) * ((sinh(alfa) - alfa) - (sinh(beta) - beta));
    end
end

function v = vers(V) 
    v = V / sqrt(V' * V);
end

function ansd = vett(r1, r2)  
    ansd(1) = (r1(2) * r2(3) - r1(3) * r2(2));
    ansd(2) = (r1(3) * r2(1) - r1(1) * r2(3));
    ansd(3) = (r1(1) * r2(2) - r1(2) * r2(1));
end

function [r, v, E] = pleph_an(mjd2000, planet)
    % Constants
    RAD = pi / 180;
    KM = 1.495978706910000e+008;

    % Time variables
    T = (mjd2000 + 36525.00) / 36525.00;
    TT = T * T;
    TTT = T * TT;

    % Planetary parameters based on the input planet
    switch planet
        case 1
            E(1) = 0.38709860;
            E(2) = 0.205614210 + 0.000020460*T - 0.000000030*TT;
            E(3) = 7.002880555555555560 + 1.86083333333333333e-3*T - 1.83333333333333333e-5*TT;
            E(4) = 4.71459444444444444e+1 + 1.185208333333333330*T + 1.73888888888888889e-4*TT;
            E(5) = 2.87537527777777778e+1 + 3.70280555555555556e-1*T +1.20833333333333333e-4*TT;
            XM   = 1.49472515288888889e+5 + 6.38888888888888889e-6*T;
            E(6) = 1.02279380555555556e2 + XM*T;
        case 2
            E(1) = 0.72333160;
            E(2) = 0.006820690 - 0.000047740*T + 0.0000000910*TT;
            E(3) = 3.393630555555555560 + 1.00583333333333333e-3*T - 9.72222222222222222e-7*TT;
            E(4) = 7.57796472222222222e+1 + 8.9985e-1*T + 4.1e-4*TT;
            E(5) = 5.43841861111111111e+1 + 5.08186111111111111e-1*T -1.38638888888888889e-3*TT;
            XM   = 5.8517803875e+4 + 1.28605555555555556e-3*T;
            E(6) = 2.12603219444444444e2 + XM*T;
        case 3
            E(1) = 1.000000230;
            E(2) = 0.016751040 - 0.000041800*T - 0.0000001260*TT;
            E(3) = 0.00;
            E(4) = 0.00;
            E(5) = 1.01220833333333333e+2 + 1.7191750*T + 4.52777777777777778e-4*TT + 3.33333333333333333e-6*TTT;
            XM   = 3.599904975e+4 - 1.50277777777777778e-4*T - 3.33333333333333333e-6*TT;
            E(6) = 3.58475844444444444e2 + XM*T;
        case 4
            E(1) = 1.5236883990;
            E(2) = 0.093312900 + 0.0000920640*T - 0.0000000770*TT;
            E(3) = 1.850333333333333330 - 6.75e-4*T + 1.26111111111111111e-5*TT;
            E(4) = 4.87864416666666667e+1 + 7.70991666666666667e-1*T - 1.38888888888888889e-6*TT - 5.33333333333333333e-6*TTT;
            E(5) = 2.85431761111111111e+2 + 1.069766666666666670*T +  1.3125e-4*TT + 4.13888888888888889e-6*TTT;
            XM   = 1.91398585e+4 + 1.80805555555555556e-4*T + 1.19444444444444444e-6*TT;
            E(6) = 3.19529425e2 + XM*T;
        case 5
            E(1) = 5.2025610;
            E(2) = 0.048334750 + 0.000164180*T  - 0.00000046760*TT -0.00000000170*TTT;
            E(3) = 1.308736111111111110 - 5.69611111111111111e-3*T +  3.88888888888888889e-6*TT;
            E(4) = 9.94433861111111111e+1 + 1.010530*T + 3.52222222222222222e-4*TT - 8.51111111111111111e-6*TTT;
            E(5) = 2.73277541666666667e+2 + 5.99431666666666667e-1*T + 7.0405e-4*TT + 5.07777777777777778e-6*TTT;
            XM   = 3.03469202388888889e+3 - 7.21588888888888889e-4*T + 1.78444444444444444e-6*TT;
            E(6) = 2.25328327777777778e2 + XM*T;
        case 6
            E(1) = 9.5547470;
            E(2) = 0.055892320 - 0.00034550*T - 0.0000007280*TT + 0.000000000740*TTT;
            E(3) = 2.492519444444444440 - 3.91888888888888889e-3*T - 1.54888888888888889e-5*TT + 4.44444444444444444e-8*TTT;
            E(4) = 1.12790388888888889e+2 + 8.73195138888888889e-1*T -1.52180555555555556e-4*TT - 5.30555555555555556e-6*TTT;
            E(5) = 3.38307772222222222e+2 + 1.085220694444444440*T + 9.78541666666666667e-4*TT + 9.91666666666666667e-6*TTT;
            XM   = 1.22155146777777778e+3 - 5.01819444444444444e-4*T - 5.19444444444444444e-6*TT;
            E(6) = 1.75466216666666667e2 + XM*T;
        case 7
            E(1) = 19.218140;
            E(2) = 0.04634440 - 0.000026580*T + 0.0000000770*TT;
            E(3) = 7.72463888888888889e-1 + 6.25277777777777778e-4*T + 3.95e-5*TT;
            E(4) = 7.34770972222222222e+1 + 4.98667777777777778e-1*T + 1.31166666666666667e-3*TT;
            E(5) = 9.80715527777777778e+1 + 9.85765e-1*T - 1.07447222222222222e-3*TT - 6.05555555555555556e-7*TTT;
            XM   = 4.28379113055555556e+2 + 7.88444444444444444e-5*T + 1.11111111111111111e-9*TT;
            E(6) = 7.26488194444444444e1 + XM*T;
        case 8
            E(1) = 30.109570;
            E(2) = 0.008997040 + 0.0000063300*T - 0.0000000020*TT;
            E(3) = 1.779241666666666670 - 9.54361111111111111e-3*T - 9.11111111111111111e-6*TT;
            E(4) = 1.30681358333333333e+2 + 1.0989350*T + 2.49866666666666667e-4*TT - 4.71777777777777778e-6*TTT;
            E(5) = 2.76045966666666667e+2 + 3.25639444444444444e-1*T + 1.4095e-4*TT + 4.11333333333333333e-6*TTT;
            XM   = 2.18461339722222222e+2 - 7.03333333333333333e-5*T;
            E(6) = 3.77306694444444444e1 + XM*T;
        case 9
            T=mjd2000/36525;
            TT=T*T;
            TTT=TT*T;
            TTTT=TTT*T;
            TTTTT=TTTT*T;
            E(1)=39.34041961252520 + 4.33305138120726*T - 22.93749932403733*TT + 48.76336720791873*TTT - 45.52494862462379*TTTT + 15.55134951783384*TTTTT;
            E(2)=0.24617365396517 + 0.09198001742190*T - 0.57262288991447*TT + 1.39163022881098*TTT - 1.46948451587683*TTTT + 0.56164158721620*TTTTT;
            E(3)=17.16690003784702 - 0.49770248790479*T + 2.73751901890829*TT - 6.26973695197547*TTT + 6.36276927397430*TTTT - 2.37006911673031*TTTTT;
            E(4)=110.222019291707 + 1.551579150048*T - 9.701771291171*TT + 25.730756810615*TTT - 30.140401383522*TTTT + 12.796598193159 * TTTTT;
            E(5)=113.368933916592 + 9.436835192183*T - 35.762300003726*TT + 48.966118351549*TTT - 19.384576636609*TTTT - 3.362714022614 * TTTTT;
            E(6)=15.17008631634665 + 137.023166578486*T + 28.362805871736*TT - 29.677368415909*TTT - 3.585159909117*TTTT + 13.406844652829 * TTTTT;
    end

    % Convert the units of planetary parameters
    E(1) = E(1) * KM;
    for I = 3:6
        E(I) = E(I) * RAD;
    end
    E(6) = mod(E(6), 2 * pi);

    % Calculate the eccentric anomaly (EccAnom) using M2E function
    EccAnom = M2E(E(6), E(2));
    E(6) = EccAnom;

    % Calculate the position and velocity vectors (r and v) using the conversion function
    [r, v] = conversion(E);
end

function [r, v] = conversion(E)
    % Constants
    muSUN = 1.327124280000000e+011;

    % Extract orbital elements from the input vector E
    a = E(1);   % Semi-major axis
    e = E(2);   % Eccentricity
    i = E(3);   % Inclination
    omg = E(4); % Longitude of the ascending node (Omega)
    omp = E(5); % Argument of periapsis (omega)
    EA = E(6);  % Eccentric anomaly (E)

    % Calculate parameters needed for conversion
    b = a * sqrt(1 - e^2); % Semi-minor axis
    n = sqrt(muSUN / a^3); % Mean motion

    % Perifocal coordinates and velocities
    xper = a * (cos(EA) - e);
    yper = b * sin(EA);

    xdotper = -(a * n * sin(EA)) / (1 - e * cos(EA));
    ydotper = (b * n * cos(EA)) / (1 - e * cos(EA));

    % Transformation matrix from perifocal to ECI (Earth-Centered Inertial) frame
    R(1, 1) = cos(omg) * cos(omp) - sin(omg) * sin(omp) * cos(i);
    R(1, 2) = -cos(omg) * sin(omp) - sin(omg) * cos(omp) * cos(i);
    R(1, 3) = sin(omg) * sin(i);
    R(2, 1) = sin(omg) * cos(omp) + cos(omg) * sin(omp) * cos(i);
    R(2, 2) = -sin(omg) * sin(omp) + cos(omg) * cos(omp) * cos(i);
    R(2, 3) = -cos(omg) * sin(i);
    R(3, 1) = sin(omp) * sin(i);
    R(3, 2) = cos(omp) * sin(i);
    R(3, 3) = cos(i);

    % Convert perifocal coordinates to ECI coordinates
    r = R * [xper; yper; 0];
    v = R * [xdotper; ydotper; 0];
end

function E = M2E(M, e)
    % Solve Kepler's equation to find the eccentric anomaly (E) from the mean anomaly (M)
    i = 0;
    tol = 1e-10;
    err = 1;
    E = M + e * cos(M); % Initial guess for E

    % Iteratively improve the value of E using Newton-Raphson method
    while err > tol && i < 100
        i = i + 1;
        Enew = E - (E - e * sin(E) - M) / (1 - e * cos(E));
        err = abs(E - Enew);
        E = Enew;
    end
end

function M = E2M(E, e)
    % Convert eccentric anomaly (E) to mean anomaly (M)
    if e < 1
        % Ellipse case: E is the eccentric anomaly
        M = E - e * sin(E);
    else
        % Hyperbola case: E is the Gudermannian
        M = e * tan(E) - log(tan(E/2 + pi/4));
    end
end 

function [r, v] = CUSTOMeph(jd, epoch, keplerian, flag)
    global AU mu %#ok<GVMIS>
    
    muSUN = mu(11);
    a = keplerian(1) * AU; % Semi-major axis in km
    e = keplerian(2);      % Eccentricity
    i = keplerian(3);      % Inclination in degrees
    W = keplerian(4);      % Longitude of the ascending node in degrees
    w = keplerian(5);      % Argument of perigee in degrees
    M = keplerian(6);      % Mean anomaly in degrees

    jdepoch = mjd2jed(epoch); % Convert the epoch from MJD to Julian Ephemeris Date (JED)
    DT = (jd - jdepoch) * 60 * 60 * 24; % Time difference between JD and epoch in seconds

    n = sqrt(muSUN / a^3); % Mean motion (angular speed) in rad/s
    M = M / 180 * pi;      % Convert mean anomaly to radians
    M = M + n * DT;        % Calculate the mean anomaly at the given JD
    M = mod(M, 2 * pi);    % Wrap the mean anomaly to the range [0, 2*pi]

    E = M2E(M, e); % Calculate the eccentric anomaly from the mean anomaly

    % Convert the Keplerian orbital elements to position and velocity vectors
    [r, v] = par2IC([a, e, i/180*pi, W/180*pi, w/180*pi, E], muSUN);

    if flag ~= 1
        r = r / AU; % Convert position from km to AU
        v = v * 86400 / AU; % Convert velocity from km/s to AU/day
    end
end

function jd = mjd20002jed(mjd2000)
    jd = mjd2000 + 2451544.5;
end

function jd = mjd2jed(mjd)
    jd = mjd + 2400000.5;
end
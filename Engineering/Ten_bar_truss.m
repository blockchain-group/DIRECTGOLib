function y = Ten_bar_truss(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Ten_bar_truss.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 524.4507606466003
%   x* = [0.003513223338920; 0.001471431015731; 0.003513223374772;...
%         0.001471431057854; 6.450000000000295e-05; 4.558940565703403e-04;...
%         0.002370087785949; 0.002370087913929; 0.001241792710714; 0.001241792534625];
%    
% Problem Properties:
%   n  = 10;
%   #g = 3;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 10;
    y.ng = 3;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = function_fitness(x);
end

function [c, ceq] = ConFun(x)
    % If x is given as a row vector, convert it to a column vector
    if size(x, 1) > size(x, 2)
        x = x';
    end
    
    % Constants and parameters
    E = 6.98e10;
    A = x;
    rho = 2770;
    addedMass = 454;
    gcoord = [18.288, 18.288, 9.144, 9.144, 0, 0; 9.144, 0, 9.144, 0, 9.144, 0];
    element = [3, 1, 4, 2, 3, 1, 4, 3, 2, 1; 5, 3, 6, 4, 4, 2, 5, 6, 3, 4]; 
    sdof = length(gcoord) * 2;
    
    % Calculate stiffness matrix K and mass matrix M
    [K, M] = Cal_K_and_M(gcoord, element, A, rho, E);
    
    % Add added mass to the diagonal of M
    for idof = 1:sdof
        M(idof, idof) = M(idof, idof) + addedMass;
    end
    
    % Boundary condition DOFs
    bcdof = [(5:6) * 2 - 1, (5:6) * 2];
    
    % Calculate eigenvalues (omega^2) and eigenmodes
    omega_2 = eigens(K, M, bcdof);
    
    % Calculate natural frequencies (f)
    f = sqrt(omega_2) / 2 / pi;
    
    % Constraints
    c(1) = 7 / f(1) - 1; 
    c(2) = 15 / f(2) - 1; 
    c(3) = 20 / f(3) - 1; 
    
    % No equality constraints
    ceq = [];
end


function xl = get_xl(nx)
    xl = 0.645e-4*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 50e-4*ones(nx, 1); 
end

function fmin = get_fmin(~)
    fmin = 524.4507606466003;
end

function xmin = get_xmin(~)
    xmin = [0.003513223338920; 0.001471431015731; 0.003513223374772;...
        0.001471431057854; 6.450000000000295e-05; 4.558940565703403e-04;...
        0.002370087785949; 0.002370087913929; 0.001241792710714; 0.001241792534625];
end

function Weight = function_fitness(section)
    % Variable assignments
    A = section;
    rho = 2770;
    Weight = 0;
    gcoord = [18.288, 18.288, 9.144, 9.144, 0, 0; 9.144, 0, 9.144, 0, 9.144, 0];
    element = [3, 1, 4, 2, 3, 1, 4, 3, 2, 1; 5, 3, 6, 4, 4, 2, 5, 6, 3, 4];

    % Calculate the weight
    for i = 1:length(element)
        nd = element(:, i);
        x = gcoord(1, nd);
        y = gcoord(2, nd);
        le = sqrt((x(2) - x(1))^2 + (y(2) - y(1))^2);
        Weight = Weight + rho * le * A(i);
    end
end

function [K, M] = Cal_K_and_M(gcoord, element, A, rho, E)
    % Calculate the number of elements (nel) and nodes (nnode)
    nel = length(element);
    nnode = length(gcoord);

    % Initialize variables
    ndof = 2;
    sdof = nnode * ndof;
    K = zeros(sdof, sdof);
    M = zeros(sdof, sdof);

    % Calculate element stiffness matrix K and mass matrix M
    for iel = 1:nel
        nd = element(:, iel);
        x = gcoord(1, nd);
        y = gcoord(2, nd);
        le = sqrt((x(2) - x(1))^2 + (y(2) - y(1))^2);
        l_ij = (x(2) - x(1)) / le;
        m_ij = (y(2) - y(1)) / le;
        Te = [l_ij, m_ij, 0, 0; 0, 0, l_ij, m_ij];
        ke = A(iel) * E / le * [1, -1; -1, 1];
        ke = Te' * ke * Te;
        MM = [2, 0, 1, 0; 0, 2, 0, 1; 1, 0, 2, 0; 0, 1, 0, 2];
        me = rho * le * A(iel) * MM / 6;
        index = [2 * nd(1) - 1, 2 * nd(1), 2 * nd(2) - 1, 2 * nd(2)];
        K(index, index) = K(index, index) + ke;
        M(index, index) = M(index, index) + me;
    end
end

function L = eigens(K, M, b)
    [~, nd] = size(K);
    fdof = (1:nd)';
    
    % Get free and prescribed degrees of freedom
    pdof = b(:);
    fdof(pdof) = [];
    
    % Calculate eigenvalues
    d = eig(K(fdof, fdof), M(fdof, fdof));
    
    % Sort and assign eigenvalues to L
    L = sort(d);
end
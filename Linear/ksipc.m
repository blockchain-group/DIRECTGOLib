function [c, ceq] = ksipc( x )
    m = 20;
    c = zeros(1, m);
    for i = 1:m
        for j = 1:length(x)
            c(i) = c(i) + (sin(i/m) - (i/m)^(j - 1)*x(j));
        end
    end
    ceq = [];
end
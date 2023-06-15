function [c, ceq] = expfitbc( x )
    R  = 51;
    T  = arrayfun(@(i) 5*(i-1)/(R-1), 1:R)';
    ET = arrayfun(@(i) exp(T(i)), 1:R)';
    c(1) = sum(arrayfun(@(i) -(x(1)+x(2)*T(i)+x(3)*T(i)^2 - (T(i)-5)*ET(i)*x(5) - (T(i)-5)^2*ET(i)*x(4) -ET(i)), 1:R));
    c(2) = sum(arrayfun(@(i) -((T(i)-5)*x(5) + (T(i)-5)^2*x(4)+0.99999), 1:R));
    ceq = [];
end
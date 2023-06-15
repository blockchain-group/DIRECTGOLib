function [c, ceq] = s279c( x )
    if size(x, 2) > size(x, 1)
        x = x'; 
    end
    N = 8;
    A = zeros(N, N);
    b = zeros(1, N);
    for i = 1:N
        for j = 1:N
            A(i, j) = 1/(i + j - 1);
            b(i) = b(i) + 1/(i + j - 1);
        end
    end
    c(1) = -(sum(A(1, :)*x) - b(1));
    c(2) = -(sum(A(2, :)*x) - b(2));
    c(3) = -(sum(A(3, :)*x) - b(3));
    c(4) = -(sum(A(4, :)*x) - b(4));
    c(5) = -(sum(A(5, :)*x) - b(5));
    c(6) = -(sum(A(6, :)*x) - b(6));
    c(7) = -(sum(A(7, :)*x) - b(7));
    c(8) = -(sum(A(8, :)*x) - b(8));
    ceq = [];
end
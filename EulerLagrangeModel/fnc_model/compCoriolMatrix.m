function [C] = compCoriolMatrix(InertiaMatrix,q,qp)
%CORIOLMATRIX Summary of this function goes here
%   Detailed explanation goes here
disp('Creating Coriolis Matrix')
disp('...computing...')
disp('Obtaining Christofel Symbols of First Kind')
M = InertiaMatrix;

for i=1:1:length(q)
    for j = 1:1:length(q)
        for k = 1:1:length(q)
            i
            j
            k
            c(i,j,k) = simplify(0.5*(diff(M(k,j),q(i)) + diff(M(k,i),q(j))- diff(M(i,j),q(k))),3);
        end     
    end
end

C = sym(zeros(length(q),length(q))); %Matriz de Coriolis
 disp('...computing...')
 disp('-> Coriolis Matrix:')

for k =1:1:length(q)
    for j = 1:1:length(q)
        for i = 1:1:length(q)
            C(k,j) = C(k,j) + c(i,j,k)*qp(i);
        end
    end
end

 C = simplify(C,10);
end


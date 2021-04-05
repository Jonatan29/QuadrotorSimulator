function [M] = compInertiaMatrix(MassCell,LinJacobianCell,AngJacobianCell,OrientationCell,InertiaTensorCell,nq)
%INERTIAMATRIX Summary of this function goes here
%   Detailed explanation goes here
disp('Creating Inertia Matrix')
disp('...computing...')
disp('-> Inertia Matrix:')
somaM = zeros(nq,nq);
for i =1:1:size(MassCell,1)
m = MassCell{i}*LinJacobianCell{i}'*LinJacobianCell{i} + AngJacobianCell{i}'*OrientationCell{i}*InertiaTensorCell{i}*OrientationCell{i}'*AngJacobianCell{i};
somaM = somaM + m;
end
M = somaM;
 disp('[SIMPLIFYING]Simplifying Inertia Matrix[SIMPLIFYING]')
M = simplify(M);
end


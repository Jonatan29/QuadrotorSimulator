function [G] = compGravMatrix(MassCell,GravityVec,CmPositionCell,q)
%GRAVMATRIX Summary of this function goes here
%   Detailed explanation goes here
disp('Creating Gravity Matrix')
disp('...computing...')
disp('-> Gravity Matrix:')
P = 0;
for i = 1:1:size(CmPositionCell,1)
p = MassCell{i}*GravityVec'*CmPositionCell{i};
P = P + p;
end
 disp('[SIMPLIFYING]Simplifying Gravity Vector[SIMPLIFYING]')
for j = 1:1:length(q)
            G(j,1) = -simplify(diff(P,q(j)),100);
end
end


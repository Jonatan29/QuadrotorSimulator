function [ Ry ] = Roty( ang )
%ROTY Summary of this function goes here
%   Detailed explanation goes here
%ang = deg2rad(ang);
Ry = [cos(ang),0,sin(ang);0,1,0;-sin(ang),0,cos(ang)];
end


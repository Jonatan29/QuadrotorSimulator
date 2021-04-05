function [ Rz ] = Rotz( ang )
%ROTZ Summary of this function goes here
%   Detailed explanation goes here
%ang = deg2rad(ang);
Rz = [cos(ang),-sin(ang),0;sin(ang),cos(ang),0;0,0,1];
end


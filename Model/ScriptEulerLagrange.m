%% Add to path the General Functions
addpath('..\fnc_general')
%% Define Symbolic Variables
syms phi theta psi real
syms phip thetap psip real
syms xcm ycm zcm real
syms x y z real
syms xp yp zp real
syms xpp ypp zpp real
syms m Ixx Ixy Ixz Iyy Iyz Izz real
syms b  real %coeficiente dos motores e local ang vel dos motores
syms k_coef l real % torsion constant and distance between the rotors and the center of rotation

Xi = [x;y;z];
Etap = [phip;thetap;psip];
%% Define Inertia Symbolic Parameters
% InertiaBody = blkvar; % Usar blkvar da pau
% InertiaBody(1,1) = Ixx;
% InertiaBody(1,2) = Ixy;
% InertiaBody(1,3) = Ixz;
% InertiaBody(2,2) = Iyy;
% InertiaBody(2,3) = Iyz;
% InertiaBody(3,3) = Izz;
InertiaBody = [Ixx Ixy Ixz;...
              Ixy Iyy Iyz; ...
              Ixz Iyz Izz];
InertiaTensorCell = cell({InertiaBody});
%% Define Generalized Coordinates
q = [x;y;z;phi;theta;psi];
qp = [xp;yp;zp;phip;thetap;psip];
nq = length(q);
%% Rotation Matrices
Rx = Rotx(phi);
Ry = Roty(theta);
Rz = Rotz(psi);
%% Orientation Matrix wrt Inertial Frame
RIB = Rz*Ry*Rx;
OrientationCell = cell({RIB});
%% Tilt Angle in x-Axis
syms beta
%% Euler Matrix
Wn = [1 0 -sin(theta); 0 cos(phi) sin(phi)*cos(theta); 0 -sin(phi) cos(phi)*cos(theta)];
%% Position Center of Mass wrt Inertial
dBc1 = [xcm;ycm;zcm];
pIC1 = RIB*dBc1 + Xi;
CmPositionCell = cell({pIC1});
 %% For Analytical - Velocities wrt Inertial Frame
 addpath('fnc_model')
 Jvc1 = AnalyticJacobian(pIC1,q);
 LinJacobianCell = cell({Jvc1});

 WIC1 = RIB*Wn*Etap;
 Jwc1 = AnalyticJacobian(WIC1,qp);
 AngJacobianCell = cell({Jwc1});

 %% Euler Lagrange Matrices - Gravity Matrix
 disp('+++++++++++++++++++GRAVITY VECTOR+++++++++++++++++++++')
 disp('--> Computing Gravity Vector:')
 MassCell = {m};
 syms g real
 GravityVec = [0;0;g];
 G_q = simplify(compGravMatrix(MassCell,GravityVec,CmPositionCell,q),3);
disp(G_q)
disp('--> Gravity Vector Computed!')
disp('--> Saving to file OutG.txt in EulerLagrangeMatrices folder.')
 dlmwrite('OutEulerLagrangeMatrices\OutG.txt',char(G_q),'delimiter','');
 disp('++++++++++++++++++++++++++++++++++++++++++++++++++++')

 %% Euler Lagrange Matrices - Inertia Matrix
  disp('+++++++++++++++++++INERTIA MATRIX+++++++++++++++++++++')
 disp('--> Computing Inertia Matrix:')
 InertiaMatrix = compInertiaMatrix(MassCell,LinJacobianCell,AngJacobianCell,OrientationCell,InertiaTensorCell,nq);
 disp('--> Inertia Matrix Computed!')
 disp(InertiaMatrix)
disp('--> Saving to file OutM.txt in EulerLagrangeMatrices folder.')
 dlmwrite('OutEulerLagrangeMatrices\OutM.txt',char(InertiaMatrix),'delimiter','');
 disp('++++++++++++++++++++++++++++++++++++++++++++++++++++')
  %% Euler Lagrange Matrices - Coriolis Matrix
    disp('+++++++++++++++++++CORIOLIS MATRIX+++++++++++++++++++++')
 disp('--> Computing Coriolis Matrix:')
  CoriolisMatrix = compCoriolMatrix(InertiaMatrix,q,qp);
   disp('--> Coriolis Matrix Computed!')
 disp(CoriolisMatrix)
disp('--> Saving to file OutC.txt in EulerLagrangeMatrices folder.')
  dlmwrite('OutEulerLagrangeMatrices\OutC.txt',char(CoriolisMatrix),'delimiter','');
  disp('++++++++++++++++++++++++++++++++++++++++++++++++++++')
 
 
 
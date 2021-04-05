function [] = fnc_PlotResults(X,Xref,U,time)
%% Plots States and Reference
figure
subplot(2,2,1)
    plot(time,X(:,1),'r',time,Xref(:,1),'--r',...
        time,X(:,2),'b',time,Xref(:,2),'--b',...
        time,X(:,3),'g',time,Xref(:,3),'--g')
    xlim([0 time(end)])
    xlabel('time')
    ylabel('xyz')
    legend('x','x_r','y','y_r','z','z_r')
    grid on
subplot(2,2,2)
    plot(time,X(:,4),'r',time,Xref(:,4),'--r',...
        time,X(:,5),'b',time,Xref(:,5),'--b',...
        time,X(:,6),'g',time,Xref(:,6),'--g')
    xlim([0 time(end)])
    xlabel('time')
    ylabel('\phi\theta\psi')
    legend('\phi','\phi_r','\theta','\theta_r','\psi','\psi_r')
     grid on
subplot(2,2,3)
    plot(time,X(:,7),'r',time,Xref(:,7),'--r',...
        time,X(:,8),'b',time,Xref(:,8),'--b',...
        time,X(:,9),'g',time,Xref(:,9),'--g')
    xlim([0 time(end)])
    xlabel('time')
    ylabel('xpypzp')
    legend('xp','xp_r','yp','yp_r','zp','zp_r')
     grid on
subplot(2,2,4)
    plot(time,X(:,10),'r',time,Xref(:,10),'--r',...
        time,X(:,11),'b',time,Xref(:,11),'--b',...
        time,X(:,12),'g',time,Xref(:,12),'--g')
    xlim([0 time(end)])
    xlabel('time')
    ylabel('\phip\thetap\psip')
    legend('\phip','\phip_r','\thetap','\thetap_r','\psip','\psip_r')
     grid on
suptitle('Compare Results w/ Reference')
set(gcf,'color','w');
%% Plots Control Inputs
figure
subplot(2,2,1)
    plot(time,U(:,1),'r')
    grid on
    xlim([0 time(end)])
    xlabel('time')
    ylabel('f_3')
subplot(2,2,2)
    plot(time,U(:,2),'r')
    grid on
     xlim([0 time(end)])
    xlabel('time')
    ylabel('f_4')
subplot(2,2,3)
    plot(time,U(:,3),'r')
    grid on
     xlim([0 time(end)])
    xlabel('time')
    ylabel('f_1')
subplot(2,2,4)
    plot(time,U(:,4),'r')
    grid on
    xlim([0 time(end)])
    xlabel('time')
    ylabel('f_2')
set(gcf,'color','w');
suptitle('Control Inputs')
%% Plots 3D Trajectory
figure
plot3(X(:,1),X(:,2),X(:,3),'r')
hold on
plot3(Xref(:,1),Xref(:,2),Xref(:,3),'--b')
grid on
set(gcf,'color','w');
legend('Real Trajectory','Reference Trajectory')
xlabel('x')
ylabel('y')
zlabel('z')
title('Quadrotor Performance')
end


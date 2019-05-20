clear all
close all


data = importdata('Al_forces.txt',' ',0);
%x=data(:,1);
y=data(:,2);
z=data(:,3).*(-1);

%xy=sqrt( x.^2 + y.^2 ); % pythagoraan lause
z_force=0.05;
y_force=mean(y);

mu=-y_force/z_force

lm = fitlm(z,y,'linear');
tspace = linspace(0,1,100)';
[ypred,yci] = predict(lm,tspace,'Alpha',0.01);


plot(lm)
% ,'x--','Color',[86.3, 0, 42.4]./100,'LineWidth',1.6

xlabel('Load $N$','interpreter','latex')
ylabel('Friction force $F$','interpreter','latex')
title('Friction with liquid lubrication ($Hg$)','interpreter','latex')
%legend('','','','location','SouthEast')
grid on

print('kitka','-dpng')

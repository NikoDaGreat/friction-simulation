clear all
close all


data = importdata('Al_forces.txt',' ',0);
%x=data(:,1);
y=data(:,2);
z=data(:,3).*(-1);

%xy=sqrt( x.^2 + y.^2 ); % pythagoraan lause


lm = fitlm(z,y,'linear');
tspace = linspace(0,1,100)';
[ypred,yci] = predict(lm,tspace,'Alpha',0.01);


plot(lm)
% ,'x--','Color',[86.3, 0, 42.4]./100,'LineWidth',1.6

xlabel('Load $N$')
ylabel('Friction force $F$')
title('Kisulin namujen m{\"a}{\"a}r{\"a} ajan funktiona')
legend('Trendik{\"a}yr{\"a}','Lineaarinen sovite','$99\%$-luottamusv{\"a}lit','location','SouthEast')
grid on

print('kitka','-dpng')

clear all
close all


data = importdata('Al_forces.txt',' ',0);
%x=data(:,1);
y=data(:,2);
z=data(:,3).*(-1);

%xy=sqrt( x.^2 + y.^2 ); % pythagoraan lause


lm = fitlm(z,y,'linear');
%[ypred,yci] = predict(lm,tspace,'Alpha',0.01);


plot(lm)


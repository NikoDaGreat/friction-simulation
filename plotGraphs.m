clear all
close all

%Editoi tätä listaa kun haluat skannata eri nimisiä tiedostoja.
forces = [0.00 0.01]
for currentForce = forces
    txt = sprintf('%.2f', currentForce);
    data = importdata(strcat(strcat('Al_forces_', txt),'.txt'),' ',0);
   
    
    %x=data(:,1);
    y=data(:,2);
    z=data(:,3).*(-1);
    time=25.*(1:length(y));
    
    figure
    subplot(2,1,1)
    plot(time,y,'r.');hold on;plot(time,z,'k*');grid on;xlabel('Aika (fs)');ylabel('Voima (eV/Å)')
    legend('Y','Z');
    
    subplot(2,1,2)
    plot(time,y,'r-');grid on;xlabel('Aika (fs)');ylabel('Voima (eV/Å)')
    legend('Y')
    
    
    %xy=sqrt( x.^2 + y.^2 ); % pythagoraan lause
    z_force=mean(z);
    y_force=mean(y);

    mu=-y_force/z_force
    % 
    % lm = fitlm(z,y,'linear');
    % tspace = linspace(0,1,100)';
    % [ypred,yci] = predict(lm,tspace,'Alpha',0.01);
    % plot(lm)
    % % ,'x--','Color',[86.3, 0, 42.4]./100,'LineWidth',1.6
    % 
    % xlabel('Load $N$','interpreter','latex')
    % ylabel('Friction force $F$','interpreter','latex')
    % title('Friction with liquid lubrication ($Hg$)','interpreter','latex')
    % %legend('','','','location','SouthEast')
    % grid on

    %print('kitka','-dpng')
    %writematrix(,mu)
    save(strcat(strcat('mu_', txt),'.txt'), 'mu', '-ASCII','-append');
end

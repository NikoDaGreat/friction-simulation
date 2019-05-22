% Laskee kitkakertoimen forces-datasta ja tallentaa tiedostoon
clear all
close all

% Editoi t�t� listaa kun haluat skannata eri nimisi� tiedostoja.
forces = [0.00 0.01 0.02 0.03 0.04 0.05 0.06];
for currentForce = forces
    txt = sprintf('%.2f', currentForce);
    data = importdata(strcat(strcat('Al_forces_', txt),'.txt'),' ',0);


    %x=data(:,1);
    y=data(:,2);
    z=data(:,3).*(-1);
    time=25.*(1:length(y));

    figure
    subplot(2,1,1)
    plot(time,y,'r.');hold on;plot(time,z,'k*');grid on;xlabel('Time (fs)');ylabel('Force (eV/�)')
    legend('Y','Z'); title(strcat(strcat('Load ', txt), ' (eV/�)'));


    subplot(2,1,2)
    plot(time,y,'r-');grid on;xlabel('Time (fs)');ylabel('Force (eV/�)')
    legend('Y');

    print(strcat(strcat('kuvaaja_', txt),'.png'),'-dpng')

    z_force=mean(z);
    y_force=mean(y);

    mu=-y_force/z_force

    save(strcat(strcat('mu_', txt),'.txt'), 'mu', '-ASCII','-append');
end

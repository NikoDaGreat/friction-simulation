% Laskee kitkakertoimen forces-datasta ja tallentaa tiedostoon
clear all
close all

% Editoi t???t??? listaa kun haluat skannata eri nimisi??? tiedostoja.
forces = [0.0100, 0.0200, 0.0300, 0.0400, 0.0500, 0.0600];
%forces = [0.10 0.15 0.20];
for currentForce = forces
    txt = sprintf('%.2f', currentForce);
    data = importdata(strcat(strcat('Al_forces_', txt),'.txt'),' ',0);

    %x=data(:,1);
    y=data(:,2);
    z=data(:,3).*(-1);
    time=25.*(1:length(y));

    figure
    subplot(2,1,1)
    plot(time,z,'k-');grid on;xlabel('Time (fs)');ylabel('Force (eV/\AA)')
    legend('Y','Z'); title(strcat(strcat('Load \,', txt), ' (eV/\AA)'));


    subplot(2,1,2)
    plot(time,y,'r-');grid on;xlabel('Time (fs)');ylabel('Force (eV/\AA)')
    legend('Y');

    print(strcat(strcat('kuvaaja_', txt),'.png'),'-dpng')

    z_force=mean(z);
    y_force=mean(y);

    mu=-y_force/z_force % t?m? jos z parempi kuin currentForce
    %mu=y_force/currentForce

    save(strcat(strcat('mu_', txt),'.txt'), 'mu', '-ASCII'); %,'-append');
end

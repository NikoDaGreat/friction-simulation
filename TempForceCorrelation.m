% Laskee kitkakertoimen forces-datasta ja tallentaa tiedostoon
clear all
close all

% Editoi tï¿½tï¿½ listaa kun haluat skannata eri nimisiï¿½ tiedostoja.
forces = [0.01 0.02 0.03 0.04 0.05 0.06];
corrcoefs=[];
for currentForce = forces
    txt = sprintf('%.2f', currentForce);
    energy_data = importdata(strcat(strcat('energy_', txt),'.txt'),' ',0);
    force_data = importdata(strcat(strcat('Al_forces_', txt),'.txt'),' ',0);

    potential=energy_data(:,1);
    kinetic=energy_data(:,2);
    total=energy_data(:,3);
    temperature=energy_data(:,4);
    

    %x=force_data(:,1);
    y=force_data(:,2);
    z=force_data(:,3).*(-1);
    
    
    energy_time=25.*(1:length(energy_data(:,1)));
    force_time=25.*(1:length(y));
    
    
    time_end=min(length(energy_data(:,1)), length(force_data(:,2)));
    time_vector=25.*(1:time_end);
    
    %Create correlation plot of abs(net force) and temperature
    net_force=abs(y(1:time_end))+abs(z(1:time_end));
    
    figure
    subplot(2,1,1)
    plot(net_force,temperature(1:time_end), 'k.');grid on;
    ylabel('Temperature (K)');xlabel('Sum of Forces (eV/Å)');
    legend('Correlation');title(strcat(strcat('Load ', txt), ' (eV/Å)'));
    
    subplot(2,1,2)
    plot(time_vector,net_force, 'r.');grid on;
    ylabel('Force (eV/Å)');xlabel('Time (fs)'); legend('Sum of Forces')
    
    correlation=corrcoef(net_force, temperature(1:time_end));
    corrcoefs(end+1)=correlation(1,2);
    print(strcat(strcat('correlation_', txt),'.png'),'-dpng')

end

figure
plot(forces, corrcoefs, 'k*', 'MarkerSize', 12, 'LineWidth', 2);grid on; ylabel('Correlation coefficient');xlabel('Load (eV/Ã…)');
title('Correlation of temperature and net force');legend('Correlation coefficient');ylim([-1 1])
print(strcat('correlation_plot', '.png'),'-dpng')

% Laskee kitkakertoimen forces-datasta ja tallentaa tiedostoon
clear all
close all

% Editoi tï¿½tï¿½ listaa kun haluat skannata eri nimisiï¿½ tiedostoja.
forces = [0.01 0.02 0.03 0.04 0.05 0.06];
for currentForce = forces
    txt = sprintf('%.2f', currentForce);
    data = importdata(strcat(strcat('energy_', txt),'.txt'),' ',0);


    potential=data(:,1);
    kinetic=data(:,2);
    total=data(:,3);
    temperature=data(:,4);
    
    time=25.*(1:length(data(:,1)));

    figure %plot temperature data
    subplot(2,2,1)
    plot(time,temperature,'r.');grid on;xlabel('Time (fs)');ylabel('Temperature (K)')
    legend('Temperature'); title(strcat(strcat('Load ', txt), ' (eV/Å)'));


    subplot(2,2,2) %plot smoothened temperature data
    sm_temp=smooth(temperature);
    plot(time,sm_temp,'r-');grid on;xlabel('Time (fs)');ylabel('Temperature (K)')
    legend('Smoothened Temperature');


    subplot(2,2,3) %plot even smoother temperature data
    sm_sm_temp=smooth(smooth(temperature));
    plot(time,sm_sm_temp,'r-');grid on;xlabel('Time (fs)');ylabel('Temperature (K)')
    legend('2x Smoothened Temperature');

    subplot(2,2,4) %plot loess-smoothened temperature data
    loess_temp=smooth(temperature,'loess');
    plot(time,loess_temp,'r-');grid on;xlabel('Time (fs)');ylabel('Temperature (K)')
    legend('Loess-smoothened Temperature');



    print(strcat(strcat('temperature_', txt),'.png'),'-dpng')
end


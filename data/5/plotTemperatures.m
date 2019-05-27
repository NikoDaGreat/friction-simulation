% Laskee kitkakertoimen forces-datasta ja tallentaa tiedostoon
clear all
close all

% Editoi t�t� listaa kun haluat skannata eri nimisi� tiedostoja.
forces = [0.01 0.02 0.03 0.04 0.05 0.06];
for currentForce = forces
    txt = sprintf('%.2f', currentForce);
    data = importdata(strcat(strcat('energy_', txt),'.txt'),' ',0);


    potential=data(:,1);
    kinetic=data(:,2);
    total=data(:,3);
    temperature=data(:,4);
    
    time=25.*(1:length(data(:,1)));
    velocity=0.005; %A/fs
    atom_point=4.046/velocity;
    
    n_lines=ceil(time(end)/atom_point);

   
    figure
    %plot even smoother temperature data
    sm_sm_temp=smooth(smooth(temperature));
    plot(time,sm_sm_temp,'r-', 'Linewidth',2);grid on;xlabel('Time (fs)');ylabel('Temperature (K)')
    hold on;ylim([min(temperature) max(temperature)]);
    for index=1:n_lines
        line([index*atom_point index*atom_point], [0 2000])
    end
    legend('2x Smoothened Temperature', 'Markers for atoms');
    title(strcat(strcat('Load ', txt), ' (eV/?)'));

 

    print(strcat(strcat('temperature_', txt),'.png'),'-dpng')
end


% plottaa eri kitkakertoimet eri loadeilla
close all
clear all

forces = [0.00 0.01 0.02 0.03 0.04 0.05 0.06];
mus=[];
for currentForce = forces
    txt = sprintf('%.2f', currentForce);
    mus(end+1) = importdata(strcat(strcat('mu_', txt),'.txt'),' ',0);
end


figure
plot(forces,mus,'o--');hold on;grid on;xlabel('Force (eV/???)');ylabel('Friction coefficient ($\mu$)')
legend('Data points'); title('Simulation friction coefficients');

print('fricCoeffs','-dpng')

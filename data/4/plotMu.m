% plottaa eri kitkakertoimet eri loadeilla
close all
clear all

%forces = [0.00 0.01 0.02 0.03 0.04 0.05 0.06];
forces = [0, 0.0100, 0.0200, 0.0300, 0.0400, 0.0500, 0.0600];%, 0.0700, 0.0800, 0.0900, 0.1000];

mus=[];
for currentForce = forces
    txt = sprintf('%.2f', currentForce);
    mus(end+1) = importdata(strcat(strcat('mu_', txt),'.txt'),' ',0);
end


figure
plot(forces,abs(mus),'o--');hold on;grid on;xlabel('Force (eV/???)');ylabel('Friction coefficient ($\mu$)')
legend('Data points'); title('Simulation friction coefficients');

print('fricCoeffs','-dpng')

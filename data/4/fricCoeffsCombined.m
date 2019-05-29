% subpoltteihin fric coeffit
close all

figure
subplot(2,1,1)
plot(forces(1:7),abs(mus(1:7)),'ro--','lineWidth',1.7);hold on;grid on;xlabel('Force (eV/\AA)');ylabel('Friction coefficient ($\mu$)')
legend('Data points','location','NorthWest'); title('Friction coefficient with lubricant', 'interpreter', 'latex');

subplot(2,1,2)
plot(forces(1:7),abs(musei(1:7)),'ro--','lineWidth',1.7);hold on;grid on;xlabel('Force (eV/\AA)');ylabel('Friction coefficient ($\mu$)')
legend('Data points'); title('Friction coefficient with no lubricant', 'interpreter', 'latex');


print('fricCoeffsCombined','-dpng')
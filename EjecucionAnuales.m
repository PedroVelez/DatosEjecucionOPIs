clear all;close all
load('Ejecucion')

ColorO = parula(7);
%% Total ejecucion (Me) \n gastos corrientes en bienes y servicios e inversiones reales OPIS no CSIC
figure
for iOPI=2:6
    plot(anho,PagosRealizados(:,iOPI,4)/1000,'-','color',ColorO(iOPI,:),'linewidth',2);hold on
end
set(gca,'XTick',[2013 2014 2015 2016 2017 2018 2019])
HL=legend(tOPI(2:6,:),'Location','Northwest');set(HL,'fontsize',12)
grid on
ylabel('Millones euros')
xlabel('Ejercicio')
set(gca,'Fontsize',14,'Fontname','Cambria')
title(sprintf('Total ejecucion (Me) \n gastos corrientes en bienes y servicios e inversiones reales \n OPIS no CSIC'),'Fontname','Cambria');
orient landscape
CreaFigura(gcf,strcat(mfilename,'_Plate_01'),[4 7])

figure
for iOPI=7
    plot(anho(2:end)-1,PagosRealizados_PREVIO(2:end,iOPI,4)/1000,'rs'); hold on
    plot(anho,PagosRealizados(:,iOPI,4)/1000,'-','color',ColorO(iOPI,:),'linewidth',2);
end
set(gca,'XTick',[2013 2014 2015 2016 2017 2018 2019])
HL=legend(tOPI(7),'Location','Northwest');set(HL,'fontsize',12)
grid on
ylabel('Millones euros')
xlabel('Ejercicio')
set(gca,'Fontsize',14,'Fontname','Cambria')
title(sprintf('Total ejecucion (Me) \n gastos corrientes en bienes y servicios e inversiones reales \n  CSIC'),'Fontname','Cambria');
orient landscape
CreaFigura(gcf,strcat(mfilename,'_Plate_02'),[4 7])

%Porcentaje ejecucion cap 2 y 6 (Bienes, servicios e inversiones reales)
figure
for iOPI=2:7
    plot(anho,100*(PagosRealizados(:,iOPI,4))./ CreditoTotal(:,iOPI,4),'o-','color',ColorO(iOPI,:),'linewidth',2);hold on
end
set(gca,'XTick',[2013 2014 2015 2016 2017 2018 2019])
HL=legend(tOPI(2:7),'Location','Northwest');set(HL,'fontsize',12)
grid on
ylabel('%')
xlabel('Ejercicio')
set(gca,'Fontsize',14,'Fontname','Cambria')
title(sprintf('Porcentaje de ejecucion respecto del presupuesto para el ejercicio \n en gastos corrientes en bienes y servicios e inversiones reales para los OPIS'),'Fontname','Cambria');
orient landscape
CreaFigura(gcf,strcat(mfilename,'_Plate_03'),[4 7])

figure
for iOPI=2:7
    plot(anho,100*PagosRealizados(:,iOPI,4)./CreditoTotal(1,iOPI,4),'o-','color',ColorO(iOPI,:),'linewidth',2);hold on
end
set(gca,'XTick',[2013 2014 2015 2016 2017 2018 2019])
HL=legend(tOPI(2:7),'Location','Northwest');set(HL,'fontsize',12)
grid on
ylabel('%')
xlabel('Ejercicio')
set(gca,'Fontsize',14,'Fontname','Cambria')
title(sprintf('Porcentaje de ejecucion respecto al presupuesto en 2013 \n en gastos corrientes en bienes y servicios e inversiones reales para los OPIS'),'Fontname','Cambria')
orient landscape
CreaFigura(gcf,strcat(mfilename,'_Plate_04'),[4 7])

%Ejecucion respecto a ejecucion en 2013
figure
for iOPI=2:7
    plot(anho,100*PagosRealizados(:,iOPI,4)./PagosRealizados(1,iOPI,4),'o-','color',ColorO(iOPI,:),'linewidth',2);hold on
end
set(gca,'XTick',[2013 2014 2015 2016 2017 2018 2019])
HL=legend(tOPI(2:7),'Location','Northwest');set(HL,'fontsize',12)
grid on
ylabel('%')
xlabel('Ejercicio')
set(gca,'Fontsize',14,'Fontname','Cambria')
title(sprintf('Porcentaje de ejecucion respecto al presupuesto en 2013 \n en gastos corrientes en bienes y servicios e inversiones reales para los OPIS'),'Fontname','Cambria')
orient landscape
CreaFigura(gcf,strcat(mfilename,'_Plate_05'),[4 7])


%% Imprime valores
% fprintf('   %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n',anho)
% for iOPI=1:6
%     fprintf('%s %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n',tOPI{iOPI},IRGCpo(i1,AnhosR))
% end
%
%
% fprintf('   %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n',anho)
% for iOPI=1:7
%     fprintf('%s %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n',tOPI{iOPI},IRGCpr(i1,AnhosR))
% end

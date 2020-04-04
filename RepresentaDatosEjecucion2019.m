clear all;close all

tOPI={'INTA  ';'CIEMAT';'INIA  ';'IEO   ';'IGME  ';'ISCIII';'CSIC'};

D2019=load('Ejecucion2019');
D2018=load('Ejecucion2018');

iMesfin=12;


%% Ejecucion presupuestaria en el ultimo mes
for iOPI=1:7
    EP_BSIR_FINAL2019(iOPI)=(D2019.OPI_PR(iOPI,4,iMesfin))/(D2019.OPI_CT(iOPI,4,iMesfin));
    EP_BSIR_FINAL2018(iOPI)=(D2018.OPI_PR(iOPI,4,iMesfin))/(D2018.OPI_CT(iOPI,4,iMesfin));
    EP_P_FINAL2019(iOPI)=D2019.OPI_PR(iOPI,1,iMesfin)/D2019.OPI_CT(iOPI,1,iMesfin);
    EP_P_FINAL2018(iOPI)=D2018.OPI_PR(iOPI,1,iMesfin)/D2018.OPI_CT(iOPI,1,iMesfin);
end

for iOPI=1:7
    figure
    
    hPRirbs2019=plot(squeeze(D2019.OPI_PR(iOPI,4,:))/1000,'r','linewidth',2); hold on; grid on
    hCTirbs2019=plot([0 12],[D2019.OPI_CT(iOPI,4,iMesfin) D2019.OPI_CT(iOPI,4,iMesfin)]/1000, ...
        'r:','linewidth',2);
    hPRirbs2018=plot(squeeze(D2018.OPI_PR(iOPI,4,:))/1000,'r--','linewidth',1);
    
    hPRper2019=plot(squeeze(D2019.OPI_PR(iOPI,1,:))/1000,'b','linewidth',2); hold on
    hCTper2019=plot([0 12],[D2019.OPI_CT(iOPI,1,iMesfin) D2019.OPI_CT(iOPI,1,iMesfin)]/1000,'b:','linewidth',2);
    hPRper2018=plot(squeeze(D2018.OPI_PR(iOPI,1,:))/1000,'b--','linewidth',1);
    
    Titulo=sprintf('%s mes %02d.\nEjecución IR+BS [2019 %3.1f %% 2018 %3.1f %%].\nPresupuesto IR+BS [2019 %03.1f M€ 2018 %03.1f M€] \nPresupuesto Personal [2019 %03.1f M€ 2018 %03.1f M€]', ...
        tOPI{iOPI}, ...
        iMesfin, ...
        EP_BSIR_FINAL2019(iOPI)*100, ...
        EP_BSIR_FINAL2018(iOPI)*100 , ...
        D2019.OPI_CT(iOPI,4,iMesfin)/1000, ...
        D2018.OPI_CT(iOPI,4,iMesfin)/1000, ...
        D2019.OPI_CT(iOPI,1,iMesfin)/1000, ...
        D2018.OPI_CT(iOPI,1,iMesfin)/1000);
    disp(Titulo)
    title(Titulo)
    ylabel('Millones €')
    xlabel('mes')
    
    legend([hPRirbs2019,hPRirbs2018,hCTirbs2019 , hPRper2019,hPRper2018,hCTper2019], ...
        'IR+BS pagos realizados 2019', ...
        'IR+BS pagos realizados 2018', ...
        'IR+BS creditos totales 2019', ...
        'Personal pagos realizados 2019', ...
        'Personal pagos realizados 2018', ...
        'Personal creditos totales 2019', ...
        'Location','southeast')
    legend('boxoff')
    CreaFigura(gcf,strcat(mfilename,'_',tOPI{iOPI},'_2019'),4)
end

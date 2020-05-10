clear all;close all

tOPI={'INTA  ';'CIEMAT';'INIA  ';'IEO   ';'IGME  ';'ISCIII';'CSIC'};

D2020=load('Ejecucion2020');
D2019=load('Ejecucion2019');

iMesfin=3;


%% Ejecucion presupuestaria en el ultimo mes
for iOPI=1:7
    EP_BSIR_FINAL2020(iOPI)=(D2020.OPI_PR(iOPI,4,iMesfin))/(D2020.OPI_CT(iOPI,4,iMesfin));
    EP_BSIR_FINAL2019(iOPI)=(D2019.OPI_PR(iOPI,4,iMesfin))/(D2019.OPI_CT(iOPI,4,iMesfin));
    EP_P_FINAL2020(iOPI)=D2020.OPI_PR(iOPI,1,iMesfin)/D2020.OPI_CT(iOPI,1,iMesfin);
    EP_P_FINAL2019(iOPI)=D2019.OPI_PR(iOPI,1,iMesfin)/D2019.OPI_CT(iOPI,1,iMesfin);
end

for iOPI=1:7
    figure
    
    hPRirbs2020=plot(squeeze(D2020.OPI_PR(iOPI,4,:))/1000,'r','linewidth',2); hold on; grid on
    hCTirbs2020=plot([0 12],[D2020.OPI_CT(iOPI,4,iMesfin) D2020.OPI_CT(iOPI,4,iMesfin)]/1000, ...
        'r:','linewidth',2);
    hPRirbs2019=plot(squeeze(D2019.OPI_PR(iOPI,4,:))/1000,'r--','linewidth',1);
    
    hPRper2020=plot(squeeze(D2020.OPI_PR(iOPI,1,:))/1000,'b','linewidth',2); hold on
    hCTper2020=plot([0 12],[D2020.OPI_CT(iOPI,1,iMesfin) D2020.OPI_CT(iOPI,1,iMesfin)]/1000,'b:','linewidth',2);
    hPRper2019=plot(squeeze(D2019.OPI_PR(iOPI,1,:))/1000,'b--','linewidth',1);
    
    Titulo=sprintf('%s mes %02d.\nEjecución IR+BS [2020 %3.1f %% 2019 %3.1f %%].\nPresupuesto IR+BS [2020 %03.1f M€ 2019 %03.1f M€] \nPresupuesto Personal [2020 %03.1f M€ 2019 %03.1f M€]', ...
        tOPI{iOPI}, ...
        iMesfin, ...
        EP_BSIR_FINAL2020(iOPI)*100, ...
        EP_BSIR_FINAL2019(iOPI)*100 , ...
        D2020.OPI_CT(iOPI,4,iMesfin)/1000, ...
        D2019.OPI_CT(iOPI,4,iMesfin)/1000, ...
        D2020.OPI_CT(iOPI,1,iMesfin)/1000, ...
        D2019.OPI_CT(iOPI,1,iMesfin)/1000);
    disp(Titulo)
    title(Titulo)
    ylabel('Millones €')
    xlabel('mes')
    
    legend([hPRirbs2020,hPRirbs2019,hCTirbs2020 , hPRper2020,hPRper2019,hCTper2020], ...
        'IR+BS pagos realizados 2020', ...
        'IR+BS pagos realizados 2019', ...
        'IR+BS creditos totales 2020', ...
        'Personal pagos realizados 2020', ...
        'Personal pagos realizados 2019', ...
        'Personal creditos totales 2020', ...
        'Location','southeast')
    legend('boxoff')
    CreaFigura(gcf,strcat(mfilename,'_',tOPI{iOPI},'_2020'),4)
end

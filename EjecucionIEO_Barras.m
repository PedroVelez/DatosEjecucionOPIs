clear all;close all
load EjecucionIEO
h=axes;

hb1=bar(anho(1:7)-0.17,CreditoTotal(1:7,1:9)/1000,'stacked','barwidth',.34);
hold on
hb2=bar(anho(1:7)+0.165,PagosRealizados(1:7,1:9)/1000,'stacked','barwidth',.34);

hp1=plot(anho(1:7),sum(PagosRealizados(1:7,1:9)/1000,2),'linewidth',3,'color','r','Marker','o');
hp2=plot(anho(1:7),sum(CreditoTotal(1:7,1:9)/1000,2),'linewidth',3,'color','b','Marker','o');
grid on
axis([2012.5 2019.6 0 65])
h.XTick=[2013:1:2019];


Le{1}='Cap.1 Gastos de personal';
Le{2}='Cap.2 Gastos corrientes en bienes y servicios';
Le{3}='Cap.3 Gastos financieros';
Le{4}='Cap.4 Transferencias corrientes';
Le{5}='Cap.5';
Le{6}='Cap.6 Inversiones reales';
Le{7}='Cap.7 Transferencias de capital';
Le{8}='Cap.8 Activos financieros';
Le{9}='Cap.9 Pasivos financieros';
Le{10}='Pagos realizados';
Le{11}='Creditos totales';

Colores=[0    0.0       0.9000,
    0.8500    0.3250    0.0980,
    0.9290    0.6940    0.1250,
    0.4940    0.1840    0.5560,
    0.4660    0.6740    0.1880,
    0.3010    0.7450    0.9330,
    0.6350    0.0780    0.1840,
    0.0000    0.4470    0.7410,
    0.0000    0.4470    1.000];

Colores=parula(9);
for ib=1:9
    hb1(ib).FaceColor=Colores(ib,:);
    hb2(ib).FaceColor=Colores(ib,:);
end

hL=legend([hb1,hp1,hp2],Le,'NumColumns',4);
hL.Location="southoutside";
title('Creditos totales y pagos realizados [M€]')


for anho=[2013:1:2019]
    ht1=text(anho-0.17,2,'Creditos totales')
    ht1.Rotation=90;
    ht1.Color='w';
    ht1.FontSize=16;
    
    ht2=text(anho+0.165,2,'Pagos realizados')
    ht2.Rotation=90;
    ht2.Color='w';
    ht2.FontSize=16;
end



for icap=1:9
    fprintf('%d, %7.3f, %7.3f, %7.3f \n',icap , CreditoTotal(5,icap)/1000,CreditoTotal(6,icap)/1000,CreditoTotal(7,icap)/1000);
end

for icap=1:9
    fprintf('%d, %7.3f, %7.3f, %7.3f \n',icap , PagosRealizados(5,icap)/1000,PagosRealizados(6,icap)/1000,PagosRealizados(7,icap)/1000);
end

CreaFigura(gcf,strcat(mfilename),[7 4])

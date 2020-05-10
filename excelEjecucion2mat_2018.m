clear all;close all

tOPI={'INTA  ';'CIEMAT';'INIA  ';'IEO   ';'IGME  ';'ISCIII';'CSIC'};

%% lee datos OPIS
ifilOPI=[8 79 80 81 82 83];
for imes=1:1:9
    for iOPI=1:6
        T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OAG04');
        ic=1;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
        T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OAG05');
        ic=2;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
        T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OAG08');
        ic=3;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    end
end

ifilOPI=[8 78 79 80 81 82];
for imes=7:12
    for iOPI=1:6
        T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OAG04');
        ic=1;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
        T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OAG05');
        ic=2;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
        T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OAG08');
        ic=3;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    end
end

%% lee datos CSIC
iOPI=7;

ifilOPI(iOPI)=23;
for imes=1:1:6
    T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','AEG04');
    ic=1;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    
    T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','AEG05');
    ic=2;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    
    T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','AEG08');
    ic=3;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
end

ifilOPI(iOPI)=40;
for imes=7:1:12
    T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OOG04');
    ic=1;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    
    T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OOG05');
    ic=2;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    
    T=readtable(sprintf('./2018/ORGANISMOS%02d18.xlsx',imes),'Sheet','OOG08');
    ic=3;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
end

for iOPI=1:7
    for imes=1:12
        for ic=1:3
            fprintf('mes %02d %02d %s\n',imes,ic,OPI{iOPI,imes,ic}.Var1)
        end
    end
    fprintf('\n \n \n')
end


%% Asigno valores
%1 - personmal
%2 - BS
%3 - IR
%4 - BS + IR
for ic=1:3
    for iOPI=1:7
        for imes=1:12
            OPI_CT(iOPI,ic,imes)=str2num(OPI{iOPI,imes,ic}.Var2);
            
            if strcmp(OPI{iOPI,imes,ic}.Var4,'-') == 1
                OPI_PR(iOPI,ic,imes)=0;
            else
                OPI_PR(iOPI,ic,imes)=str2num(OPI{iOPI,imes,ic}.Var4);
            end
        end
    end
end

% Sumo BSA+IR
for iOPI=1:7
    for imes=1:12
        OPI_PR(iOPI,4,imes)=OPI_PR(iOPI,2,imes)+OPI_PR(iOPI,3,imes);
        OPI_CT(iOPI,4,imes)=OPI_CT(iOPI,2,imes)+OPI_CT(iOPI,3,imes);
        
    end
end

save('Ejecucion2018','OPI_PR','OPI_CT')

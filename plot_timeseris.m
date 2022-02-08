%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ftp://nrt.cmems-du.eu/Core/INSITU_BS_NRT_OBSERVATIONS_013_034/bs_multiparameter_nrt/history/PF/

%The final objective is 
%To have a map of spatial coverage of INS data from above link
%To have a table, like the one you Farshid prepared for today discussion with total number of observations coming from INS data from the above link VS the REP dataset

%We need also to understand the issue of the Hovmoller.

%©Farshid Dartabor Apr 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear all
close all
clc
%
ncvars = {'PRES_QC', 'PRES', 'TEMP_QC', 'TEMP', 'PSAL_QC', 'PSAL'};

%ncvars = {'PRES_ADJUSTED_QC', 'PRES_ADJUSTED', ...
%    'TEMP_ADJUSTED_QC', 'TEMP_ADJUSTED', 'PSAL_ADJUSTED_QC', 'PSAL_ADJUSTED'};


Var_type = 'NRT';

%gridfile = 'D:\CMEMS_BS_QUID\Argo_Matlab\mesh_mask_bs.nc';
gridfile = 'D:\Farshid-Daryabor\d_driver\CMEMS_BS_QUID\Argo_Matlab\mesh_mask_bs.nc';
%
platform_number  = 3;

YEAR = 2019 ;

tlower='01-Jan-2019';
tupper='30-Dec-2019';

% layers: 5-10, 10-20, 20-30, 30-50, 50-75, 75-100, 100-200 m
%         200-500 and 500-1000m 
%
h_lower = 5;
h_upper = 10;

%mypath = 'D:\CMEMS_BS_QUID\bs_nrt_history_PF\Data\';
mypath = 'D:\Farshid-Daryabor\d_driver\CMEMS_BS_QUID\bs_nrt_history_PF\Data\';
ncfiles='*.nc';

[lon,lat,time,Pres,Temp,Psal,pn]=extract_unique_argo_profile(mypath,...
    ncfiles,ncvars,tlower,tupper);

for i_pn = 1 : length(pn)
    fprintf('plat_form_code=   %d %d %d  %07.0f ',    pn(i_pn));
end

%fgpath  = ['D:\CMEMS_BS_QUID\bs_nrt_history_PF\Figure\' Var_type '\'];

%fgpath  = ['D:\CMEMS_BS_QUID\bs_nrt_history_PF\Figure\' Var_type '\' num2str(YEAR,'%04.0f') '\']; 

fgpath  = ['F:\AWI-2021\groupmeeting_May\' Var_type '\' num2str(YEAR,'%04.0f') '\']; 

%

%
Time = time {platform_number};

x=lon{platform_number};
y=lon{platform_number};


P_new = Pres{platform_number};
T_new = Temp{platform_number};
S_new = Psal{platform_number};
%
%filter depth <5m
[P,T,S]=filter_desired_depth(P_new,T_new,S_new,5);
%
%sort time and data  January - December   
[date,Indx] = sort(Time);
Tem = T(:,Indx);
Pre = P(:,Indx);
Sal = S(:,Indx);
%
for jj = 1 : size(P,2)
    [t_numl(1,jj),tmean(1,jj)]=average_profile(Pre(:,jj),Tem(:,jj),h_lower,h_upper);
    [s_numl(1,jj),smean(1,jj)]=average_profile(Pre(:,jj),Sal(:,jj),h_lower,h_upper);
end    
clear jj Indx
%
total_obs = sum(t_numl);

savefile = [fgpath,'num_layer' '_' num2str(h_lower,'%04.0f') '-'  num2str(h_upper,'%04.0f') ...
    '_' num2str(pn(platform_number),'%07.0f') '.mat'];
save(savefile, 't_numl', 's_numl', 'total_obs');
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%TIME SERIES PLOT
%
fig1=figure;
set(gcf, 'Position',[100 100 800 560]);
subplot(2,1,1)
%
plot(date,tmean,'r');
xlabel('Time','fontsize',14)
ylabel('Temperature (\circC)','fontsize',14)
title({['Time Series for platform number: ', num2str(pn(platform_number),'%07.0f')],...
    ['Average in the depth of  ' num2str(h_lower,'%04.0f') '-' ...
                    num2str(h_upper,'%04.0f')   '-meter'], ['Year '   num2str(YEAR,'%04.0f') ]})
grid on
grid minor
%
            
subplot(2,1,2)
plot(date,smean,'b');
xlabel('Time','fontsize',14)
ylabel('Salinity (psu)','fontsize',14)
title({['Time Series for platform number: ', num2str(pn(platform_number),'%07.0f')],...
    ['Average in the depth of  ' num2str(h_lower,'%04.0f') '-' ...
                    num2str(h_upper,'%04.0f')   '-meter'], ['Year '   num2str(YEAR,'%04.0f') ]})
grid on
grid minor


disp('save figure in the host directory and folder')
FTS = [fgpath,'TimeSeries_' (num2str(pn(platform_number),'%07.0f')) '_' ...
    num2str(h_lower,'%04.0f') '-'  num2str(h_upper,'%04.0f') '_' num2str(YEAR,'%04.0f')];
set(fig1, 'InvertHardcopy', 'off')
saveas(fig1,sprintf('%s.jpeg',FTS))    
%saveas(fig3,FTS,'epsc2')
%

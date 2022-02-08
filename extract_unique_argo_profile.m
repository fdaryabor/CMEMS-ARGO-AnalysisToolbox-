% function [lon_out,lat_out,time_out,P_out,T_out,S_out,pn]=extract_unique_argo_profile_new(mypath,ncfiles,ncvars,tlower,tupper)
function [X,Y,TIME,PP,TT,SS,pn]=extract_unique_argo_profile_new(mypath,...
          ncfiles,ncvars,tlower,tupper)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%ftp://nrt.cmems-du.eu/Core/INSITU_BS_NRT_OBSERVATIONS_013_034/bs_multiparameter_nrt/history/PF/

%The final objective is 
%To have a map of spatial coverage of INS data from above link
%To have a table, like the one you Farshid prepared for today discussion with total number of observations coming from INS data from the above link VS the REP dataset

%We need also to understand the issue of the Hovmoller.

%mypath = 'D:\CMEMS_BS_QUID\bs_profiler_glider\';
%ncfiles = '*_3901854.nc';

%©Farshid Dartabor Apr 2020
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[lon,lat,time,P,T,S,pn]= ...
         select_date_new(mypath,ncfiles,ncvars,tlower,tupper);

%[lon,lat,T,S,P,time,pn]=argo_cmems(mypath,ncfiles,ncvars);

pn = cell2mat(pn);

%
[~, ind] = cellfun(@(aa) unique(aa, 'rows'), lon, 'uni',0);
num_files = length (lon);
lat_out = cell(num_files, 1);
lon_out = cell(num_files, 1);
time_out = cell(num_files, 1);

P_out = cell(num_files, 1);
T_out = cell(num_files, 1);
S_out = cell(num_files, 1);

for ii = 1: num_files 
    lon_out{ii}  = lon {ii} (ind {ii}) ;
    lat_out{ii}  = lat {ii} (ind {ii}) ;
    time_out{ii} = time {ii} (ind {ii}) ;
    P_out{ii}    = P {ii} (:,ind {ii}) ;
    T_out{ii}    = T {ii} (:,ind {ii}) ;
    S_out{ii}    = S {ii} (:,ind {ii}) ;
end            
%
N = max(cellfun('size',P_out,1));  
M = max(cellfun('size',P_out,2)); 

pp = cellfun(@(aa) [aa, nan(size(aa, 1), M-size(aa, 2)); ...
            nan(N-size(aa, 1), M)], P_out, 'uni' , 0);
tt = cellfun(@(aa) [aa, nan(size(aa, 1), M-size(aa, 2)); ...
            nan(N-size(aa, 1), M)],T_out, 'uni' , 0);
ss = cellfun(@(aa) [aa, nan(size(aa, 1), M-size(aa, 2)); ...
            nan(N-size(aa, 1), M)], S_out, 'uni' , 0);
%
JJ  = cellfun(@numel, lon_out); LL = max(JJ);
xx  = cellfun(@(aa) [aa; nan(LL - numel (aa), 1)], lon_out, 'uni' , 0);
yy  = cellfun(@(aa) [aa; nan(LL - numel (aa), 1)], lat_out, 'uni' , 0);
dd  = cellfun(@(aa) [aa; nan(LL - numel (aa), 1)], time_out, 'uni' , 0);
%
X = cell2mat(xx);
Y = cell2mat(yy);
TIME = cell2mat(dd);
%
PP = cell2mat(pp');
TT = cell2mat(tt');
SS = cell2mat(ss'); 
% %

% clearvars -except PP TT SS X Y TIME pn

%filter depth greater than 5(m) 
% [PRES,TEMP,PSAL]=filter_desired_depth(PP,TT,SS,5);

% % savefile = [mypath,'platform' '_' num2str(pn,'%07.0f') '.mat'];
% savefile = [mypath,'nrt' '_' num2str(year,'%04.0f') '.mat'];
% save(savefile, 'T', 'S', 'P', 'X','Y', 'TIME' ,'pn');
% %
end



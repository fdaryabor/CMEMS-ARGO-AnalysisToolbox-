function [lon,lat,TEMP_out_new,PSAL_out_new,PRES_out,...
        time,plat_form_code]=argo_cmems(mypath,ncfiles,ncvars)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pth = '~/Data_2015/'; % Replace with your path
%pth = '/Users/fdaryabor/Preliminary_runs_evaluate_against_climatologies/ARGO_ANALYSIS/201501/';
%ncfiles = 'new_*.nc'
%Files = dir(fullfile(pth, 'new_*.nc'));
%ncvars = {'PRES_QC', 'PRES', 'TEMP_QC', 'TEMP', 'PSAL_QC', 'PSAL'};
%ncvars = {'PRES_ADJUSTED_QC', 'PRES_ADJUSTED', ...
%    'TEMP_ADJUSTED_QC', 'TEMP_ADJUSTED', 'PSAL_ADJUSTED_QC', 'PSAL_ADJUSTED'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%dinfo = dir (fullfile (mypath, ncfiles ));
%num_files = length (dinfo);
%files = fullfile (mypath, {dinfo.name});

%check for exsitence variable 
files = checkout_argofiles(mypath, ncfiles, ncvars{1}); 
num_files = length (files);
%
lat = cell(num_files, 1);
lon = cell(num_files, 1);
time = cell(num_files, 1);
plat_form_code = cell(num_files, 1);

PRES_QC = cell(num_files, 1);
PRES = cell(num_files, 1);

TEMP_QC = cell(num_files, 1);
TEMP = cell(num_files, 1);

PSAL_QC = cell(num_files, 1);
PSAL = cell(num_files, 1);
%
for k = 1 : num_files
    filename  = files{k};
    lat{k}    = ncread(filename,'LATITUDE');     
    lon{k}    = ncread(filename,'LONGITUDE');        
    time{k}   = ncread(filename,'TIME');       
    plat_form_code{k} = str2double(ncreadatt(filename,'/','platform_code')'); 
    %
    disp('PRES')
    PRES_QC{k} = ncread(filename,ncvars{1});
    PRES{k}    = ncread(filename,ncvars{2});
    %
    disp('TEMP')
    TEMP_QC{k} = ncread(filename,ncvars{3});
    TEMP{k}    = ncread(filename,ncvars{4});
    scalefa    = ncreadatt(filename,ncvars{4},'scale_factor');
    %
    disp('PSAL')
    PSAL_QC{k} = ncread(filename,ncvars{5});
    PSAL{k}    = ncread(filename,ncvars{6});
end
%
P_QC=cellfun(@(x) x.*(x==1)./(x==1),PRES_QC,'Uni',false);
PRES_out=cellfun(@times,PRES,P_QC,'uni',0);
%
T_QC=cellfun(@(x) x.*(x==1)./(x==1),TEMP_QC,'Uni',false);
TEMP_out=cellfun(@times,TEMP,T_QC,'uni',0);
TEMP_out_new=cellfun(@(x) x.*double(scalefa),TEMP_out,'Uni',false);
%
S_QC=cellfun(@(x) x.*(x==1)./(x==1),PSAL_QC,'Uni',false);
PSAL_out=cellfun(@times,PSAL,S_QC,'uni',0);
PSAL_out_new=cellfun(@(x) x.*double(scalefa),PSAL_out,'Uni',false);

  
% if exist(ncvars{1},'var')
%     %Replacing bad flags from the arrays with NaN.
%     P_QC=cellfun(@(x) x.*(x==1)./(x==1),PRES_QC,'Uni',false);
%     %Extracting good data with flag 1 from arrays
%     PRES_out=cellfun(@times,PRES,P_QC,'uni',0);
% else
%     PRES_out = [];
% end
% %
% if exist(ncvars{3},'var')
%     %Replacing bad flags from the arrays with NaN.
%     T_QC=cellfun(@(x) x.*(x==1)./(x==1),TEMP_QC,'Uni',false);
%     %Extracting good data with flag 1 from arrays
%     TEMP_out=cellfun(@times,TEMP,T_QC,'uni',0);
%     if ~isempty(scalefa)
%         TEMP_out_new=cellfun(@(x) x.*double(scalefa),TEMP_out,'Uni',false);
%     else
%         TEMP_out_new=TEMP_out;
%     end
% else
%     TEMP_out_new = [];
% end
% %
% if exist(ncvars{5},'var')
%     %Replacing bad flags from the arrays with NaN.
%     S_QC=cellfun(@(x) x.*(x==1)./(x==1),PSAL_QC,'Uni',false);
%     %Extracting good data with flag 1 from arrays
%     PSAL_out=cellfun(@times,PSAL,S_QC,'uni',0);
%     if ~isempty(scalefa)
%         PSAL_out_new=cellfun(@(x) x.*double(scalefa),PSAL_out,'Uni',false);
%     else
%         PSAL_out_new=PSAL_out;
%     end
% else
%     PSAL_out_new = [];
% end
%
% N = max(cellfun('size',PRES_out,1));  
% M = max(cellfun('size',PRES_out,2)); 
% 
% P_new = cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
%             nan(N-size(x, 1), M)], PRES_out, 'uni' , 0);
% if ~isempty(TEMP_out_new)    
%     T_new = cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
%             nan(N-size(x, 1), M)], TEMP_out_new, 'uni' , 0);
% else
%     T_new = [];
% end
% %
% if ~isempty(PSAL_out_new) 
%     S_new = cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
%             nan(N-size(x, 1), M)], PSAL_out_new, 'uni' , 0);
% else
%     S_new = [];
% end
% %
% JJ = cellfun(@numel, lon); LL = max(JJ);
% X  = cellfun(@(a) [a; nan(LL - numel (a), 1)], lon, 'uni' , 0);
% Y  = cellfun(@(a) [a; nan(LL - numel (a), 1)], lat, 'uni' , 0);
% TIME = cellfun(@(a) [a; nan(LL - numel (a), 1)], time, 'uni' , 0);
%
return































































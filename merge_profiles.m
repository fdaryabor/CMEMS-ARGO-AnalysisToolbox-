function [T_new,S_new,P_new,X,Y,t,pn]=merge_profiles(mypath,matfiles,double)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%mypath = '/Users/fdaryabor/Preliminary_runs_evaluate_against_climatologies/ARGO_ANALYSIS/ARGO_CMEMS_NODC/Mean_Platforms/annual/';
%matfiles = '*.mat';
%Data{TIME} = load([mypath,'mean' '_' num2str(TIME,'%02.0f') '.mat']);
%mask = ~isnan(T_mon_new); mask = double(mask); mask(1:2,:)=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
Files = dir(fullfile(mypath, matfiles));
files = arrayfun(@(X) fullfile(mypath, X.name), Files, 'uni', 0);

for ii = 1 : length(files)
    filename = files{ii};
    A = load(filename);
    lon{ii}  = A.X;
    lat{ii}  = A.Y;
    time{ii} = A.TIME;
    pn{ii}   =   A.pn;
    T{ii}    = A.T;
    S{ii} = A.S;
    P{ii} = A.P;
end
%
pn =cell2mat(pn);
%
JJ = cellfun(@numel, lon); LL = max(JJ);
lon_new  = cellfun(@(a) [a; nan(LL - numel (a), 1)], lon, 'uni' , 0);
lat_new  = cellfun(@(a) [a; nan(LL - numel (a), 1)], lat, 'uni' , 0);
time_new = cellfun(@(a) [a; nan(LL - numel (a), 1)], time, 'uni' , 0);
%
lon_out  = cell2mat(lon_new);
lat_out  = cell2mat(lat_new); 
time_out = cell2mat(time_new); 
%
X = reshape(lon_out, [],1);
Y = reshape(lat_out, [],1);
t = reshape(time_out, [],1);
%
N = max(cellfun('size',P,1));  
M = max(cellfun('size',P,2)); 

if(double)
    P_new = cell2mat(cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
            nan(N-size(x, 1), M)], P, 'uni' , 0));
    T_new = cell2mat(cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
            nan(N-size(x, 1), M)], T, 'uni' , 0));
    S_new = cell2mat(cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
            nan(N-size(x, 1), M)], S, 'uni' , 0));
else
    P_new = (cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
            nan(N-size(x, 1), M)], P, 'uni' , 0));
    T_new = (cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
            nan(N-size(x, 1), M)], T, 'uni' , 0));
    S_new = (cellfun(@(x) [x, nan(size(x, 1), M-size(x, 2)); ...
            nan(N-size(x, 1), M)], S, 'uni' , 0));
end
return
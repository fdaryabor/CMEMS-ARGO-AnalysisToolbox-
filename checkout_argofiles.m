function files = checkout_argofiles(pth, ncfiles, varname) 
%
Files = dir(fullfile(pth, ncfiles));
files = arrayfun(@(X) fullfile(pth, X.name), Files, 'uni', 0);
for k = 1 : length(files)
    filename = files{k};
    ncid = netcdf.open(filename,'nowrite');
    str = 'T';
    %var = 'platform_number';
    var = varname;
    try
        ID = netcdf.inqVarID(ncid,var);
    catch exception
        if strcmp(exception.identifier,'MATLAB:imagesci:netcdf:libraryFailure');
            str = 'F';
        end
    end
    netcdf.close(ncid);
    disp(str);
    checkout{k} = str;
end
select = strcmp(checkout, 'F');
files(select) = [];
%for k = 1:length(checkout)
%    if checkout{k} == 'F'
%        checkout{k} = [];
%        files{k} = [];
%    end
%end
%indx_check = cellfun(@isempty,checkout);
%files(indx_check) = [];

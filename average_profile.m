function [num_no_nans,varmean]=average_profile(depth,myvar,h_lower,h_upper)
%
indx = ( h_lower<= depth & depth<h_upper )';
newvar = myvar(indx);
num_no_nans = sum (~ isnan (newvar));
varmean = nanmean(newvar);
end


    
function vq = profile_interpolation(z_1d,var_1d,zq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%z is depth will intrpolat to zq as reference and both are 1d
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

z = inpaint_nans(z_1d,0);
var = inpaint_nans(var_1d,0);

[~, ind] = unique (z); % ind = index of first occurrence of a repeated value
vq = interp1 (z (ind)', var (ind)', zq', 'linear' , 'extrap' )';
%vq = interp1 (z', var', zq', 'linear' , 'extrap' )';
end
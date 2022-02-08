function [newDepth,newvar] = profile_interp(depth,newDepth,var)

%newDepth = linspace (min (depth), max (depth), 500);
%newvar = interp1 (depth, var, newDepth, 'pchip' );
newvar = interp1 (depth, var, newDepth, 'nearst' );
end
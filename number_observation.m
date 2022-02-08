function sum_obs = number_observation(P)
for ii = 1 : size(P,2)
    num_no_nans(ii) = sum (~ isnan (P (:, ii)));
end
sum_obs = sum(num_no_nans);
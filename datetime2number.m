function time_number = datetime2number(Time_datetime)

pvtYear = datetime(1950, 01, 01);
time_number = datenum(Time_datetime - pvtYear); % time_ is same as time, minor differences probably due to floating point errors
end
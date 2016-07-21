

PROGRAM test


real :: mass
real :: mass_in_grams

print*, "Solar masses: "
read*, mass

mass_in_grams = mass * 2.0d33
print*, mass_in_grams


END PROGRAM

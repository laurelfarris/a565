

PROGRAM test


real :: mass
real :: mass_in_grams

print*, "Solar masses: "
read*, mass

f = "(A5,I2)"
mass_in_grams = mass * 2.0d33
print*, "The mass in grams is: " // mass_in_grams // " grams."


END PROGRAM

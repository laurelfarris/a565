
Z1 = 1.
Z2 = 1.
A = 0.5

B = 42.487*((Z1^2.)*(Z2^2.)*A)^(1./3.)

T = 15.e6		;[Kelvin]
T_6 = T/(1.e6)		;[million Kelvin]

eta = B*(T_6^(-1./3.))	;...

n = (eta - 2.)/3.	;Temp coefficient
print, n

END

; Problem 1.4

m_u = 0.931494
e = 4.8032e-10
h = 4.1e-18
b = 31.291
k = 8.62e-8 

T = 20.e6  ;[K]
T_6 = T/(1.e6)

Z_1 = 1. ;Proton
Z_2 = 1. ;Another proton
A = 1.   

Energy = 1.22042*sqrt( (Z_1^2)*(Z_2^2)*A*(T_6^2) )
print, Energy

KineticEnergy = 1.e-10*20.e6*1000.
print, KineticEnergy

END

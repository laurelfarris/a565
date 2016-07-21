;Constants
G = double(6.67e-8)     ; Graviational constant [cm^3 s^-2 g^-1]
M_sun = double(2.e33)   ; Solar mass [g]
R_sun = double(6.96e10) ; Solar radius [cm]
L_sun = double(3.9e33)  ; Solar luminosity [erg s^-1]

; Problem 2.1


; Problem 2.2
U = G*M_sun^2/R_sun
t = U/L_sun
t = t/(!PI * 1.e7)
print, "The gravitational potential energy of the sun is: ", U, "ergs."
print, "This corresponds to a timescale of ", t, "years."


END

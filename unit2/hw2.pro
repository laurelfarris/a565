; Problem 2.1
;  Derive equation (2.4) by plugging in the constants. Qualitatively, how
;    would the dynamical times scale for a white dwarf star compare to the
;    sun? A supergiant star?

Rsun = 6.96e10	;solar radius [cm]
Msun = 2.e33	;solar mass [g]
G = 6.67e-8	;gravitational constant (cgs)

t_dyn = sqrt(Rsun^3/(G*Msun))
print, t_dyn / 60.


; Problem 2.2
;  Derive equation (2.5)


;U = (G*Msun^2)/Rsun
;print, U
; powers too high for idl to handle...
print, 6.67*4./6.96


; Problem 2.3

temp = 15.e6	;core temperature [K]
rho = 150.	;core density [g/cm^3]
X = 0.35	;hydrogen mass fraction
Z = 0.02	;mass fraction of metals
Y = 1. - X - Z	;helium mass fraction


; Problem 2.4

 


; Problem 2.4

END

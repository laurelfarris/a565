

; Problem 1.1
;  Using MESA, verify that L is constant where epsilon = 0.
;  Show an appropriate plot from a model.

;---------------------------------------------------------------;

!P.background= 'FFFFFF'X
loadct ,  39

prof = read_mesa('LOGS/profile10.data')


;Create arrays for desired parameters (profile)
luminosity = prof.LUMINOSITY
epsilon = prof.EPS_NUC
mass = prof.MASS
radius = prof.RADIUS

!P.MULTI = [0,1,2,0,0]

charsize = 1.25

plot, mass[700:1161], (epsilon/MAX(epsilon))[700:1161], $
	ytitle='epsilon [erg/g/s] (normalized)',$
        color=0, xcharsize=charsize,  ycharsize=charsize
plot, mass[700:1161], (luminosity/MAX(luminosity))[700:1161], $
	ytitle='L [erg/s] (normalized)', xtitle='M (solar masses)',$
        color=0, xcharsize=charsize, ycharsize=charsize

END

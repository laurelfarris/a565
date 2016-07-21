;Programmer:		Laurel Farris
;Course:			ASTR 565 - Stellar Interiors
;Last Modified:		08 October 2015



;; Part 1: Solve the Lane-Emden Equation numerically for n = 4.5

;"The RK4 function uses the fourth-order Runge-Kutta method to advance
;a solution to a system of ordinary differential equations one
;time-step h, given values for the variables Y and their derivatives
;dydx known at X. To calculate the fourth-order R-K, evaluate four 
;times per timestep: 

pro cp1 

;; Constants
G = 6.67e-8
Mass = 1.99e33
Radius = 6.96e10
k_B = 1.38e-16
m_u = 1.67e-24
H_mass_frac = 0.7
Z_mass_frac = 0.02
He_mass_frac = 1. - (H_mass_frac + Z_mass_frac) 
mu = ( (2.*H_mass_frac)+(0.75*He_mass_frac)+(0.5*Z_mass_frac) )^(-1.)

;; Polytropic index, n
index = 4.5

;; 'number' found through trial and error... need to find a better
;; (aka, more general) way to determine the size of these arrays
number=3500 
x=fltarr(number)    ;xi
y=fltarr(number)    ;theta
z=fltarr(number)    ;d(theta)/d(xi)
h = 0.01            ;step in x

;To find the first values for y and z, use the Lane_Emden equation
; expanded about the origin:
x[0]=h 
y[0]=1.0 
z[0]=-(1./3.)*x[0]+index*(x[0]^3.)/30.-((48.*index^2.-30*index)/15120.)*$
                                                       (x[0])^5.
;; Runge-Kutta method:                                                       
i=0
while (y[i] >= 0) do begin
	k1 = h*z[i]
	l1 = h*( (-2.*z[i]/x[i]) - (y[i])^index )
	k2 = h*(z[i]+0.5*l1)
	l2 = h*( (-2.*(z[i]+0.5*l1)/(x[i]+0.5*h)) - (y[i] + 0.5*k2)^index )
	k3 = h*(z[i]+0.5*l2)
	l3 = h*( (-2.*(z[i]+0.5*l2)/(x[i]+0.5*h)) - (y[i] + 0.5*k3)^index )
	k4 = h*(z[i]+l3)
	l4 = h*( (-2.*(z[i]+l3)/(x[i]+h)) - ((y[i]) + k3)^index )

	y[i+1] = y[i] + (1./6.)*k1 + (1./3.)*k2 + (1./3.)*k3 + (1./6.)*k4
	z[i+1] = z[i] + (1./6.)*l1 + (1./3.)*l2 + (1./3.)*l3 + (1./6.)*l4
	x[i+1] = x[i] + h 
	i=i+1
endwhile

;; Part 2: Show results
;; 2(a) Calculate 8 quantities

E1 = max(x) 
N =	(((4.*!PI)^(1./index))/(index+1.)) *            $
    (  ((-E1^((index+1.)/(index-1.))) * z[3182]  )^ $
	                        ((1.-index)/index)  )
W = ( 4.*!PI*(index+1.)*(z[3182]^2. ))^(-1.)
bigTheta= ( -(index+1)*E1*z[3182] )^(-1.)
rho_c = (  (-E1/3.)*(z[3182]^(-1))*(3.*Mass/(4.*!PI*Radius^3.))   )
P_c = W*G*((1.99^2.)/(6.96^4.))*(1.e26) 
T_c = bigTheta*G*Mass*mu*m_u/(k_B*Radius)
rho_ratio = rho_c/( 3.*Mass/(4.*!PI*Radius^3.)  )

format='(F6.3)'
OPENW, mylun, /get_lun, "CPvalues.dat"
PRINTF, mylun,' '
PRINTF, mylun, format='("n = 	", F8.3)', index
PRINTF, mylun, format='("E1= 	", F8.3)', E1
PRINTF, mylun, format='("p/p_c= 	", F8.3)', rho_ratio
PRINTF, mylun, format='("N = 	", F8.3)', N
PRINTF, mylun, format='("W = 	", F8.3)', W
PRINTF, mylun, format='("Theta = ", F8.3)', bigTheta
PRINTF, mylun, format='("p_c =	", F8.3)', rho_c
PRINTF, mylun, format='("P_c = ", E10.3)', P_c
PRINTF, mylun, format='("T_c = ", E10.3)', T_c
PRINTF, mylun,' '
free_lun, mylun

; 2(b) Plot theta, theta^n, theta^(n+1), and q vs. xi

q = ((x^2)*z)*((E1^2.)*z[3182])^(-1.)

!P.background = 'FFFFFF'x
loadct, 39 
charsize=1.25
thick=2
window, 0, ysize=500,xsize=700

plot, x,y, $
  color=0, $
  xtitle=cgSymbol('xi')+' [unitless]',$
  ytitle='f('+cgSymbol('xi')+') [unitless]',$
  xrange=[0,E1], $
  xstyle=1,$
  ;thick=thick, linestyle=2,$
  charsize=charsize
oplot, x,y^index, $
  color=0
oplot, x,y^(index+1), $
  color=0;,$
  ;linestyle=3,$
  ;thick=thick
oplot, x,q, $
  color=0;,$
  ;linestyle=4,$
  ;thick=thick

; To write current plot to file:
 write_png, 'plot2.png', tvrd(/true)

end

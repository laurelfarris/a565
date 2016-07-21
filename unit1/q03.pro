;part 2

m_u = 931500.
e = 4.8e-10
h = 6.5821e-19

b = 2.*!PI*(e^2)/(h*sqrt(2./m_u))
print, b


STOP

;part 3 --- complete

m_u = 0.931494
e = 4.8032e-10
h = 4.1e-18
b_c = 31.291
k = 8.62e-8 
;k = 1.38e-23 ;[J K^-1]
;k = k*6.24e15 ;[keV]

E_c = (b_c*k*1.e6/2.)^(2./3.)
;print, E_c


END

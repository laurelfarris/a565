;Plot coloring stuff


; Model 1 (No nuclear burning)
history1 = read_mesa('LOGS1/history.data')
prof1 = read_mesa('LOGS1/profile20.data')

; Model 2 (With nuclear burning)
history2 = read_mesa('LOGS2/history.data')
prof2 = read_mesa('LOGS2/profile3.data')

age1 = history1.STAR_AGE
lum1 = history1.LOG_L
temp1 = history1.LOG_TEFF

age2 = history2.STAR_AGE
lum2 = history2.LOG_L
temp2 = history2.LOG_TEFF


!P.background='FFFFFF'X
loadct, 39
charsize=1.25
ymin=-0.14
ymax=-0.13
xmin=3.7
xmax=3.8


temp1 = 10.^temp1
temp2 = 10.^temp2
lum1 = 10.^lum1
lum2 = 10.^lum2

!P.MULTI = [0,2,1,0,0]

;Set axes to maximum ranges
plot, temp1, lum1, xtitle='Log(Effective Temperature)[K]', $
                   ytitle='Log(Luminosity)[erg/s]',$
                   xcharsize=charsize,$
                   ycharsize=charsize,$
                  ; xrange=[xmin:xmax],$
                  ; yrange=[ymin:ymax],$
                   color=0

oplot, temp2, lum2, color=250, thick=3

;plot second model by itself to see details.
plot, temp2, lum2, xtitle='Log(Effective Temperature)[K]', $
                   xcharsize=charsize,$
                   ycharsize=charsize,$
                   color=0        
oplot, temp2[0],lum2[0], color=250, psym=4
oplot, temp2[-1],lum2[-1], color=150, psym=5


; To convert displayed plot to .jpg:
; IDL> WRITE_JPEG, 'name_of_fig.jpg', TVRD(), QUALITY = 25
;         not sure what the quality part does... not necessary

END

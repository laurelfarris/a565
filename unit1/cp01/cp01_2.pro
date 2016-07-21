
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

;!P.MULTI = [0,1,1,0,0]
;plot, age2, lum2/(max(lum2)),color=0 
;STOP
;plot, age2,temp2, color=0

!P.MULTI = [0,2,1,0,0]

lum1 = 10.^(lum1)
lum2 = 10.^(lum2)
temp1 = 10.^(temp1)
temp2 = 10.^(temp2)

plot, age1, temp1/(max(temp1)), $
;plot, age1, temp1, $
      xrange=[0,max(age2)],$
      xtitle="Age of star [years]",$
      ytitle="Effective Temperature and Luminosity (both normalized)",$
      charsize=charsize,$
      color=0
oplot, age1, lum1/(max(lum1)), color=255, linestyle=3


plot, age2, temp2/(max(temp2)), $
;plot, age2, temp2, $
      yrange=[0.9,1.0],$
      xtitle="Age of star [years]",$
      ytitle="Effective Temperature and Luminosity (both normalized)",$
      charsize=charsize,$
      color=0
oplot, age2, lum2/(max(lum2)), color=255 , linestyle=3


;To convert current image to .jpg or .png
; IDL> WRITE_JPEG, 'fig3.jpg', TVRD()
; IDL> WRITE_PNG, 'fig3.jpg', TVRD(/TRUE)

END

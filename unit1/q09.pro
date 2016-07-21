
; mass excesses

H = 7.29
He_3 = 14.93
He_4 = 2.42
Li_7 = 14.91
Be_7 = 15.77
Be_8 = 4.94
B_8 = 22.92

; PP-II chain

neutrino = 0.8

PPII = fltarr(4)

Q_He_3 = 1.18 + 5.49
Q_He_4 = 26.2

Q0 = Q_He_3 + Q_He_4        ;previous reactions
Q1 = He_3 + He_4 - Be_7
Q2 = Be_7 - neutrino - Li_7
Q3 = Li_7 + H - 2.*(He_4)

PPII[0] = Q0
PPII[1] = Q1
PPII[2] = Q2
PPII[3] = Q3

;print, "PP-II chain: "
;print, PPII
;print, "full Q value: ", total(PPII)
;STOP

; PP-III chain

neutrino = 7.2

PPIII = fltarr(4)
PPIII[0] = 1.58 + 6.67+26.2
PPIII[1] = Be_7 + H - B_8
PPIII[2] = B_8 - neutrino - Be_8
PPIII[3] = Be_8 - 2.*(He_4)

print, "PP-III chain: "
print, PPIII
print, "full Q value: ", total(PPIII)


END

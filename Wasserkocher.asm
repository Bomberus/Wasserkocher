; Initialisierung
org 00h
ajmp init

; Variablen
;-----------------
; P0.0 - Taster
; P0.1 - Hupe
; P2 - Temperatur (Wunschtemp)
; R0 - Temperatursensor
; R1 - Wassermenge
; P1 - Display
;-----------------
; Hauptprogramm
;-----------------
init:
	mov r0,#14h ;Temperatur = 20
	mov r1,#4bh ;Wassermenge = 75 dl
; Lies derzeitige Füllmenge und Temperatur aus
;-----------------
auslesen:

main:
	jnb P0.0, main
	mov A, R0
	cjne A, P2, main
display:

erhitzen:

signal:

end

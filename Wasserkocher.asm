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
	;Aliases
	temp_current equ R0
	temp_max equ P2
	taster equ P0.0
	hupe equ P0.1
	heizstab equ P0.2
	water_current equ R1
	water_min equ R2
	is_active equ P0.3
	hupe_count equ R3
	;------------------------------------
	;Simulation
	mov temp_current,#20 ;Temperatur = 20
	mov water_current,#75 ;Wassermenge = 75 dl
	mov water_min, #50 ;Wassermenge
	clr heizstab ;Disable Heizstab
	clr is_active
	;-----------------------------------
	;Test Values
	mov temp_max, #22

main:
	jnb taster, disable
	call auslesen;

	;check temperature
	mov A, temp_current
	clr cy ;Reset the Carry
	subb A, temp_max ;(aktuelle - gewuenschte Temp) cy=1, wenn aktuell < gewünscht
	clr A
	jnb cy, disable

	;check water
	mov A, water_min
	clr cy ;Don't forget to reset that motherfucker
	subb A, water_current
	clr A
	jnb cy,disable
	clr cy

	setb is_active
	call erhitzen
	jmp main

; Lies derzeitige Füllmenge und Temperatur aus
;-----------------
auslesen:
	RET

disable:
	jnb is_active, main; Wenn der Wasserkocher von aktiv in deaktiv wechselt Hupe!
	clr heizstab ; deaktiviere Heizstab
	clr is_active
	mov hupe_count,#10
	call signal
	jmp main

erhitzen:
	setb heizstab
	mov A,temp_current
	add A,#2 ;Add 2°C to the water temperature
	mov temp_current,A
	clr A
	ret
signal:
	setb hupe ;aktiviere Hupe
	djnz hupe_count, signal
	clr hupe
	ret
display:

end

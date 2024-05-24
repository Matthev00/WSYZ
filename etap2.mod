set PRODUCENTCI;   						
set MAGAZYNY;   						
set PRODUKTY;   						
set SKLEPY;	  							

param tydzien;							
param zapotrzebowanie{PRODUCENTCI,PRODUKTY};  			
param pojemnosc_magazynu{MAGAZYNY};       			
param dystans_do_magazynu{MAGAZYNY,PRODUCENTCI};  	
param dystans_do_sklepu{MAGAZYNY,SKLEPY};  			
param tygodniowa_sprzedarz{1..tydzien, SKLEPY, PRODUKTY};  	
param pojemnosc_magazynu_sklepu{SKLEPY};       				
param koszt_km;								

var roczny_transport_do_magazynu {PRODUCENTCI,MAGAZYNY,PRODUKTY} >= 0; 
var tygodniowy_transport_do_sklepu {1..tydzien,MAGAZYNY,SKLEPY,PRODUKTY} >= 0;

minimize Laczny_koszt_operacji:
	sum {m in MAGAZYNY, s in SKLEPY, v in PRODUKTY, n in 1..tydzien}
   		dystans_do_sklepu[m,s] * koszt_km *  tygodniowy_transport_do_sklepu[n,m,s,v]
	+
	sum {p in PRODUCENTCI, m in MAGAZYNY, v in PRODUKTY}
   		dystans_do_magazynu[m,p] * koszt_km * roczny_transport_do_magazynu[p,m,v];


subject to Maksymalna_pojemnosc_magazynu{m in MAGAZYNY}:
	sum {p in PRODUCENTCI, v in PRODUKTY} roczny_transport_do_magazynu[p,m,v] <= pojemnosc_magazynu[m];

subject to Maksymalna_pojemnosc_magazynu_sklepu{s in SKLEPY, n in 1..tydzien}:
	sum {m in MAGAZYNY, v in PRODUKTY} tygodniowy_transport_do_sklepu[n, m, s, v] <= pojemnosc_magazynu_sklepu[s];
	   
subject to Zapewnienie_zapasu_produktow {v in PRODUKTY, s in SKLEPY, n in 1..tydzien}:
	sum {m in MAGAZYNY}
		tygodniowy_transport_do_sklepu[n, m, s, v] >= 1.1 * tygodniowa_sprzedarz[n, s, v];
	
subject to Warunek_zapotrzebowania{p in PRODUCENTCI, v in PRODUKTY}:
	sum {m in MAGAZYNY} roczny_transport_do_magazynu[p,m,v] <= zapotrzebowanie[p, v];


subject to Sprawdzenie_sumy_dostaw {m in MAGAZYNY, v in PRODUKTY}:
	sum {p in PRODUCENTCI} roczny_transport_do_magazynu[p, m, v] >= sum {s in SKLEPY, n in 1..tydzien} tygodniowy_transport_do_sklepu[n, m, s, v];




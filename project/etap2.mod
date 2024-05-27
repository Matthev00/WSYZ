set PRODUCENTCI;   						
set MAGAZYNY;   						
set PRODUKTY;   						
set SKLEPY;	  
							
param zapotrzebowanie{PRODUCENTCI,PRODUKTY}; 
param pojemnosc_magazynu{MAGAZYNY};   
param koszt_km;	
param tydzien;											
param dystans_do_magazynu{MAGAZYNY,PRODUCENTCI};  	
param dystans_do_sklepu{MAGAZYNY,SKLEPY};  			
param tygodniowa_sprzedarz{1..tydzien, SKLEPY, PRODUKTY};  	
param pojemnosc_magazynu_sklepu{SKLEPY};       				
							
var tygodniowy_zapas_sklepu {1..tydzien,SKLEPY,PRODUKTY} >= 0;
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
   
subject to Warunek_zapotrzebowania{p in PRODUCENTCI, v in PRODUKTY}:
	sum {m in MAGAZYNY} roczny_transport_do_magazynu[p,m,v] <= zapotrzebowanie[p, v];

subject to Sprawdzenie_sumy_dostaw {m in MAGAZYNY, v in PRODUKTY}:
	sum {p in PRODUCENTCI} roczny_transport_do_magazynu[p, m, v] >= sum {s in SKLEPY, n in 1..tydzien} tygodniowy_transport_do_sklepu[n, m, s, v];

subject to Minimalny_zapas {s in SKLEPY, n in 1..tydzien, v in PRODUKTY}:
	tygodniowy_zapas_sklepu[n, s, v] >= 0.1 * tygodniowa_sprzedarz[n, s, v];

subject to Zapotrzebowanie_sklepu_pierszy_tydzien {s in SKLEPY, v in PRODUKTY}:
	tygodniowy_zapas_sklepu[1, s, v] = - tygodniowa_sprzedarz[1, s, v] + sum {m in MAGAZYNY} tygodniowy_transport_do_sklepu[1, m, s, v];

subject to Zapotrzebowanie_sklepu {s in SKLEPY, n in 2..tydzien, v in PRODUKTY}:
	tygodniowy_zapas_sklepu[n, s, v] = tygodniowy_zapas_sklepu[n-1, s, v] - tygodniowa_sprzedarz[n, s, v] + sum {m in MAGAZYNY} tygodniowy_transport_do_sklepu[n, m, s, v];
	
subject to Pojemnosc_sklepu {s in SKLEPY, n in 1..tydzien}:
	sum {m in MAGAZYNY, v in PRODUKTY} tygodniowy_transport_do_sklepu[n, m, s, v] <= pojemnosc_magazynu_sklepu[s];
	
subject to Pojemnosc_dostawy {s in SKLEPY, n in 1..tydzien}:
	sum {v in PRODUKTY} tygodniowy_zapas_sklepu[n, s, v] <= pojemnosc_magazynu_sklepu[s];
	
	
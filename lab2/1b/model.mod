set PRODUKTY;

param tonaz_na_godzine {PRODUKTY};
param cena {PRODUKTY};
param max_ton {PRODUKTY};
param czas;
param max_maszyny;

var DzialanieMaszyn {PRODUKTY, 1..czas} binary;
var ProdukcjaMaszyn {PRODUKTY, 1..czas} >= 0, integer;

maximize ZyskTotalny:
	sum {p in PRODUKTY} (sum {t in 1..czas} ProdukcjaMaszyn[p,t])*cena[p];

s.t. max_maszyn {t in 1..czas}:
	sum {p in PRODUKTY} DzialanieMaszyn[p,t] <= max_maszyny;
	
s.t. max_ton_w_godzinie {p in PRODUKTY, t in 1..czas}:
	ProdukcjaMaszyn[p,t] <= DzialanieMaszyn[p,t]*tonaz_na_godzine[p];
	
s.t. ogr_produkcji_w_sumie {p in PRODUKTY}:
	sum {t in 1..czas} ProdukcjaMaszyn[p,t] <= max_ton[p];

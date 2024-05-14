set ZADANIA;
set POWIAZANIA within (ZADANIA cross ZADANIA);

param CZASY {ZADANIA} >= 0;

param Czas_min = 450;
var Start_momenty {ZADANIA} >= 0;

maximize Times:
  sum {z in ZADANIA} Start_momenty[z];

subject to Ograniczenia_Poczatkowe:
  Start_momenty['Dodatkowe'] = Czas_min - CZASY['Dodatkowe'];

subject to Ograniczenia_OdGory {o in ZADANIA}:
  Start_momenty[o] + CZASY[o] <= Czas_min;

subject to Ograniczenia_Poprzednikow {(i, j) in POWIAZANIA}:
  Start_momenty[i] + CZASY[i] <= Start_momenty[j];

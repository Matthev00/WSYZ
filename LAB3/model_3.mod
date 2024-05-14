set ZADANIA;
set POWIAZANIA within (ZADANIA cross ZADANIA);

param CZASY {ZADANIA} >= 0;

var Czas_min >= 0;
var Start_momenty {ZADANIA} >= 0;

minimize Czas_całkowity:
  Czas_min;

subject to Ograniczenia_Poprzednikow {(i, j) in POWIAZANIA}:
  Start_momenty[j] >= Start_momenty[i] + CZASY[i];

subject to Ograniczenia_Poczatkowe:
  Start_momenty['Wylanie_Fundamentow'] = 0;

subject to Ograniczenia_Koncowe {i in ZADANIA}:
  Czas_min >= Start_momenty['Dodatkowe'] + CZASY['Dodatkowe'];

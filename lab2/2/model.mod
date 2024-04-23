set Breweries;  # Zbiór browarów
set Warehouses;  # Zbiór hurtowni

param ProductionCap {Breweries};  # Maksymalna produkcja browaru
param Demand {Warehouses};  # Zapotrzebowanie hurtowni
param TransportCost {Warehouses, Breweries};  # Koszty transportu

# Zmienne decyzyjne
#var Shipment {Warehouses, Breweries} >= 0;  # bez całkowitoliczbowości
var Shipment {Warehouses, Breweries} >= 0, integer;  # z całkowitoliczbowością

# Funkcja celu
minimize TotalTransportCost:
    sum {w in Warehouses, b in Breweries} Shipment[w,b] * TransportCost[w,b];

# Ograniczenia
subject to DemandFulfillment {w in Warehouses}:
    sum {b in Breweries} Shipment[w,b] = Demand[w];

subject to ProductionLimit {b in Breweries}:
    sum {w in Warehouses} Shipment[w,b] <= ProductionCap[b];

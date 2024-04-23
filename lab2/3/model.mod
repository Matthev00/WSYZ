set Plants;  # Zbiór zakładów produkcyjnych
set Depots;  # Zbiór hurtowni/składów

param MaxProduction {Plants};  # Maksymalne możliwości produkcyjne zakładów [tony]
param DepotDemand {Depots};  # Zapotrzebowanie hurtowni [tony]
param ShippingCost {Depots, Plants};  # Koszty transportu [$/tona]

# Zmienne decyzyjne
var SteelShipping {Depots, Plants} >= 0;  # Ilość transportowanego piwa [hl]

# Funkcja celu
minimize TotalShippingCost:
	sum {d in Depots, p in Plants} SteelShipping[d,p] * ShippingCost[d,p];

# Ograniczenia

# Zapotrzebowanie każdej hurtowni musi być spełnione
subject to DemandFulfillment {d in Depots}:
	sum {p in Plants} SteelShipping[d,p] = DepotDemand[d];

# Produkcja nie może przekroczyć możliwości produkcyjnych zakładów
subject to ProductionCapacityLimit {p in Plants}:
	sum {d in Depots} SteelShipping[d,p] <= MaxProduction[p];


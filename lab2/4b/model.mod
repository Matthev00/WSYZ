set ScrewTypes;  # Zbiór typów wkrętów
set Machines;  # Zbiór maszyn

param OrderQuantity {ScrewTypes};  # Ilość wkrętów do wyprodukowania dla każdego typu
param ProductionTime {Machines, ScrewTypes};  # Czas produkcji jednego wkręta na każdej maszynie [s]
param MinOperationTime;  # Minimalny czas działania maszyny [s]

# Zmienne decyzyjne reprezentujące ilość wkrętów produkowanych na każdej maszynie dla każdego typu
var ProductionAmount {Machines, ScrewTypes} >= 0, integer;

# Funkcja celu - minimalizacja całkowitego czasu produkcji
minimize TotalProductionTime:
	sum {m in Machines, st in ScrewTypes} ProductionAmount[m,st] * ProductionTime[m,st];
		
# Ograniczenia

# Wymaganie, aby suma wyprodukowanych wkrętów każdego typu spełniała zamówienie
subject to OrderFulfillment {st in ScrewTypes}:
	sum {m in Machines} ProductionAmount[m,st] = OrderQuantity[st];
	
# Wymaganie, aby każda maszyna działała przynajmniej przez minimalny czas
subject to MinMachineOperation {m in Machines}:
	sum {st in ScrewTypes} ProductionAmount[m,st] * ProductionTime[m,st] >= MinOperationTime;

set ScrewTypes;  # Zbiór typów wkrętów
set Machines;  # Zbiór maszyn

param OrderQuantity {ScrewTypes};  # Ilość wkrętów do wyprodukowania dla każdego typu
param ProductionTime {Machines, ScrewTypes};  # Czas produkcji jednego wkręta na każdej maszynie [s]
param MinOperationTime;  # Minimalny czas działania maszyny [s]

var ScrewsProduced {Machines, ScrewTypes} >= 0, integer;  # Ilość wkrętów produkowanych na każdej maszynie
var LongestOperationTime >= 0;  # Najdłuższy czas pracy maszyny

# Minimalizacja czasu pracy najdłużej działającej maszyny
minimize MaxMachineOperationTime:
	LongestOperationTime;
		
# Ograniczenia

# Każde zamówienie musi być spełnione
subject to OrderCompletion {st in ScrewTypes}:
	sum {m in Machines} ScrewsProduced[m,st] = OrderQuantity[st];
	
# Każda maszyna musi działać przynajmniej przez określony minimalny czas
subject to MinMachineUsageTime {m in Machines}:
	sum {st in ScrewTypes} ScrewsProduced[m,st] * ProductionTime[m,st] >= MinOperationTime;
	
# Najdłuższy czas pracy maszyny nie może być krótszy od czasu pracy każdej maszyny
subject to MaxOperationTimeConstraint {m in Machines}:
	sum {st in ScrewTypes} ScrewsProduced[m,st] * ProductionTime[m,st] <= LongestOperationTime;

set ITEMS;
param ProductionRate {ITEMS};
param UnitPrice {ITEMS};
param ProductionLimit {ITEMS};
param AvailableTime;

var Production {i in ITEMS} >= 0, <=ProductionLimit[i];

maximize TotalProfit:
	sum {i in ITEMS} Production[i]*UnitPrice[i];

subject to ogr_czas:
	sum {i in ITEMS} Production[i]/ProductionRate[i]<=AvailableTime;



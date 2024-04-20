# Zmienne decyzyjne
var prenty_h >= 0;  
var katowniki_h >= 0;  
var ceowniki_h >= 0;  

var prenty_T >= 0;  
var katowniki_T >= 0;  
var ceowniki_T >= 0;  

# Funkcja celu
maximize Zysk:
    32 * prenty_h * 200 +
    25 * katowniki_h * 140 +
    3 * ceowniki_h * 120;

subject to suma_godz:
	prenty_h + katowniki_h + ceowniki_h <= 40; 

subject to max_prenty:
	prenty_h <= 20; # 4000 / 200 = 20

subject to max_katowniki:
	katowniki_h <= 21; # 3000 / 140 = 21.43..

subject to max_ceowniki:
	ceowniki_h <= 20; # 4000 / 200 = 20.8(3)

subject to calculate_prenty_T:
	prenty_T = prenty_h * 200;
	
subject to calculate_kantowniki_T:
	katowniki_T = katowniki_h * 140;

subject to calculate_ceowniki_T:
	ceowniki_T = ceowniki_h * 120;

# Rozwiązanie problemu
solve;

# Wypisanie wyników
display prenty_T, katowniki_T, ceowniki_T, Zysk;
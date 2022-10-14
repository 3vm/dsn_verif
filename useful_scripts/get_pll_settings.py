#!/usr/bin/python3

# Variables, input
ref=100e6
req_out=120e6

vco_min=25e6
vco_max=900e6

N_MAX=16
M_MAX=64

# Calculation
vco_f=0
best_error=1e20

for N in range(1,N_MAX) :
	for M in range(1,M_MAX) :
		vco_f = M * ref / N  
		if ( (vco_f < vco_max ) and (vco_f > vco_min)) :
			error=abs(req_out - vco_f)
			if ( error < best_error) :
				best_error=error
				print("PLL N=%d M=%d gives %1.4e Hz with deviation %1.4e Hz" %(N,M,vco_f,error))

#3vm

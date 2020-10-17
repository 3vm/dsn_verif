import datetime

#DONT use for regular use
# this script is meant only for comparison with multicore script

print("Start time",datetime.datetime.now())
# Variables, input
ref=100e6
req_out=120e6

vco_min=25e5
vco_max=900e6

N_MAX=32768
M_MAX=8192

#cores=4

# Calculation
vco_f=0
best_vco_f=0
best_N=0
best_M=0
best_error=1e20

#from mpi4py import MPI
#comm = MPI.COMM_WORLD
#rank = comm.Get_rank()

#for N in range(1,N_MAX,cores) :
#	N_local = N + rank
for N in range(1,N_MAX) :
	for M in range(1,M_MAX) :
		vco_f = M * ref / N
		if ( (vco_f < vco_max ) and (vco_f > vco_min)) :
			error=abs(req_out - vco_f)
			if ( error < best_error) :
				best_error=error
				best_N = N
				best_M = M
				best_vco_f = vco_f
				print("PLL N=%d M=%d gives %1.4e Hz with deviation %1.4e Hz" %(N,M,vco_f,error))
#comm.Barrier()
#if(rank==0):
print("Final Result")
#comm.Barrier()

print("PLL N=%d M=%d gives %1.4e Hz with deviation %1.4e Hz" %(best_N,best_M,best_vco_f,best_error))

print("End time",datetime.datetime.now())

#3vm

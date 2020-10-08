
#install matplotlib if it is not already installed in your system
# sudo apt-get install python3-matplotlib
# run either as python3 <this script name> or add the path to python3 binary as at the top of the file #!<python3 binary path> 
import matplotlib.pyplot as plt
import math
series=[]
N=1500
Chirp_rate=0.03
T=150
fc=1/T
for i in range(N):
	f = fc * (1 + i * Chirp_rate)
	series.append(math.sin(2*math.pi*(i-1)*Chirp_rate*f))
	print(series[i])
plt.plot(series)
plt.title('Chirp')
plt.ylabel('Amplitude')
plt.xlabel('Time')
plt.show()

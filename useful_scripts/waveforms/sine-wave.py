
#install matplotlib if it is not already installed in your system
# sudo apt-get install python3-matplotlib
# run either as python3 <this script name> or add the path to python3 binary as at the top of the file #!<python3 binary path> 
import matplotlib.pyplot as plt
import math
series=[]
N=450
T=150
for i in range(N):
	series.append(math.sin(2*math.pi*(i-1)/T))
	print(series[i])
plt.plot(series)
plt.title('Sine')
plt.ylabel('Value')
plt.xlabel('Time')
plt.show()

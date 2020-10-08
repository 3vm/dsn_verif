
#install matplotlib if it is not already installed in your system
# sudo apt-get install python3-matplotlib
# run either as python3 <this script name> or add the path to python3 binary as at the top of the file #!<python3 binary path> 
import matplotlib.pyplot as plt
import random as rnd
series=[]
for i in range(50):
	series.append( rnd.uniform(0,1))
	print(series[i])
plt.plot(series)
plt.title('Noise')
plt.ylabel('Amplitude')
plt.xlabel('Time')
plt.show()

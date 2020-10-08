
#install matplotlib if it is not already installed in your system
# sudo apt-get install python3-matplotlib
# run either as python3 <this script name> or add the path to python3 binary as at the top of the file #!<python3 binary path> 
import matplotlib.pyplot as plt
plt.plot([16,8,4,2,1,0.5,0.25,0.125,0.0625,0.03125])
plt.title('Exponential Decay')
plt.ylabel('Amplitude')
plt.xlabel('Time')
plt.show()


#install matplotlib if it is not already installed in your system
# sudo apt-get install python3-matplotlib
# run either as python3 <this script name> or add the path to python3 binary as at the top of the file #!<python3 binary path> 
import matplotlib.pyplot as plt
series = [0.03125,0.0625,0.125, 0.25,0.5,1,2,4,8,16]
plt.plot(series)
plt.title('Exponential Growth')
plt.ylabel('Value')
plt.xlabel('Time')
plt.show()

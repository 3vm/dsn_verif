
#install matplotlib if it is not already installed in your system
# sudo apt-get install python3-matplotlib
# run either as python3 <this script name> or add the path to python3 binary as at the top of the file #!<python3 binary path> 
import matplotlib.pyplot as plt
plt.plot([1, 2, 4, 8,16,32,64,128,256,512])
plt.ylabel('Covid Cases')
plt.xlabel('Weeks')
plt.show()

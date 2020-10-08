import matplotlib.pyplot as plt

datx=[]
daty=[]
N=100
for i in range(N):
	datx.append(i)
	daty.append(0)

daty[30]=0.1
daty[31]=0.1
daty[31]=0.2
daty[34]=0.5
daty[35]=0.6
daty[36]=0.7
daty[37]=0.3
daty[38]=0.2
daty[39]=0.2
daty[40]=0.1


plt.plot(datx,daty)
plt.ylabel('Amplitude')
plt.xlabel('Time')
plt.title('Glitch')
plt.show()

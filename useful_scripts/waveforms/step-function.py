import matplotlib.pyplot as plt

datx=[]
daty=[]
N=100
for i in range(-N,N):
	datx.append(i)
	if ( i>=0):
		daty.append(1)
	else :
		daty.append(0)

plt.plot(datx,daty)
plt.ylabel('Amplitude')
plt.xlabel('Time')
plt.title('Step')
plt.show()

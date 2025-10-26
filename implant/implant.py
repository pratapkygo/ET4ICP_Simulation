import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV files
file1 = 'implantAs.out'
file2 = 'implantB.out'
file3 = 'implantSb.out'
file4 = 'implantP.out'

data1 = pd.read_csv(file1, sep='\t', header=None)
data2 = pd.read_csv(file2, sep='\t', header=None)
data3 = pd.read_csv(file3, sep='\t', header=None)
#data4 = pd.read_csv(file4, sep='\t', header=None)

# Assuming the CSV files have columns 'x' and 'y'
x1, y1 = data1[0], data1[1]
x2, y2 = data2[0], data2[1]
x3, y3 = data3[0], data3[1]
#x4, y4 = data4[0], data4[1]


# Create a log-lin plot
plt.figure(figsize=(10, 6))

plt.plot(x1, y1, label='Arsenic', color='k')
plt.plot(x2, y2, label='Boron', color='g')
plt.plot(x3, y3, label='Antinomy', color='r')
#plt.plot(x4, y4, label='Phosphorus', color='b')

plt.yscale('log')  # Set the y-axis to log scale
plt.ylim(bottom=1e14)
plt.xlabel('Depth [um]')
plt.ylabel('Concentration [cm-3]')
plt.title('Implantation profiles')
plt.legend()
plt.grid(True, which="both", ls="--")

plt.show()

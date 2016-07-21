import pdb  #pdb.set_trace()
import math
import numpy as np
import matplotlib.pyplot as plt
#import py_mesa_reader.mesa_reader as ms
import mesa_reader as ms
from scipy import interpolate
import matplotlib

matplotlib.rcParams['mathtext.fontset'] = 'custom'
matplotlib.rcParams['mathtext.rm'] = 'Bitstream Vera Sans'
matplotlib.rcParams['mathtext.it'] = 'Bitstream Vera Sans:italic'
matplotlib.rcParams['mathtext.bf'] = 'Bitstream Vera Sans:bold'
matplotlib.pyplot.title(r'ABC123 vs $\mathrm{ABC123}^{123}$')

num_models = 19 

### 1. HR diagram

# Values to plot (at the time the num_models were stopped)
L = []      # final Luminosity
Li = []      # initial Luminosity
Teff = []   # final Effective temperature
Teffi = []   # initial effective temperature
radius = [] # Radius
mass = []   # Mass [M/M_sun]

fig = plt.figure()
ax = fig.add_subplot(1,1,1)

# Assign values from the history data
for i in range(1,num_models+1):
    if i < 10:
        history = ms.MesaData('output/history_0'+str(i)+'.data')
    else:
        history = ms.MesaData('output/history_'+str(i)+'.data')
    Teff.append(history.log_Teff[-1])
    Teffi.append(history.log_Teff[0])
    L.append(history.log_L[-1])
    Li.append(history.log_L[0])
    radius.append(history.log_R[-1])
    mass.append(history.star_mass[-1])
    h = np.array(history.log_Teff) 
    l = np.array(history.log_L) 
    ax.plot(h,l,color='black')

# Create numerical arrays for plotting
Teff = np.array(Teff)
Teffi = np.array(Teffi)
L = np.array(L)
Li = np.array(Li)
radius = np.array(radius)
mass = np.array(mass)
size = (10**(1.5*radius))*100
color = np.sqrt(mass) 
im = ax.scatter(Teff,L,
 # vmin=min(mass),vmplt=mplt(mass),
  s=size,c=color,cmap='hot',linewidth=0)
plt.plot(Teffi,Li,color='black',marker='o',linewidth=0)
plt.plot(Teffi,Li,color='black')
plt.xlabel('log T(r)')
plt.ylabel('gradient')
ax.yaxis.labelpad=10
fig.colorbar(im, ax=ax)
plt.xlim(4.7,3.5)
plt.ylim(-2,6)
plt.xlabel('log T$_{\\rm eff }\\rm [K]$')
plt.ylabel('$\\rm L/L_{\odot}$',rotation='horizontal')
#plt.savefig('hr_diagram.pdf')
plt.show()
plt.clf()



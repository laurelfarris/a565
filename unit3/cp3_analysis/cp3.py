# Programmer:           Laurel Farris
# Last modified:        16 November 2015
# Modules:              plotting.py, mesa_reader.py
# Purpose:
# Determine where convection occurs in the
# interiors of stars of a wide range of masses
# using MESA data.

# MESA:
# Stopping criteria: hydrogen mass fraction (X) = 0.35

import pdb  #pdb.set_trace()
import math
import numpy as np
import matplotlib.pyplot as plt
#import py_mesa_reader.mesa_reader as ms
import mesa_reader as ms
import plotting

num_models = 19

### 1. HR diagram
# Values to plot
L = []      # final Luminosity
Li = []      # initial Luminosity
Teff = []   # final Effective temperature
Teffi = []   # initial effective temperature
radius = [] # Radius
mass = []   # Mass [M/M_sun]
star_age = [] # Age

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
    star_age.append(history.star_age[-1])
    plt.plot(history.log_Teff,history.log_L)

# Create numerical arrays for plotting
Teff = np.array(Teff)
Teffi = np.array(Teffi)
L = np.array(L)
Li = np.array(Li)
radius = np.array(radius)
mass = np.array(mass)
star_age = np.array(star_age)

# Import function to plot an hr_diagram
from plotting import hr_diagram
hr_diagram(Teff,Teffi,L,Li,radius,mass,star_age)

### 2. and 3. The money plots!

solar_mass = [] #star's mass in solar masses
radial_mass = [] # Star's internal mass as a function of radius
radial_profile = [] # Radial profile from surface to center
del_r = [] # radiation gradient
del_a = [] # adiabatic gradient
del_T = [] # true gradient
PPchain = []
CNOcycle = []
BVfreq = []

# Assign values from the profile data
for i in range(1,num_models+1):
    if i < 10:
        profiles= ms.MesaData('output/profile_0'+str(i)+'.data')
    else:
        profiles= ms.MesaData('output/profile_'+str(i)+'.data')
# Append arrays from profile from each model
# (each array is one 'element')
    radial_mass.append(profiles.mass)
    radial_profile.append(profiles.radius)
    del_r.append(profiles.gradr)
    del_a.append(profiles.grada)
    del_T.append(profiles.gradT)
    PPchain.append(profiles.pp)
    CNOcycle.append(profiles.cno)
    BVfreq.append(profiles.brunt_N2)
    arr = []
    # make x values the same for each model
    for j in range(0,len(profiles.mass)):
        arr.append(profiles.initial_mass)
    solar_mass.append(arr)

solar_mass = np.array(solar_mass)
radial_mass = np.array(radial_mass)
radial_profile = np.array(radial_profile)
del_r = np.array(del_r)
del_a = np.array(del_a)
del_T = np.array(del_T)
PPchain = np.array(PPchain)
CNOcycle = np.array(CNOcycle)
BVfreq = np.array(BVfreq)

plotting.money(solar_mass,radial_profile,num_models,del_r,del_a,
      del_T,PPchain,CNOcycle,BVfreq,'r')
plotting.money(solar_mass,radial_mass,num_models,del_r,del_a,
      del_T,PPchain,CNOcycle,BVfreq,'m')

# 4. - 7. Last four plots: two each for two different num_models

p1 = ms.MesaData('output/profile_01.data')
p2 = ms.MesaData('output/profile_17.data')
plotting.gradients(np.array(p1.logT),np.array(p1.gradT),
   np.array(p1.grada),np.array(p1.gradr),'littlegrad')
plotting.gradients(np.array(p2.logT),np.array(p2.gradT),
   np.array(p2.grada),np.array(p2.gradr),'biggrad')
plotting.BV(np.array(p1.logT),np.array(p1.brunt_N2),'littleBV')
plotting.BV(np.array(p2.logT),np.array(p2.brunt_N2),'bigBV')







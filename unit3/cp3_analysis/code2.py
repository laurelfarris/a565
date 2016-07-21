import math
import numpy as np
import matplotlib.pyplot as plt
import astropy.constants as cnst
#import py_mesa_reader.mesa_reader as ms
import mesa_reader as ms
import plotting

# Constants
M_sun = cnst.M_sun.cgs.value
R_sun = cnst.R_sun.cgs.value

# Read in data from Mesa model runs using header info

history1 = ms.MesaData('model003/LOGS/history.data')
profile1 = ms.MesaData('model003/LOGS/profile3.data')
m_num = history1.initial_mass
print m_num 


# 1. HR diagram
# Teff1 = 
Teff1 = history1.log_Teff
Teff1 = Teff1[::-1]
L1 = history1.log_L


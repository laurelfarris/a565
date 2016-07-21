import pdb
import matplotlib.pyplot as plt
import numpy as np
import math
from scipy import interpolate
#from matplotlib.ticker import ScalarFormatter
import matplotlib
matplotlib.rc('font',**{'family':'serif','serif':['Times']})
matplotlib.rc('text', usetex=True)
'''
intfunc = interpolate.interp1d(x,y,kind='linear'|'quadratic')
intfunc(x)
plt.plot(x,intfunc(x))
plt.plot(x,func(x))
'''
'''
ax1.scatter(Tmaster, Lmaster, s=2)
ax1.set_xscale('log')
for axis in [ax1.xaxis, ax1.yaxis]:
    axis.set_major_formatter(ScalarFormatter())

    plt.xticks([position, of, data, array, stuff, things] , [what,
    you, want, them, to, say])
'''
def hr_diagram(Teff,Teffi,L,Li,radius,mass,star_age):
    #plt.plot(Teffi,Li,color='black')
    size = (10**(1.5*radius))*100
    color = mass
    fig = plt.figure()
    ax = fig.add_subplot(1,1,1)
    im = ax.scatter(Teff,L,
      #vmin=min(mass),vmax=max(mass),
      s=size,c=color,
      linewidth=0)
    ax.scatter(Teffi,Li,color='black',linewidth=0)
    fig.colorbar(im, ax=ax)
    #plt.scatter(Teff,L,s=size,c=color,linewidth=0)
    #plt.scatter(Teffi,Li,color='black',linewidth=0)
    plt.figtext(0.3,0.8,'$~$5 Myr')
    plt.figtext(0.55,0.15,'$~$400 Gyr')
    plt.xlim(4.7,3.5)
    plt.ylim(-2,6)
    plt.xlabel('log T$_{\\rm eff}$ [K]')
    plt.ylabel('$\\rm L/L_{\odot}$',x=-1.0)
    plt.savefig('hr_diagram.pdf')
    plt.clf()
'''
'''
def money(solar_mass,y,num_models,del_r,del_a,
           del_T,PPchain,CNOcycle,BVfreq,yvalues):
    x = []
    conv_1 = []
    conv_2 = []
    semix = []
    semiy = []
    pp = []
    cno = []
    conv = []
    for k in range(0,num_models):
        conv = []
        ppx = []
        ppy = []
        cnox = []
        cnoy = []
        zones = len(del_r[k])
        y[k] = y[k]/(max(y[k]))
        # Determine convection zones
        for l in range(0,zones):
            # No convection
            #if del_T[k][l] <= del_a[k][l]:
            if BVfreq[k][l] >= 0:
                conv.append(y[k][l])
                if CNOcycle[k][l]/PPchain[k][l] > 1:
                    cnoy.append(y[k][l])
                    cnox.append(np.log10(solar_mass[k][l]))
                else:
                    cnoy.append(0)
                    cnox.append(np.log10(solar_mass[k][l]))
                    # Create array for ppchain reactions
                    if PPchain[k][l] > 1:
                        ppy.append(y[k][l])
                        ppx.append(np.log10(solar_mass[k][l]))
                    else:
                        ppy.append(0)
                        ppx.append(np.log10(solar_mass[k][l]))
        x.append(np.log10(solar_mass[k][l]))
        conv_1.append(min(conv))
        conv_2.append(max(conv))
        pp.append(max(ppy))
        cno.append(max(cnoy))
    conv_2[3] = 0.8692732691963766
    conv_2[4] = 0.90649850789440856
    conv_2[5] = 0.93531297643605804
    conv_2[6] = 0.95885383490556642
    conv_2[7] = 0.9778780244954457
    # Attempt at interpolation...
    f_1 = interpolate.interp1d(x,conv_1,kind='cubic')
    f_2 = interpolate.interp1d(x,conv_2,kind='cubic')
    f_3 = interpolate.interp1d(x,cno,kind='cubic')
    f_4 = interpolate.interp1d(x,pp,kind='cubic')
    xnew = np.linspace(min(x),max(x),1000)
    ynew_1 = f_1(xnew)
    ynew_2 = f_2(xnew)
    ynew_3 = f_3(xnew)
    ynew_4 = f_4(xnew)
    # End interpolation attempt...
    fig=plt.figure()
    ax=fig.add_subplot(111)
    ax.plot(xnew,ynew_4,color='black')
    ax.plot(xnew,ynew_3,color='black')
    ax.plot(xnew,ynew_1,color='black')
    ax.plot(xnew,ynew_2,color='black')
    y1 = np.zeros(len(ynew_1))
    y2 = np.ones(len(ynew_1))
    ax.fill_between(xnew,ynew_1,y1,hatch='/',color='none',edgecolor='black')
    ax.fill_between(xnew,ynew_2,y2,hatch='/',facecolor='white')#,color='black')
    ax.fill_between(xnew,ynew_3,ynew_1,hatch='.',
      facecolor='white')#,color='black')
    ax.set_xlim(math.log10(0.3),math.log10(20.0))
    ax.set_ylim(0.0,1.0)
    ax.set_xlabel('log $\\rm M_*/M_{\odot}$')
    if yvalues == 'm':
        ax.set_ylabel('$\\rm m(r)/M_*$')
        fig.savefig('money.pdf')
    elif yvalues == 'r':
        ax.set_ylabel('$\\rm r/R_*$')
        fig.savefig('money2.pdf')
'''
'''
# Given the temperature profile of a star, plot the true driving
# gradient, the radiation gradient, and the adiabatic gradient as
# functions of the temperature.
def gradients(temp,grad,grad_ad,grad_rad,filename):
    plt.plot(temp,np.log10(grad), 'g-.',linewidth=2.0,label='$\\nabla$')
    plt.plot(temp,np.log10(grad_ad), 'm:',linewidth=2.0,label='$\\nabla_{ad}$')
    plt.plot(temp,np.log10(grad_rad), 'k--',linewidth=2.0,label='$\\nabla_{rad}$')
    plt.ticklabel_format(axis='y', style='sci', scilimits=(-2,2))
    plt.legend()
    plt.xlim(xmin=max(temp),xmax=min(temp))
    plt.xlabel('log T(r) [K]')
    plt.ylabel('log(gradient)')
    plt.savefig(filename+'.pdf')
    plt.clf()

# Given the temperature profile of a star, plot the B-V frequency as
# functions of the temperature.
def BV(temp,BVfreq,filename):
    x = []
    y = []
    for i in range (0,len(BVfreq)):
        if BVfreq[i] >= 0:
            y.append(BVfreq[i])
            x.append(temp[i])
    plt.plot(x,y)
    plt.ticklabel_format(axis='y', style='sci', scilimits=(-2,2))
    plt.plot(x,y)
    plt.xlim(max(x),min(x))
    plt.xlabel('log T(r) [K]')
    plt.ylabel('BV [s$^{-1}$]')
    plt.savefig(filename+'.pdf')
    plt.clf()


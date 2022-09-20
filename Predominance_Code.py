import matplotlib.pyplot as plt
import numpy as np

R = 8.314

def alpha_stable(T):
    deltag=0
    if(T<1100):
        deltag = (980 - (360*0.001*T))*1000
    elif(T>=1100):
        deltag = (1100 - (500*0.001*T))*1000
    # deltag = 462000                                ### ZnSO4 ==> Zn + 0.5*S2  + 2*O2
    deltag_2 = (268.709 - (100.5*0.001*T))*1000      ### ZnS ==> Zn+ 0.5*S2
    deltag_3 = (352.602 - (106.1*0.001*T))*1000      ### ZnO ==> Zn+ 0.5*O2
    deltag_4 = deltag - deltag_2                     ### ZnSO4 ==> ZnS + 2*O2
    deltag_5 = deltag - deltag_3                     ### ZnSO4 ==> ZnO + 0.5*S2 + 1.5*O2
    fig, plt1 = plt.subplots()


    x1 = -deltag_3/(R*T)
    y1 = -deltag_2/(R*T)
    x2 = -(deltag_4 / (R * T)) * 0.5
    y2 = 2 * (-deltag_5 / (R * T)) - 3 * x2

    plt1.hlines(y1, xmin=x1-5, xmax=x1, colors='blue')
    plt1.vlines(x1, ymin=y1-15, ymax=y1, colors='blue')


    plt.plot([x1,x2], [y1,y2], 'blue')

    plt1.vlines(x2, ymin=y2, ymax=y2+10, colors='blue')

    xlist = np.linspace(x2, x2+3, 100)
    ylist = -2*deltag_5/(R*T) - 3*xlist

    plt.plot(xlist, ylist,'blue')


    plt.text(x1-3,y1+8, "ZnS")
    plt.text(x1-3, y1-8, "Zn")
    plt.text(x2, y1-8, "ZnO")
    plt.text(x2+1.5, y2+4.5, "ZnSO4")

    plt.xlabel("ln(Po2)")
    plt.ylabel("ln(Ps2)")

    print("alpha_stable:", x1, y1, x2, y2)

    plt.title("α-stable Graph")
    plt.show()
    return

T = float(input("PLease enter the Temperature Value"))
alpha_stable(T)
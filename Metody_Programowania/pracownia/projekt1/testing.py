from math import cos, sin, radians
#from visual import *

def hilbert(n, u, x, y, z, wektorxx, wektorxy, wektorxz, wektoryx, wektoryy, wektoryz, wektorzx, wektorzy, wektorzz, wspolrzedne):
    if (n == 0):
        wspolrzedne.append([[x],[y],[z],[1]])
    else:
        u=float(u/2)
        if(wektorxx<0 or wektorxy<0 or wektorxz<0):
            x-= u * wektorxx
            y-= u * wektorxy
            z-= u * wektorxz
        if(wektoryx<0 or wektoryy<0 or wektoryz<0):
            x-= u * wektoryx
            y-= u * wektoryy
            z-= u * wektoryz
        if(wektorzx<0 or wektorzy<0 or wektorzz<0):
            x-= u * wektorzx
            y-= u * wektorzy
            z-= u * wektorzz
        hilbert(n - 1, u, x + u * wektorxx + u * wektoryx + u * wektorzx, y + u * wektorxy + u * wektoryy + u * wektorzy, z + u * wektorxz + u * wektoryz + u * wektorzz, wektorzx, wektorzy, wektorzz, wektorxx, wektorxy, wektorxz, -wektoryx, -wektoryy, -wektoryz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx + u * wektorzx, y + u * wektorxy + u * wektorzy, z + u * wektorxz + u * wektorzz, wektoryx, wektoryy, wektoryz, wektorzx, wektorzy, wektorzz, -wektorxx, -wektorxy, -wektorxz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorzx, y + u * wektorzy, z + u * wektorzz, wektoryx, wektoryy, wektoryz, wektorzx, wektorzy, wektorzz, -wektorxx, -wektorxy, -wektorxz, wspolrzedne)
        hilbert(n-1,u, x+u*wektoryx+u*wektorzx, y+u*wektoryy+u*wektorzy, z+u*wektoryz+u*wektorzz, -wektorxx, -wektorxy, -wektorxz, -wektoryx, -wektoryy, -wektoryz, wektorzx, wektorzy, wektorzz,wspolrzedne)
        hilbert(n - 1, u, x + u * wektoryx, y + u * wektoryy, z + u * wektoryz, -wektorxx, -wektorxy, -wektorxz, -wektoryx, -wektoryy, -wektoryz, wektorzx, wektorzy, wektorzz, wspolrzedne)
        hilbert(n - 1, u, x, y, z, wektoryx, wektoryy, wektoryz, wektorzx, -wektorzy, -wektorzz, -wektorxx, wektorxy, wektorxz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx, y + u * wektorxy, z + u * wektorxz, wektoryx, wektoryy, wektoryz, wektorzx, -wektorzy, -wektorzz, -wektorxx, wektorxy, wektorxz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx + u * wektoryx, y + u * wektorxy + u * wektoryy, z + u * wektorxz + u * wektoryz, -wektorzx, -wektorzy, -wektorzz, wektorxx, wektorxy, wektorxz, wektoryx, wektoryy, wektoryz, wspolrzedne)

        """

        hilbert(n - 1, u, x + u * wektorxx + u * wektoryx, y + u * wektorxy + u * wektoryy, z + u * wektorxz + u * wektoryz, wektorzx, wektorzy, wektorzz, wektorxx, wektorxy, wektorxz, wektoryx, wektoryy, wektoryz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx, y + u * wektorxy, z + u * wektorxz, wektorzx, wektorzy, wektorzz, wektorxx, wektorxy, wektorxz, wektoryx, wektoryy, wektoryz, wspolrzedne)
        hilbert(n - 1, u, x, y, z, wektoryx, wektoryy, wektoryz, wektorzx, wektorzy, wektorzz, wektorxx, wektorxy, wektorxz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektoryx, y + u * wektoryy, z + u * wektoryz, -wektorxx, -wektorxy, -wektorxz, -wektoryx, -wektoryy, -wektoryz, wektorzx, wektorzy, wektorzz, wspolrzedne)
        hilbert(n-1,u, x+u*wektoryx+u*wektorzx, y+u*wektoryy+u*wektorzy, z+u*wektoryz+u*wektorzz, -wektorxx, -wektorxy, -wektorxz, -wektoryx, -wektoryy, -wektoryz, wektorzx, wektorzy, wektorzz,wspolrzedne)
        hilbert(n - 1, u, x + u * wektorzx, y + u * wektorzy, z + u * wektorzz, wektoryx, wektoryy, wektoryz, -wektorzx, -wektorzy, -wektorzz, -wektorxx, -wektorxy, -wektorxz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx + u * wektorzx, y + u * wektorxy + u * wektorzy, z + u * wektorxz + u * wektorzz, -wektorzx, -wektorzy, -wektorzz, wektorxx, wektorxy, wektorxz, -wektoryx, -wektoryy, -wektoryz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx + u * wektoryx + u * wektorzx, y + u * wektorxy + u * wektoryy + u * wektorzy, z + u * wektorxz + u * wektoryz + u * wektorzz, -wektorzx, -wektorzy, -wektorzz, wektorxx, wektorxy, wektorxz, -wektoryx, -wektoryy, -wektoryz, wspolrzedne)

        oryginal
        hilbert(n - 1, u, x, y, z, wektoryx, wektoryy, wektoryz, wektorzx, wektorzy, wektorzz, wektorxx, wektorxy, wektorxz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx, y + u * wektorxy, z + u * wektorxz, wektorzx, wektorzy, wektorzz, wektorxx, wektorxy, wektorxz, wektoryx, wektoryy, wektoryz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx + u * wektoryx, y + u * wektorxy + u * wektoryy, z + u * wektorxz + u * wektoryz, wektorzx, wektorzy, wektorzz, wektorxx, wektorxy, wektorxz, wektoryx, wektoryy, wektoryz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektoryx, y + u * wektoryy, z + u * wektoryz, -wektorxx, -wektorxy, -wektorxz, -wektoryx, -wektoryy, -wektoryz, wektorzx, wektorzy, wektorzz, wspolrzedne)
        hilbert(n-1,u, x+u*wektoryx+u*wektorzx, y+u*wektoryy+u*wektorzy, z+u*wektoryz+u*wektorzz, -wektorxx, -wektorxy, -wektorxz, -wektoryx, -wektoryy, -wektoryz, wektorzx, wektorzy, wektorzz,wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx + u * wektoryx + u * wektorzx, y + u * wektorxy + u * wektoryy + u * wektorzy, z + u * wektorxz + u * wektoryz + u * wektorzz, -wektorzx, -wektorzy, -wektorzz, wektorxx, wektorxy, wektorxz, -wektoryx, -wektoryy, -wektoryz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorxx + u * wektorzx, y + u * wektorxy + u * wektorzy, z + u * wektorxz + u * wektorzz, -wektorzx, -wektorzy, -wektorzz, wektorxx, wektorxy, wektorxz, -wektoryx, -wektoryy, -wektoryz, wspolrzedne)
        hilbert(n - 1, u, x + u * wektorzx, y + u * wektorzy, z + u * wektorzz, wektoryx, wektoryy, wektoryz, -wektorzx, -wektorzy, -wektorzz, -wektorxx, -wektorxy, -wektorxz, wspolrzedne)
        """
def transormacja(d, obrotx, obroty):
    #zaczynamy od obrotu potem przesuniecie
    radx = radians(obrotx)
    rady = radians(obroty)
    mobrotux = [[1,0,0,0],[0,cos(radx),-sin(radx),0],[0,sin(radx),cos(radx),0],[0,0,0,1]]
    mobrotuy = [[cos(rady),0,sin(rady),0],[0,1,0,0],[-sin(rady),0,cos(rady),0],[0,0,0,1]]
    mtrans = [[1,0,0,1],[0,1,0,1],[0,0,1,d],[0,0,0,1]]
    #return matrixmult(mobrotux,mobrotuy)
    return matrixmult(mtrans,matrixmult(mobrotux,mobrotuy))

def matrixmult (A, B):
    rows_A = len(A)
    cols_A = len(A[0])
    rows_B = len(B)
    cols_B = len(B[0])

    if cols_A != rows_B:
      print ("Cannot multiply the two matrices. Incorrect dimensions.")
      return

    # Create the result matrix
    # Dimensions would be rows_A x cols_B
    C = [[0 for row in range(cols_B)] for col in range(rows_A)]
    #print C

    for i in range(rows_A):
        for j in range(cols_B):
            for k in range(cols_A):
                C[i][j] += A[i][k] * B[k][j]
    return C

def wspto2d(d,fi,psi,wspolrzedne):
    dwawym = list()
    macierz = transormacja(d,fi,psi)
    for wspolrzedna in wspolrzedne:
        trzywym = matrixmult(macierz,wspolrzedna)
        rzut = d/(trzywym[2][0]+d)
        dwawym.append([trzywym[0][0],trzywym[1][0]])
    return dwawym

def hilbert3d(n,s,u,d,x,y,z,fi,psi):
    plik = open('plik1.ps','w')
    plik.truncate()
    wspolrzedne = list()
    hilbert(n,1,0,0,0,1,0,0,0,1,0,0,0,1,wspolrzedne)
    skaluj(wspolrzedne,u)
    przesun(wspolrzedne,x,y,z)
    print(len(wspolrzedne))
    punkty = wspto2d(d,fi,psi,wspolrzedne)
    plik.write('%!PS-Adobe-2.0 EPSF-2.0 \n')
    plik.write('%%BoundingBox: 0 0'+ ' ' + str(s) + ' ' + str(s)+'\n')
    plik.write('newpath' +'\n')
    plik.write('1.0 1.0 moveto'+'\n')
    for x in punkty:
        plik.write(str(float(x[0]))+' ' + str(float(x[1])) + ' ' + 'lineto' + ' ' +'\n')
    plik.write(".4 setlinewidth"+'\n')
    plik.write("stroke"+'\n')
    plik.write("showpage"+'\n')
    plik.write("%%Trailer"+'\n')
    plik.write("%EOF"+'\n')

def skaluj(wspolrzedne,d):
    for x in range(len(wspolrzedne)):
        wspolrzedne[x][0][0] = wspolrzedne[x][0][0]*d
        wspolrzedne[x][1][0] = wspolrzedne[x][1][0]*d
        wspolrzedne[x][2][0] = wspolrzedne[x][2][0]*d

def przesun(wspolrzedne,x,y,z):
    for i in range(len(wspolrzedne)):
        wspolrzedne[i][0][0] = wspolrzedne[i][0][0]+x
        wspolrzedne[i][1][0] = wspolrzedne[i][1][0]+y
        wspolrzedne[i][2][0] = wspolrzedne[i][2][0]+z


#hilbert3d(n,s, u,  d,x,y,z,fi,psi)
hilbert3d(3,500,300,10,100,100,0,30,10)
def kwadrat2d(s,d,fi,psi):
    kwadrat = [[[100],[100],[100],[1]],[[100],[200],[100],[1]],[[200],[200],[100],[1]],[[200],[100],[100],[1]],[[100],[100],[100],[1]]]
    wspolrzedne = list()
    #hilbert(n,u,x,y,z,1,0,0,0,1,0,0,0,1,wspolrzedne)
    #print(wspolrzedne)
    punkty = wspto2d(d,fi,psi,kwadrat)
    print('%!PS-Adobe-2.0 EPSF-2.0')
    print('%%BoundingBox: 0 0', s, s)
    print('newpath')
    print('1.0 1.0 moveto')
    for x in punkty:
        print(float(x[0]),float(x[1]),'lineto')
    print(".4 setlinewidth")
    print("stroke")
    print("showpage")
    print("%%Trailer")
    print("%EOF")

#kwadrat2d(500,10,20,20)




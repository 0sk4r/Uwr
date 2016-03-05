from math import cos, sin, radians
#from visual import *

def hilbert(n, u, x, y, z, dx, dy, dz, dx2, dy2, dz2, dx3, dy3, dz3, wspolrzedne):
    if (n == 0):
        wspolrzedne.append([[x],[y],[z],[1]])
    else:
        u=float(u/2)
        if(dx<0):
            x-=u*dx
        if(dy<0):
            y-=u*dy
        if(dz<0):
            z-=u*dz
        if(dx2<0):
            x-=u*dx2
        if(dy2<0):
            y-=u*dy2
        if(dz2<0):
            z-=u*dz2
        if(dx3<0):
            x-=u*dx3
        if(dy3<0):
            y-=u*dy3
        if(dz3<0):
            z-=u*dz3
        hilbert(n-1,u, x, y, z, dx2, dy2, dz2, dx3, dy3, dz3, dx, dy, dz,wspolrzedne)
        hilbert(n-1,u, x+u*dx, y+u*dy, z+u*dz, dx3, dy3, dz3, dx, dy, dz, dx2, dy2, dz2,wspolrzedne)
        hilbert(n-1,u, x+u*dx+u*dx2, y+u*dy+u*dy2, z+u*dz+u*dz2, dx3, dy3, dz3, dx, dy, dz, dx2, dy2, dz2,wspolrzedne)
        hilbert(n-1,u, x+u*dx2, y+u*dy2, z+u*dz2, -dx, -dy, -dz, -dx2, -dy2, -dz2, dx3, dy3, dz3,wspolrzedne)
        hilbert(n-1,u, x+u*dx2+u*dx3, y+u*dy2+u*dy3, z+u*dz2+u*dz3, -dx, -dy, -dz, -dx2, -dy2, -dz2, dx3, dy3, dz3,wspolrzedne)
        hilbert(n-1,u, x+u*dx+u*dx2+u*dx3, y+u*dy+u*dy2+u*dy3, z+u*dz+u*dz2+u*dz3, -dx3, -dy3, -dz3, dx, dy, dz, -dx2, -dy2, -dz2,wspolrzedne)
        hilbert(n-1,u, x+u*dx+u*dx3, y+u*dy+u*dy3, z+u*dz+u*dz3, -dx3, -dy3, -dz3, dx, dy, dz, -dx2, -dy2, -dz2,wspolrzedne)
        hilbert(n-1,u, x+u*dx3, y+u*dy3, z+u*dz3, dx2, dy2, dz2, -dx3, -dy3, -dz3, -dx, -dy, -dz,wspolrzedne)

def transormacja(d, obrotx, obroty):
    #zaczynamy od obrotu potem przesuniecie
    radx = radians(obrotx)
    rady = radians(obroty)
    mobrotux = [[1,0,0,0],[0,cos(radx),-sin(radx),0],[0,sin(radx),cos(radx),0],[0,0,0,1]]
    mobrotuy = [[cos(rady),0,sin(rady),0],[0,1,0,0],[-sin(rady),0,cos(rady),0],[0,0,0,1]]
    mtrans = [[1,0,0,1],[0,1,0,1],[0,0,1,d],[0,0,0,1]]
    #return matrixmult(mtrans,matrixmult(mobrotux,mobrotuy))
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
        dwawym.append([trzywym[0][0],trzywym[1][0]])
    return dwawym

def hilbert3d(n,s,u,d,x,y,z,fi,psi):
    wspolrzedne = list()
    hilbert(n,u,x,y,z,1,0,0,0,1,0,0,0,1,wspolrzedne)
    print(wspolrzedne)
    punkty = wspto2d(d,fi,psi,wspolrzedne)
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

hilbert3d(4,500,300,50,200,100,100,30,30)




from math import cos,sin,degrees

def hilbert(n, u, x, y, z, dx, dy, dz, dx2, dy2, dz2, dx3, dy3, dz3, wspolrzedne):
    if (n == 1):
        wspolrzedne.append([[x],[y],[z],[1],[1]])
        wspolrzedne.append([[x+u*dx], [y+u*dy], [z+u*dz],[1]])
        wspolrzedne.append([[x+u*dx+u*dx2], [y+u*dy+u*dy2], [z+u*dz+u*dz2],[1]])
        wspolrzedne.append([[x+u*dx2], [y+u*dy2], [z+u*dz2],[1]])
        wspolrzedne.append([ [x+u*dx2+u*dx3], [y+u*dy2+u*dy3], [z+u*dz2+u*dz3],[1]])
        wspolrzedne.append([[x+u*dx+u*dx2+u*dx3], [y+u*dy+u*dy2+u*dy3], [z+u*dz+u*dz2+u*dz3],[1]])
        wspolrzedne.append([[x+u*dx+u*dx3], [y+u*dy+u*dy3], [z+u*dz+u*dz3],[1]])
        wspolrzedne.append([[x+u*dx3], [y+u*dy3], [z+u*dz3],[1]])
        print(x,y,z)
    else:
        u=u/2
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
    radx = math.degrees(obrotx)
    rady = degrees(obroty)
    mobrotux = [[1,0,0,0],[0,cos(radx),-sin(radx),0],[0,sin(radx),cos(radx)],[0,0,0,1]]
    mobrotuy = [[cos(rady),0,sin(rady),0],[0,1,0,0],[-sin(rady),0,cos(rady),0],[0,0,0,1]]
    mtrans = [[1,0,0,1],[0,1,0,1],[0,0,1,-d],[0,0,0,1]]


wspolrzedne = list()
#wspolrzedne = hilbert(1,10,0,0,0,1,0,0,0,1,0,0,0,1)
#print(wspolrzedne)
hilbert(1,10,0,0,0,1,0,0,0,1,0,0,0,1,wspolrzedne)
print (wspolrzedne)
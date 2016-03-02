wspolrzedne = list()
def hilbert(n, u, x, y, z, dx, dy, dz, dx2, dy2, dz2, dx3, dy3, dz3, wspolrzedne):
    if (n == 0):
        wspolrzedne.append([x, y, z,1])
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




#wspolrzedne = hilbert(1,10,0,0,0,1,0,0,0,1,0,0,0,1)
#print(wspolrzedne)
hilbert(2,10,0,0,0,1,0,0,0,1,0,0,0,1,wspolrzedne)
print (wspolrzedne)
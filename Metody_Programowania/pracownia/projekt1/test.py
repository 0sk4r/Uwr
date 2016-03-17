from operator import add
def hilbert(n, head, body, road):

    if n > 0:


        Z = head
        head = up_h(head, body)
        body = up_b(Z, body)
        body = rotate_left(head, body)
        hilbert(n-1, head, body, road)
        R = add(head, road[len(road)-1])
        print R
        road.append(R)
        Z = head
        head = up_h(head, body)
        body = up_b(Z, body)
        body = rotate_left(body, head)
        hilbert(n-1, head, body, road)
        R = add(head, road[len(road)-1])
        print R
        road.append(R)
        hilbert(n-1, head, body, road)
        head = left(head, body)
        R = add(head, road[len(road)-1])
        print R
        road.append(R)
        Z = head
        head = up_h(head, body)
        body = up_b(Z, body)
        body = rotate_right(head, body)
        body = rotate_right(head, body)
        hilbert(n-1, head, body, road)
        R = add(head, road[len(road)-1])
        print R
        road.append(R)
        hilbert(n-1, head, body, road)
        Z = head
        head = down_h(head, body)
        body = down_b(Z, body)
        R = add(head, road[len(road)-1])
        print R
        road.append(R)
        head = right(head, body)
        body = rotate_right(head, body)
        body = rotate_right(head, body)
        hilbert(n-1, head, body, road)
        R = add(head,    road[len(road)-1])
        print R
        road.append(R)
        hilbert(n-1, head, body, road)
        head = left(head, body)
        R = add(head, road[len(road)-1])
        print R
        road.append(R)
        body = rotate_right(head, body)
        hilbert(n-1, head, body, road)
        head = left(head, body)
        body = rotate_right(head, body)

        #return road

def add(X, Y):
    Z = Y
    for i in range(len(Z)):
        Z[i] += X[i]
    return Z

def up_h(x, y):

#    x = (-1)*y
    x = y
    for i in range(len(x)):
        y[i] *= (-1)
    return x

def up_b(x, y):

#    z = x
#    x = (-1)*y
#    for i in range(len(x)):
#        x[i] *= (-1)
#    y = z

    y = x
    return y


def down_h(x, y):

    x = y
    return x

def down_b(x, y):

    y = x
    #y = (-1)*y
    for i in range(len(x)):
        y[i] *= (-1)
    return y

def right(x, y):

    if x == [-1, 0, 0]:
        if y == [0, -1, 0]:
            x = [0, 0, -1]
        elif y == [0, 1, 0]:
            x = [0, 0, 1]
        elif y == [0, 0, 1]:
            x = [0, -1, 0]
        elif y == [0, 0, -1]:
            x = [0, 1, 0]

    elif x == [1, 0, 0]:
         if y == [0, -1, 0]:
             x = [0, 0, 1]
         elif y == [0, 1, 0]:
             x = [0, 0, -1]
         elif y == [0, 0, 1]:
             x = [0, 1, 0]
         elif y == [0, 0, -1]:
             x = [0, -1, 0]

    elif x == [0, -1, 0]:
        if y == [-1, 0, 0]:
            x = [0, 0, -1]
        elif y == [1, 0, 0]:
            x = [0, 0, 1]
        elif y == [0, 0, 1]:
            x = [-1, 0, 0]
        elif y == [0, 0, -1]:
            x = [1, 0, 0]

    elif x == [0, 1, 0]:
        if y == [-1, 0, 0]:
            x = [0, 0, 1]
        elif y == [1, 0, 0]:
            x = [0, 0, -1]
        elif y == [0, 0, 1]:
            x = [1, 0, 0]
        elif y == [0, 0, -1]:
            x = [-1, 0, 0]

    elif x == [0, 0, -1]:
        if y == [-1, 0, 0]:
            x = [0, -1, 0]
        elif y == [1, 0, 0]:
            x = [0, 1, 0]
        elif y == [0, -1, 0]:
            x = [-1, 0, 0]
        elif y == [0, 1, 0]:
            x = [1, 0, 0]

    elif x == [0, 0, 1]:
        if y == [-1, 0, 0]:
            x = [0, 1, 0]
        elif y == [1, 0, 0]:
            x = [0, -1, 0]
        elif y == [0, 1, 0]:
            x = [-1, 0, 0]
        elif y == [0, -1, 0]:
            x = [1, 0, 0]

    return x

def left(x, y):
    if x == [-1, 0, 0]:
        if y == [0, -1, 0]:
            x = [0, 0, 1]
        elif y == [0, 1, 0]:
            x = [0, 0, -1]
        elif y == [0, 0, 1]:
            x = [0, 1, 0]
        elif y == [0, 0, -1]:
            x = [0, -1, 0]

    elif x == [1, 0, 0]:
         if y == [0, -1, 0]:
             x = [0, 0, -1]
         elif y == [0, 1, 0]:
             x = [0, 0, 1]
         elif y == [0, 0, 1]:
             x = [0, -1, 0]
         elif y == [0, 0, -1]:
             x = [0, 1, 0]

    elif x == [0, -1, 0]:
        if y == [-1, 0, 0]:
            x = [0, 0, 1]
        elif y == [1, 0, 0]:
            x = [0, 0, -1]
        elif y == [0, 0, 1]:
            x = [1, 0, 0]
        elif y == [0, 0, -1]:
            x = [-1, 0, 0]

    elif x == [0, 1, 0]:
        if y == [-1, 0, 0]:
            x = [0, 0, -1]
        elif y == [1, 0, 0]:
            x = [0, 0, 1]
        elif y == [0, 0, 1]:
            x = [-1, 0, 0]
        elif y == [0, 0, -1]:
            x = [1, 0, 0]

    elif x == [0, 0, -1]:
        if y == [-1, 0, 0]:
            x = [0, 1, 0]
        elif y == [1, 0, 0]:
            x = [0, -1, 0]
        elif y == [0, -1, 0]:
            x = [1, 0, 0]
        elif y == [0, 1, 0]:
            x = [-1, 0, 0]

    elif x == [0, 0, 1]:
        if y == [-1, 0, 0]:
            x = [0, -1, 0]
        elif y == [1, 0, 0]:
            x = [0, 1, 0]
        elif y == [0, 1, 0]:
            x = [1, 0, 0]
        elif y == [0, -1, 0]:
            x = [-1, 0, 0]

    return x

def rotate_left(x, y):

    if y == [-1, 0, 0]:
          if x == [0, -1, 0]:
              y = [0, 0, 1]
          elif x == [0, 1, 0]:
              y = [0, 0, -1]
          elif x == [0, 0, 1]:
              y = [0, 1, 0]
          elif x == [0, 0, -1]:
              y = [0, -1, 0]

    elif y == [1, 0, 0]:
           if x == [0, -1, 0]:
               y = [0, 0, -1]
           elif x == [0, 1, 0]:
               y = [0, 0, 1]
           elif x == [0, 0, 1]:
               y = [0, -1, 0]
           elif x == [0, 0, -1]:
               y = [0, 1, 0]

    elif y == [0, -1, 0]:
          if x == [-1, 0, 0]:
              y = [0, 0, 1]
          elif x == [1, 0, 0]:
              y = [0, 0, -1]
          elif x == [0, 0, 1]:
              y = [1, 0, 0]
          elif x == [0, 0, -1]:
              y = [-1, 0, 0]

    elif y == [0, 1, 0]:
          if x == [-1, 0, 0]:
              y = [0, 0, -1]
          elif x == [1, 0, 0]:
              y = [0, 0, 1]
          elif x == [0, 0, 1]:
              y = [-1, 0, 0]
          elif x == [0, 0, -1]:
              y = [1, 0, 0]

    elif y == [0, 0, -1]:
          if x == [-1, 0, 0]:
              y = [0, 1, 0]
          elif x == [1, 0, 0]:
              y = [0, -1, 0]
          elif x == [0, -1, 0]:
              y = [1, 0, 0]
          elif x == [0, 1, 0]:
              y = [-1, 0, 0]

    elif y == [0, 0, 1]:
          if x == [-1, 0, 0]:
              y = [0, -1, 0]
          elif x == [1, 0, 0]:
              y = [0, 1, 0]
          elif x == [0, 1, 0]:
              y = [1, 0, 0]
          elif x == [0, -1, 0]:
              y = [-1, 0, 0]

    return y

def rotate_right(x, y):

    if y == [-1, 0, 0]:
          if x == [0, -1, 0]:
              y = [0, 0, -1]
          elif x == [0, 1, 0]:
              y = [0, 0, 1]
          elif x == [0, 0, 1]:
              y = [0, -1, 0]
          elif x == [0, 0, -1]:
              y = [0, 1, 0]

    elif y == [1, 0, 0]:
           if x == [0, -1, 0]:
               y = [0, 0, 1]
           elif x == [0, 1, 0]:
               y = [0, 0, -1]
           elif x == [0, 0, 1]:
               y = [0, 1, 0]
           elif x == [0, 0, -1]:
               y = [0, -1, 0]

    elif y == [0, -1, 0]:
          if x == [-1, 0, 0]:
              y = [0, 0, -1]
          elif x == [1, 0, 0]:
              y = [0, 0, 1]
          elif x == [0, 0, 1]:
              y = [-1, 0, 0]
          elif x == [0, 0, -1]:
              y = [1, 0, 0]

    elif y == [0, 1, 0]:
          if x == [-1, 0, 0]:
              y = [0, 0, 1]
          elif x == [1, 0, 0]:
              y = [0, 0, -1]
          elif x == [0, 0, 1]:
              y = [1, 0, 0]
          elif x == [0, 0, -1]:
              y = [-1, 0, 0]

    elif y == [0, 0, -1]:
          if x == [-1, 0, 0]:
              y = [0, -1, 0]
          elif x == [1, 0, 0]:
              y = [0, 1, 0]
          elif x == [0, -1, 0]:
              y = [-1, 0, 0]
          elif x == [0, 1, 0]:
              y = [1, 0, 0]

    elif y == [0, 0, 1]:
          if x == [-1, 0, 0]:
              y = [0, 1, 0]
          elif x == [1, 0, 0]:
              y = [0, -1, 0]
          elif x == [0, 1, 0]:
              y = [-1, 0, 0]
          elif x == [0, -1, 0]:
              y = [1, 0, 0]

    return y



road = [[0,0,0]]
head = [1,0,0]
body = [0,1,0]

hilbert(1, head, body, road)

print(road)
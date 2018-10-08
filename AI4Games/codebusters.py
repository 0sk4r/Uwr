import sys
import math
import random

# Send your busters out into the fog to trap ghosts and bring them home!

class Buster:
    id = 0
    x = 0
    y = 0
    state = 0
    value = 0

class Ghost:
    id = 0
    x = 0
    y = 0
    state = 0
    value = 0
    seen = 0

busters_per_player = int(input())  # the amount of busters you control
ghost_count = int(input())  # the amount of ghosts on the map
my_team_id = int(input())  # if this is 0, your base is on the top left of the map, if it is one, on the bottom right

bustersList = []
ghostList = []

for i in range(busters_per_player):
    bustersList.append(Buster())

for i in range(ghost_count):
   ghostList.append(Ghost())


# game loop
while True:


    entities = int(input())  # the number of busters and ghosts visible to you

    for i in range(ghost_count):
        ghostList[i].seen = 0
    
    for i in range(entities):
        # entity_id: buster id or ghost id
        # y: position of this buster / ghost
        # entity_type: the team id if it is a buster, -1 if it is a ghost.
        # state: For busters: 0=idle, 1=carrying a ghost.
        # value: For busters: Ghost id being carried. For ghosts: number of busters attempting to trap this ghost.
        x = input()
        print(x, file = sys.stderr)
        
        entity_id, x, y, entity_type, state, value = [int(j) for j in x.split()]

        if(entity_type == my_team_id):
            print("CZLOWIEK", file = sys.stderr)
            bustersList[entity_id].x = x
            bustersList[entity_id].y = y
            bustersList[entity_id].state = state
            bustersList[entity_id].value = value 
        
        if(entity_type == -1):
            print("DUCH", file = sys.stderr)
            ghostList[entity_id].x = x
            ghostList[entity_id].y = y
            ghostList[entity_id].state = state
            ghostList[entity_id].value = value 
            ghostList[entity_id].seen = 1

    # idz do ducha ktorego widac
    for ghost in ghostList:
        if(ghost.seen == 1):
            print("Widze ducha", file = sys.stderr)
            for i in range(busters_per_player):
                print("MOVE {} {}".format(ghost.x, ghost.y))
            break
        # else:
        #     #go in random direction
        #     print("Nie widze ducha", file = sys.stderr)
        #     x = random.randint(0,16000)
        #     y = random.randint(0,9000)
        #     for i in range(busters_per_player):
        #         print("MOVE {} {}".format(x,y))
        
    # for i in range(busters_per_player):
    #     # MOVE x y | BUST id | RELEASE
        
    #     if(entity_type == -1):
    #         print("MOVE {} {}".format(x,y))
    #         print("BUST {}".format(entity_id))
    #     else:
    #         print("MOVE 8000 4500")
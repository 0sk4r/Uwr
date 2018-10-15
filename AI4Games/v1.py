# drewno miejsce 4
#NAJLEPSZA KURWA WERSJA
#TODO doadac stunowanie kiedy mozna
import sys
import math
import random


# Send your busters out into the fog to trap ghosts and bring them home!

def dist(v1, v2):
    dx = v1.x - v2.x
    dy = v1.y - v2.y
    return math.sqrt(dx * dx + dy * dy)


class Buster:

    def __init__(self, id, n):
        self.id = id
        self.x = 0
        self.y = 0
        self.state = 0
        self.value = 0
        self.next_task = None

        self.minX = 0
        self.minY = 0

        self.direction = 16000
        area = 9000 / n
        self.minY = self.id * area
        self.maxY = (self.id + 1) * area

    def goInRandomDirection(self):
        if self.x > 14000:
            self.direction = 0
        elif self.x < 2000:
            self.direction = 16000
        y = random.randint(self.minY, self.maxY)
        self.next_task = "MOVE {} {}".format(self.direction, y)

    # def findTarget(self, ghostList):
    #     dist = 0
    #     target = None
    #     for ghost in ghostList:

    def goToBase(self, location):
        if location == 0:
            if self.x < 1000 and self.y < 1000:
                self.next_task = "RELEASE"
                busted.append(self.value)
                print(busted, file=sys.stderr)
            else:
                self.next_task = "MOVE 600 600"
        else:
            if self.x > 14800 and self.y > 7800:
                self.next_task = "RELEASE"
                busted.append(self.value)
                print(busted, file=sys.stderr)
            else:
                self.next_task = "MOVE 15400 8400"

    def setTask(self, task):
        self.next_task = task


class Ghost:
    def __init__(self):
        self.id = 0
        self.x = 0
        self.y = 0
        self.state = 0
        self.value = 0
        self.visible = 0


class Enemy:
    def __init__(self):
        self.id = 0
        self.x = 0
        self.y = 0
        self.state = 0
        self.value = 0
        self.visible = 0


busters_per_player = int(input())  # the amount of busters you control
ghost_count = int(input())  # the amount of ghosts on the map
my_team_id = int(input())  # if this is 0, your base is on the top left of the map, if it is one, on the bottom right
if my_team_id == 0:
    enemy_team_id = 1
else:
    enemy_team_id = 0
print(my_team_id, file=sys.stderr)

busted = []
bustersList = []
ghostList = []
enemyList = []

for i in range(busters_per_player):
    # print("BUSTER id {}".format(i), file = sys.stderr)
    bustersList.append(Buster(i, busters_per_player))

for i in range(ghost_count):
    # print("GHOST id {}".format(i),file = sys.stderr)
    ghostList.append(Ghost())

for i in range(busters_per_player):
    enemyList.append(Enemy())

# game loop
while True:

    ghost_in_range = []
    entities = int(input())  # the number of busters and ghosts visible to you
    # print(entities, file = sys.stderr)
    for i in range(ghost_count):
        ghostList[i].visible = 0
    for i in range(busters_per_player):
        enemyList[i].visible = 0

    for i in range(entities):
        # entity_id: buster id or ghost id
        # y: position of this buster / ghost
        # entity_type: the team id if it is a buster, -1 if it is a ghost.
        # state: For busters: 0=idle, 1=carrying a ghost.
        # value: For busters: Ghost id being carried. For ghosts: number of busters attempting to trap this ghost.
        x = input()
        #

        entity_id, x, y, entity_type, state, value = [int(j) for j in x.split()]

        if (entity_type == my_team_id):
            if my_team_id == 1:
                entity_id = entity_id - busters_per_player
            # print(entity_id, file = sys.stderr)
            bustersList[entity_id].x = x
            bustersList[entity_id].y = y
            bustersList[entity_id].state = state
            bustersList[entity_id].value = value

        elif (entity_type == -1):
            # print("DUCH", file = sys.stderr)
            # print(entity_id, file = sys.stderr)

            ghostList[entity_id].id = entity_id
            ghostList[entity_id].x = x
            ghostList[entity_id].y = y
            ghostList[entity_id].state = state
            ghostList[entity_id].value = value
            ghostList[entity_id].visible = 1

        elif entity_type == enemy_team_id:
            print(x, file=sys.stderr)
            if my_team_id == 0:
                i = entity_id - busters_per_player
            else:
                i = entity_id
            enemyList[i].id = entity_id
            enemyList[i].x = x
            enemyList[i].y = y
            enemyList[i].state = state
            enemyList[i].value = value
            enemyList[i].visible = 1

    for ghost in ghostList:
        if ghost.visible:
            ghost_in_range.append(ghost)

    if len(ghost_in_range) > 0:
        for g in ghost_in_range:
            if g.id not in busted:
                print("lapie ducha {}".format(g.id), file=sys.stderr)
                busting_ghost = g
                break

        for buster in bustersList:
            print(dist(buster, busting_ghost), file=sys.stderr)
            if (dist(buster, busting_ghost) < 1750):
                buster.next_task = "BUST {}".format(busting_ghost.id)
            else:
                buster.next_task = "MOVE {} {}".format(busting_ghost.x, busting_ghost.y)
    else:
        for buster in bustersList:
            buster.goInRandomDirection()

    for e in enemyList:
        if e.visible == 1 and e.value < 4:
            for buster in bustersList:
                if dist(buster, e) < 1750:
                    buster.next_task = "STUN {}".format(e.id)
            break

    for buster in bustersList:
        if buster.state == 1:
            print("ide do bazy", file=sys.stderr)
            buster.goToBase(my_team_id)

    # if len(enemy) > 0:
    #     for buster in bustersList:
    #         buster.next_task = "STUN {}".format(enemy[0])
    for buster in bustersList:
        print(buster.next_task)
        print(buster.next_task, file=sys.stderr)


import json

f = open("testgen.json","w") 

q = { "new": { "admin": 0, "passwd": "asd", "data":"lvl1", "newpasswd":"asd"} }

for i in range(1,1000):
    q["new"]["emp1"] = i - 1
    q["new"]["emp"] = i
    f.write(json.dumps(q))
    f.write("\n")

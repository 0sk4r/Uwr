import psycopg2
import json
import sys

class DBInterface:
    def __init__(self, login, pwd, dbname):
        try:
            print('connection')
            self.connection = psycopg2.connect(
                user=login, password=pwd, dbname=dbname)
            self.curr = self.connection.cursor()
        except Exception as e:
            print(e)
            error = {"status": "ERROR"}
            print(json.dumps(error))

    def authenticate(self, id, pwd):
        querry = "SELECT id FROM workers WHERE id = %s AND Password = crypt(%s, password)"

        self.curr.execute(querry, (id, pwd,))

        if(self.curr.fetchone()): return True
        return False

    def authenticate_hiearchy(self, id_admin, pwd, id_worker):
        querry_search = "SELECT Superior FROM workers WHERE ID = %s"
        querry_autchenticate = querry = "SELECT id FROM workers WHERE id = %s AND Password = crypt(%s, password)"

        res = id_worker

        try:
            while(res is not None):
                if(res == id_admin): return True
                self.curr.execute(querry_search, (res,))
                res = self.curr.fetchall()[0][0]
            
            return False
        except Exception as e:
            print(e)
            return False



    def initialize(self):
        query = """CREATE TABLE IF NOT EXISTS workers(
            ID INT NOT NULL,
            Password VARCHAR(99) NOT NULL,
            Superior INT,
            Data VARCHAR(100),
            PRIMARY KEY (ID),
            FOREIGN KEY (Superior) REFERENCES workers(ID) ON DELETE CASCADE);"""

        try:
            self.curr.execute(query)
            ok = {"status": "OK"}
            print(json.dumps(ok))
            self.connection.commit()
        except Exception as e:
            print(e)
            error = {"status": "ERROR","initialize erro":True}
            print(json.dumps(error))

        # self.curr.execute("CREATE EXTENSION pgcrypto;")

    def root(self, data):
        querry = "INSERT INTO workers(ID, Password, Data) VALUES(%s,crypt(%s, gen_salt('bf', 8)),%s)"
        
        secret = data["secret"]
        pwd = data["newpassword"]
        d = data["data"]
        id = data["emp"]
        
        if(secret == "qwerty"):
            try:
                self.curr.execute(querry, (id, pwd, d,))
                ok = {"status": "OK", "debug": "root created"}
                print(json.dumps(ok))
            except Exception as e:
                print(e)
                error = {"status": "ERROR", "debug":"problem with root creation"}
                print(json.dumps(error))
        else:
            error = {"status": "ERROR","debug":"wrong secret"}
            print(json.dumps(error))
        self.connection.commit()

    def new(self, data):
        querry = "INSERT INTO workers(ID, Password, Data, Superior) VALUES(%s,crypt(%s, gen_salt('bf', 8)),%s,%s)"
        
        admin = data["admin"]
        pwd = data["passwd"]
        d = data["data"]
        npwd = data["newpasswd"]
        id_superior = data["emp1"]
        id = data["emp"]

        if(self.authenticate_hiearchy(admin, pwd, id_superior)):
            try:
                self.curr.execute(querry, (id, pwd, d,id_superior,))
                ok = {"status": "OK", "debug": "created worker id {0}".format(id)}
                print(json.dumps(ok))
            except Exception as e:
                print(e)
                error = {"status": "ERROR","debug": "worker creation failed id {0}".format(id)}
                print(json.dumps(error))

            self.connection.commit()
        else:
            error = {"status": "ERROR", "debug":"Wrong paswd"}
            print(json.dumps(error))

    def remove(self, data):
        querry = "DELETE FROM workers WHERE ID = %s"
        querry_parent = "SELECT Superior FROM workers WHERE ID = %s"
        admin = data["admin"]
        pwd = data["passwd"]
        id = data["emp"]
        parent = None
        try:
            self.curr.execute(querry_parent, (id,))
            res = self.curr.fetchall()
            if (res != []):
                parent =  res[0][0]
        except:
            pass       

        if(parent is not None and self.authenticate_hiearchy(admin,pwd, parent)):
            try:
                self.curr.execute(querry, (id,))
                self.connection.commit()
                ok = {"status": "OK", "debug": "remove worker id {0}".format(id)}
                print(json.dumps(ok))
            except:
                error = {"status": "ERROR", "debug":"remove operation failed id {0}".format(id)}
                print(json.dumps(error))
        else:
            error = {"status": "ERROR", "debug":"Wrong paswd"}
            print(json.dumps(error))


    def child(self,data):
        querry = "SELECT ID FROM workers WHERE Superior = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]

        if(self.authenticate(admin, pwd)):
            try:
                self.curr.execute(querry, (id,))
                childrens =  [r[0] for r in self.curr.fetchall()]
                ok = {"status": "OK", "data": childrens, "debug":"childrens for id {0}".format(id)}
                print(json.dumps(ok))
            except Exception as e:
                print(e)
                error = {"status": "ERROR", "debug": "Childred operation failed id {0}".format(id)}
                print(json.dumps(error))
        else:
            error = {"status": "ERROR","debug":"Wrong paswd"}
            print(json.dumps(error))


    def parent(self,data):
        querry = "SELECT Superior FROM workers WHERE ID = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]

        if(self.authenticate(admin, pwd)):
            try:
                self.curr.execute(querry, (id,))
                res = self.curr.fetchall()
                if (res == []):
                    error = {"status": "ERROR"}
                    print(json.dumps(error))
                else:
                    parent =  res[0][0]
                    ok = {"status": "OK", "data":parent}
                    print(json.dumps(ok))
            except Exception as e:
                print(e)
                error = {"status": "ERROR"}
                print(json.dumps(error))
        else:
            error = {"status": "ERROR","debug":"Wrong paswd"}
            print(json.dumps(error))  

    def update(self, data):
        querry = "UPDATE workers SET Data = %s WHERE ID = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]
        newdata = data["newdata"]
        if(self.authenticate_hiearchy(admin, pwd, id)):
            try:
                self.curr.execute(querry, (newdata,id,))
                ok = {"status": "OK", "debug":"Update information for id {0}".format(id)}
                print(json.dumps(ok))
            except Exception as e:
                error = {"status": "ERROR", "debug": e}
                print(json.dumps(error))
            self.connection.commit()
        else:
            error = {"status": "ERROR", "debug":"Wrong paswd"}
            print(json.dumps(error))

    def read(self,data):
        querry = "SELECT Data FROM workers WHERE ID = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]

        if(self.authenticate_hiearchy(admin, pwd, id)):
            try:
                self.curr.execute(querry, (id,))
                data =  self.curr.fetchall()[0][0]
                ok = {"status": "OK", "data": data, "debug": "data for id {0}".format(id)}
                print(json.dumps(ok))
            except Exception as e:
                print(e)
                error = {"status": "ERROR", "debug": "read data failed id {0}".format(id)}
                print(json.dumps(error))
        else:
            error = {"status": "ERROR", "debug":"Wrong paswd"}
            print(json.dumps(error))

    def descendants(self, data):
        querry = "SELECT ID FROM workers WHERE Superior = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]
        queue = [data["emp"]]
        data = []

        if(self.authenticate(admin, pwd)):
            while(len(queue) != 0):
                search_id = queue[0]
                queue = queue[1:]
                try:
                    self.curr.execute(querry, (search_id,))
                    childrens =  [r[0] for r in self.curr.fetchall()]
                    queue += childrens
                    data += childrens
                except Exception as e:
                    error = {"status": "ERROR", "debug": "descendants error"}
                    print(json.dumps(error))
        
            output = {"status":"OK","data": data, "debug": "descendants for id {0}".format(id)}
            print(json.dumps(output))

        else:
            error = {"status": "ERROR", "debug":"Wrong paswd"}
            print(json.dumps(error))  
        

    def ancestors(self, data):
        querry = "SELECT Superior FROM workers WHERE ID = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]

        data = []
        
        if(self.authenticate(admin, pwd)):
            try:
                self.curr.execute(querry, (id,))
                res = self.curr.fetchall()[0][0]
                while(res is not None):
                    self.curr.execute(querry, (res,))
                    data.append(res)
                    res = self.curr.fetchall()[0][0]
                ok = {"status": "OK", "data": data, "debug": "ancesotrs for id {0}".format(id)}
                print(json.dumps(ok))
            except Exception as e:
                error = {"status": "ERROR", "debug":"ancestors error"}
                print(json.dumps(error))   

        else:
            error = {"status": "ERROR","debug":"Wrong paswd"}
            print(json.dumps(error))    
    
    def ancestor(self, data):
        querry = "SELECT Superior FROM workers WHERE ID = %s"


        admin = data["admin"]
        pwd = data["passwd"]
        id1 = data["emp1"]
        id2 = data["emp2"]
        ok =  {"status": "OK","data": False}



        if(self.authenticate(admin, pwd)):
            try:
                self.curr.execute(querry, (id2,))
                res = self.curr.fetchall()[0][0]
                while(res is not None):
                    self.curr.execute(querry, (res,))
                    if(res == id1):
                        ok = {"status": "OK","data": True}
                        break
                    res = self.curr.fetchall()[0][0]

            except Exception as e:
                print(e)
                error = {"status": "ERROR","debug": "ancestor error"}
                print(json.dumps(error))
        
            print(json.dumps(ok))

        else:
            error = {"status": "ERROR", "debug":"Wrong paswd"}
            print(json.dumps(error)) 


        

class JsonInterpreter:
    def __init__(self, file):
        self.file = open(file)
        x = json.loads(self.file.readline())
        connection_info = x["open"]
        try:
            self.db = DBInterface(connection_info["login"], connection_info["password"], connection_info["baza"])
            if(connection_info["login"] == "init"): self.db.initialize()
            ok = {"status": "OK","debug":"connected"}
            print(json.dumps(ok))
        except Exception as e:
            print(e)
            error = {"status": "ERROR"}
            print(json.dumps(error)) 

    def execute(self):
        for line in self.file:
            json_data = json.loads(line)
            func = list(json_data.keys())[0]
            data = json_data[func]
            getattr(self.db, func)(data)


def main():
    if (len(sys.argv) == 2):
        file = sys.argv[1]
        x = JsonInterpreter(file)
        x.execute()
    else:
        print("Wrong argument number")


if __name__ == "__main__":
    main()

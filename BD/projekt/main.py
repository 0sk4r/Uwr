import psycopg2
import json


class DBInterface:
    def __init__(self, login, pwd, dbname):
        try:
            print('connection')
            self.connection = psycopg2.connect(user=login, password=pwd, dbname=dbname)
            self.curr = self.connection.cursor()
        except:
            error = {"status": "ERROR"}
            print(json.dumps(error))

    def authenticate(self,id, pwd):
        querry = "SELECT id FROM workers WHERE id = %s AND Password = crypt(%s, password)"
        
        self.curr.execute(querry,(id,pwd,))

        if(self.curr.fetchall()): return True
        return False

    def initialize(self):
        query = """CREATE TABLE IF NOT EXISTS workers(
            ID INT NOT NULL,
            Password VARCHAR(99) NOT NULL,
            Superior INT,
            Data VARCHAR(100),
            PRIMARY KEY (ID));"""

        try:
            self.curr.execute(query)
            ok = {"status": "OK"}
            print(json.dumps(ok))
        except:
            error = {"status": "ERROR"}
            print(json.dumps(error))

        # self.curr.execute("CREATE EXTENSION pgcrypto;")
        self.connection.commit()

    def root(self, data):
        querry = "INSERT INTO workers(ID, Password, Data) VALUES(%s,crypt(%s, gen_salt('bf', 8)),%s)"
        
        secret = data["secret"]
        pwd = data["newpassword"]
        d = data["data"]
        id = data["emp"]
        
        if(secret == "qwerty"):
            try:
                self.curr.execute(querry, (id, pwd, d,))
                ok = {"status": "OK"}
                print(json.dumps(ok))
            except:
                error = {"status": "ERROR"}
                print(json.dumps(error))
        else:
            error = {"status": "ERROR"}
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

        try:
            self.curr.execute(querry, (id, pwd, d,id_superior,))
            ok = {"status": "OK"}
            print(json.dumps(ok))
        except Exception as e:
            print(e)
            error = {"status": "ERROR"}
            print(json.dumps(error))

        self.connection.commit()

    def remove(self,data):
        pass

    def child(self,data):
        querry = "SELECT ID FROM workers WHERE Superior = %s"

        id = data["emp"]

        try:
            self.curr.execute(querry, (id,))
            childrens =  [r[0] for r in self.curr.fetchall()]
            ok = {"status": childrens}
            print(json.dumps(ok))
        except Exception as e:
            print(e)
            error = {"status": "ERROR"}
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
                    ok = {"status": parent}
                    print(json.dumps(ok))
            except Exception as e:
                print(e)
                error = {"status": "ERROR"}
                print(json.dumps(error))
        else:
            error = {"status": "ERROR"}
            print(json.dumps(error))  

    def update(self, data):
        querry = "UPDATE workers SET Data = %s WHERE ID = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]
        newdata = data["newdata"]

        try:
            self.curr.execute(querry, (newdata,id,))
            ok = {"status": "OK"}
            print(json.dumps(ok))
        except Exception as e:
            print(e)
            error = {"status": "ERROR"}
            print(json.dumps(error))
        self.connection.commit()

    def read(self,data):
        querry = "SELECT Data FROM workers WHERE ID = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]

        try:
            self.curr.execute(querry, (id,))
            parent =  self.curr.fetchall()[0][0]
            ok = {"status": parent}
            print(json.dumps(ok))
        except Exception as e:
            print(e)
            error = {"status": "ERROR"}
            print(json.dumps(error))

    def descendants(self, data):
        querry = "SELECT ID FROM workers WHERE Superior = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]
        queue = [id]
        data = []
        while(len(queue) != 0):
            id = queue[0]
            queue = queue[1:]
            try:
                self.curr.execute(querry, (id,))
                childrens =  [r[0] for r in self.curr.fetchall()]
                queue += childrens
                data += childrens
            except Exception as e:
                print(e)
                error = {"status": "ERROR"}
                print(json.dumps(error))
        
        output = {"status": data}
        print(json.dumps(output))

    def ancestors(self, data):
        querry = "SELECT Superior FROM workers WHERE ID = %s"

        id = data["emp"]
        admin = data["admin"]
        pwd = data["passwd"]

        data = []
        
        try:
            self.curr.execute(querry, (id,))
            res = self.curr.fetchall()[0][0]
            while(res is not None):
                self.curr.execute(querry, (res,))
                data.append(res)
                res = self.curr.fetchall()[0][0]
            ok = {"status": data}
            print(json.dumps(ok))
        except Exception as e:
            print(e)
            error = {"status": "ERROR"}
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
        self.db.initialize()
        for line in self.file:
            json_data = json.loads(line)
            func = list(json_data.keys())[0]
            data = json_data[func]
            getattr(self.db, func)(data)


def main():
    x = JsonInterpreter("test.json")
    x.execute()


if __name__ == "__main__":
    main()

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

        self.curr.execute("CREATE EXTENSION pgcrypto;")
        self.connection.commit()

    def root(self, data):
        querry = "INSERT INTO workers(ID, Password, Data) VALUES(%s,crypt(%s, gen_salt('bf', 8)),%s)"
        print(data)
        secret = data["secret"]
        pwd = data["newpassword"]
        d = data["data"]
        id = data["emp"]
        try:
            self.curr.execute(querry, (id, pwd, d,))
            ok = {"status": "OK"}
            print(json.dumps(ok))
        except Exception as e:
            print(e)
            error = {"status": "ERROR"}
            print(json.dumps(error))
        self.connection.commit()


class JsonInterpreter:
    def __init__(self, file):
        self.file = open(file)
        x = json.loads(self.file.readline())
        connection_info = x["open"]
        self.db = DBInterface(connection_info["login"], connection_info["password"], connection_info["baza"])

        if(connection_info["login"] == "init"): self.db.initialize()

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

import psycopg2
import json

class DBInterface:
    def __init__(self, login, pwd,dbname):
        try:
            print('connection')
            self.connection = psycopg2.connect(user = login, password = pwd, dbname = dbname)
            self.curr = self.connection.cursor()
        except:
            error = { "status": "ERROR" }
            print(json.dumps(error))


    def root(self, data):
        print('udalo sie')
        print(data)

class JsonInterpreter:
    def __init__(self, file):
        self.file = open(file)
        x = json.loads(self.file.readline())
        connection_info = x["open"]
        self.db = DBInterface(connection_info["login"], connection_info["password"], connection_info["baza"])

    def execute(self):
        for line in self.file:
            json_data = json.loads(line)
            func = list(json_data.keys())[0]
            data = json_data[func]
            print(func)
            print(data)
            getattr(self.db, func)(data)


def main():
    x = JsonInterpreter("test.json")
    x.execute()



if __name__ == "__main__":
    main()
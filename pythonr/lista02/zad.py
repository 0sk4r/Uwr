class Expression:
    def __init__(self, w1):
        self.expr = w1

    def calculate(self, vars):
        try:
            return self.expr.calculate(vars)
        except ZeroDivisionError:
            print("Dzielenie przez zero!!!")
        except NameError:
            print("Nie zdefiniowana zmienna!!!")


class Add(Expression):
    def __init__(self, e1, e2):
        self.expr1 = e1
        self.expr2 = e2

    def calculate(self, vars):
        return self.expr1.calculate(vars) + self.expr2.calculate(vars)


class Minus(Expression):
    def __init__(self, e1, e2):
        self.expr1 = e1
        self.expr2 = e2

    def calculate(self, vars):
        return self.expr1.calculate(vars) - self.expr2.calculate(vars)


class Mult(Expression):
    def __init__(self, e1, e2):
        self.expr1 = e1
        self.expr2 = e2

    def calculate(self, vars):
        return self.expr1.calculate(vars) * self.expr2.calculate(vars)


class Div(Expression):
    def __init__(self, e1, e2):
        self.expr1 = e1
        self.expr2 = e2

    def calculate(self, vars):
        e1 = self.expr1.calculate(vars)
        e2 = self.expr2.calculate(vars)

        if e2 == 0:
            raise (ZeroDivisionError)
        else:
            return e1 * e2


class Var(Expression):
    def __init__(self, x):
        self.var = x

    def calculate(self, vars):
        if self.var in vars:
            return vars[self.var]
        else:
            raise (NameError)


class Cons(Expression):
    def __init__(self, x):
        self.constant = x

    def calculate(self, vars):
        return self.constant


def main():
    x = Expression(Mult(Cons(2), Var("x")))
    print(x.calculate({"w": 10}))


if __name__ == "__main__":
    main()

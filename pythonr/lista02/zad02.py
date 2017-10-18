class Program:
    def __init__(self, p1):
        self.program = p1

    def exec(self, vars):
        try:
            return self.program.exec(vars)
        except ZeroDivisionError:
            print("Dzielenie przez zero!!!")
        except NameError:
            print("Nie zdefiniowana zmienna!!!")

    def __str__(self):
        return str(self.program)


class Mult(Program):
    def __init__(self, e1, e2):
        self.expr1 = e1
        self.expr2 = e2

    def exec(self, vars):
        return self.expr1.exec(vars) * self.expr2.exec(vars)

    def __str__(self):
        return "%s * %s" % (self.expr1, self.expr2)


class Div(Program):
    def __init__(self, e1, e2):
        self.expr1 = e1
        self.expr2 = e2

    def exec(self, vars):
        e1 = self.expr1.exec(vars)
        e2 = self.expr2.exec(vars)

        if e2 == 0:
            raise ZeroDivisionError
        else:
            return e1 * e2

    def __str__(self):
        return "%s  %s" % (self.expr1, self.expr2)


class Var(Program):
    def __init__(self, x):
        self.var = x

    def exec(self, vars):
        if self.var in vars:
            return vars[self.var]
        else:
            raise NameError

    def __str__(self):
        return self.var


class Cons(Program):
    def __init__(self, x):
        self.constant = x

    def exec(self, vars):
        return self.constant

    def __str__(self):
        return str(self.constant)


class Assign(Program):
    def __init__(self, var, val, e1):
        self.variable = var
        self.value = val
        self.expr = e1

    def exec(self, vars):
        vars[self.variable] = self.value.exec(vars)
        return self.expr.exec(vars)

    def __str__(self):
        return "%s = %s\n%s" % (self.variable, self.value, self.expr)


class Condition(Program):
    def __init__(self, x, e1, e2):
        self.bool = x
        self.expr1 = e1
        self.expr2 = e2

    def exec(self, vars):
        if self.bool != 0:
            return self.expr1.exec
        else:
            return self.expr2.exec

    def __str__(self):
        return "if %s:\n" \
               "    %s\n" \
               "else: \n" \
               "    %s" % (self.bool, self.expr1, self.expr2)


class Loop(Program):
    def __init__(self, var, end, expr):
        self.


def main():
    x = Program(Condition(Cons(1), Mult(Cons(1), Var("X")), Mult(Cons(1), Var("Y"))))
    print(x)


if __name__ == "__main__":
    main()

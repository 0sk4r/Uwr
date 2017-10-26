class Program:
    def __init__(self, p):
        self.program = p

    def exec(self, vars):
        try:
            return self.program.exec(vars)
        except ZeroDivisionError:
            print("Dzielenie przez zero!!!")
        except NameError:
            print("Nie zdefiniowana zmienna!!!")

    def __str__(self):
        return str(self.program)


class Add(Program):
    def __init__(self, e1, e2):
        self.expr1 = e1
        self.expr2 = e2

    def exec(self, vars):
        return self.expr1.exec(vars) + self.expr2.exec(vars)

    def __str__(self):
        return "%s + %s" % (self.expr1, self.expr2)


class Minus(Program):
    def __init__(self, e1, e2):
        self.expr1 = e1
        self.expr2 = e2

    def exec(self, vars):
        return self.expr1.exec(vars) - self.expr2.exec(vars)

    def __str__(self):
        return "%s - %s" % (self.expr1, self.expr2)


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
            return e1 / e2

    def __str__(self):
        return "%s / %s" % (self.expr1, self.expr2)


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


class Bool(Program):
    def __init__(self, e1, op, e2):
        self.expresion1 = e1
        self.expresion2 = e2
        self.operator = op

    def exec(self, vars):
        v1 = self.expresion1.exec(vars)
        v2 = self.expresion2.exec(vars)

        usr_func = str(v1) + str(self.operator) + str(v2)
        return eval(usr_func)

    def __str__(self):
        return "%s %s %s" % (
            self.expresion1,
            self.operator,
            self.expresion2
        )


class Condition(Program):
    def __init__(self, x, e1, e2):
        self.bool = x
        self.expr1 = e1
        self.expr2 = e2

    def exec(self, vars):
        lol = self.bool.exec(vars)
        if lol != 0:
            return self.expr1.exec(vars)
        else:
            return self.expr2.exec(vars)

    def __str__(self):
        return "if %s:\n" \
               "    %s\n" \
               "else: \n" \
               "    %s" % (self.bool, self.expr1, self.expr2)


class Loop(Program):
    def __init__(self, var, start, stop, expr):
        self.variable = var
        self.startval = start
        self.stopval = stop
        self.expresion = expr

    def exec(self, vars):
        for i in range(self.startval, self.stopval):
            vars[self.variable] = i
            return self.expresion.exec(vars)

    def __str__(self):
        return "for %s in range(%s, %s):\n" \
               "    %s" % (self.variable, self.startval,
                           self.stopval, self.expresion)


def main():
    add = Program(Add(Cons(2), Cons(3)))
    print(add)
    print(add.exec({}))

    minus = Program(Minus(Cons(2), Cons(3)))
    print(minus)
    print(minus.exec({}))

    mult = Program(Mult(Cons(2), Cons(3)))
    print(mult)
    print(add.exec({}))

    div = Program(Div(Cons(2), Cons(0)))
    print(div)
    print(div.exec({}))

    undef = Program(Var("x"))
    print(undef)
    print(undef.exec({}))

    x1 = Program(Condition(Bool(Cons(2), ">", Cons(3)), Mult(
        Cons(1), Var("X")), Mult(Cons(1), Var("Y"))))
    print(x1.exec(({"X": 2, "Y": 4})))
    print(x1)

    x2 = Program(Loop("x", 1, 5, Mult(Cons(2), Var("x"))))
    print(x2.exec({"X": 2, "Y": 4}))
    print(x2)


if __name__ == "__main__":
    main()

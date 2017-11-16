import re
import queue
import sys


class Scanner:
    def __init__(self, max_depth, func):
        self.function = func
        self.maxDepth = max_depth
        self.next = queue.Queue()
        self.visited = set()

    def scan(self, site, depth=1):
        try:
            page = open(site, 'r', encoding='utf-8').read()
        except:
            e = sys.exc_info()[0]
            print(e)
            print(site)
            return

        if depth == 1:
            self.visited.add(site)

        if depth < self.maxDepth:
            regex = re.compile(r'(?<=href=").*?(?=")')
            for match in regex.finditer(page):
                link = match.group()
                if link not in self.visited:
                    self.visited.add(link)
                    self.next.put((link, depth + 1))

        for match in self.function(page):
            yield match

        if not self.next.empty():
            first = self.next.get()
            for i in self.scan(first[0], first[1]):
                yield i
        else:
            print(self.visited)
            raise StopIteration()


if __name__ == "__main__":
    def f(page):
        expr = re.compile("[\w ]*Python(\w*,* *)*\.")
        iter = expr.finditer(page)
        return [match.group() for match in iter]


    x = Scanner(3, f)
    iter = x.scan("index.html")
    for i in iter:
        print(i)

    print('----')

from urllib.request import urlopen
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
            # page = open(site, 'r', encoding='utf-8').read()
            page = urlopen(site).read().decode('utf-8')
        except:
            # e = sys.exc_info()[0]
            # print(e)
            # print(site)
            # print(self.visited)
            page = -1
            pass
            # print(self.visited)
        if page != -1:
            if depth == 1:

                self.visited.add(site)

            if depth < self.maxDepth:
                regex = re.compile(r'(?<=href=").*?(?=")')
                for match in regex.finditer(page):
                    link = match.group()
                    if (link not in self.visited): #and ".html" in link
                        if link[0] == "/":
                            link = site + link
                        self.visited.add(link)
                        self.next.put((link, depth + 1))

            for x in self.function(page):
                yield x

            if not self.next.empty():
                first = self.next.get()
                for i in self.scan(first[0], first[1]):
                    yield i
            else:
                print(self.visited)
                raise StopIteration()


if __name__ == "__main__":
    def f(page):
        text = re.findall(r'>(.*?)<', page)
        return [t for t in text if "Python" in t]

    x = Scanner(2, f)
    iter = x.scan("http://www.python.org/downloads/release/python-363/")
    for i in iter:
        print(i)

    print("Koniec")

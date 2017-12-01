from urllib.request import urlopen
import re
import sys
import threading
import queue


class Scanner:
    def __init__(self, max_depth, func, site):
        self.function = func
        self.maxDepth = max_depth
        self.next = queue.Queue()
        self.visited = set()
        self.threads = queue.Queue()
        self.visited_lock = threading.Condition()
        self.solution = queue.Queue()
        self.finished = queue.Queue()

        thrd = threading.Thread(target=self.scan, args=(site, 1))
        thrd.start()
        self.threads.put(thrd)

    def iter(self):
        while True:
            try:
                yield self.solution.get()
            except:
                print(
                    "KONIEC!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                if self.threads.qsize() == self.finished.qsize() and self.solution.empty():
                    raise StopIteration()

    def scan(self, site, depth=1):
        try:
            page = urlopen(site).read().decode('utf-8')
        except:
            # e = sys.exc_info()[0]
            # print(e)
            # print(site)
            # print(self.visited)
            page = -1
            self.finished.put(threading.get_ident())
            pass
        if page != -1:

            if depth == 1:
                self.visited.add(site)

            if depth < self.maxDepth:
                regex = re.compile(r'(?<=href=").*?(?=")')

                for match in regex.finditer(page):
                    link = match.group()
                    self.visited_lock.acquire()
                    if link[0] == "/":
                        link = site + link
                    if (link not in self.visited):  # and ".html" in link

                        thrd = threading.Thread(
                            target=self.scan(link, depth + 1))
                        self.threads.put(thrd)
                        self.visited.add(link)
                        thrd.start()

                    self.visited_lock.notify()
                    self.visited_lock.release()

            for xd in self.function(page):
                self.solution.put(xd)
                # print(xd)

            # if not self.next.empty():
            #     first = self.next.get()
            #     for i in self.scan(first[0], first[1]):
            #         yield i
            # else:
            #     print(self.visited)
            #     raise StopIteration()
            # print(site)
            self.finished.put(threading.get_ident())


if __name__ == "__main__":
    def f(page):
        text = re.findall(r'>(.*?)<', page)
        return [t for t in text if "Python" in t]

    x = Scanner(2, f, "http://www.python.rk.edu.pl/w/p/wprowadzenie-do-pythona/")
    # iter = x.scan("http://www.python.org/downloads/release/python-363/")
    iter = x.iter()
    for i in iter:
        print(i)
    # pass

    print("Koniec")

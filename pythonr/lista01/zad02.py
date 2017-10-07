def encrypt(text, code):
    tmp = []
    for char in text:
        encrypted = code ^ ord(char)
        tmp.append(chr(encrypted))
    return "".join(tmp)


def decrypt(text, code):
    tmp = []
    for char in text:
        encrypted = code ^ ord(char)
        tmp.append(chr(encrypted))
    return "".join(tmp)


def main():
    print("Szyfrowanie kluczem 7: Python => %s" % encrypt("Python", 7))
    print("Deszyfrowanie kluczem 7: W~sohi => %s" % encrypt("W~sohi", 7))


if __name__ == '__main__':
    main()

from io import StringIO


def upper_first(str):
    return str[0].upper() + str[1:]


def korekta(str):
    str = upper_first(str)
    if str[-2:] == '. ':
        return str
    elif str[-1] == '.':
        return str + ' '
    else:
        return str + '. '


def zdania(stream):
    sentences = stream.read().split(sep='.')
    sentences = filter(
        None, map(lambda s: s.replace("\n", " ").strip(), sentences))

    for s in sentences:
        yield "%s." % s


if __name__ == "__main__":
    str = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Faucibus ornare suspendisse sed nisi lacus sed viverra tellus. Quam id leo in vitae turpis massa. Tristique senectus et netus et malesuada fames. Convallis tellus id interdum velit laoreet id donec. At augue eget arcu dictum varius. Scelerisque varius morbi enim nunc faucibus a pellentesque sit. At imperdiet dui accumsan sit amet nulla. In tellus integer feugiat scelerisque. Nec ultrices dui sapien eget mi. At auctor urna nunc id cursus metus aliquam. Elit scelerisque mauris pellentesque pulvinar pellentesque habitant morbi tristique. Ullamcorper velit sed ullamcorper morbi. Tempor nec feugiat nisl pretium. Leo in vitae turpis massa. Quis imperdiet massa tincidunt nunc pulvinar sapien et ligula. Purus faucibus ornare suspendisse sed. Purus non enim praesent elementum facilisis leo vel fringilla. Commodo nulla facilisi nullam vehicula."
    in1 = StringIO(str)
    in2 = StringIO(str)
    before = list(zdania(in1))
    after = list(map(lambda s: korekta(s), zdania(in2)))
    print("Przed: ", before)
    print("Po: ", after)
    in1.close()
    in2.close()

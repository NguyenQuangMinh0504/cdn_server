uri = "/somethingelse/fdsfksdg/fgfdgkdfg/something.png"
local b, extension = string.match(uri, '([^\\]-([^%.]+))$')
print(extension)
print(b)
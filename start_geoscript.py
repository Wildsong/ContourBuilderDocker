import sys, os

print("version", sys.version)

import geoscripts

os.chdir('/data')
print("Current directory is ", os.getcwd())
print("My args", sys.argv)





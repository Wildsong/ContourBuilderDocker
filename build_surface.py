import sys
import os

print("version", sys.version)

data = "/data"

# Find all the bare earth coverages

for f in os.listdir(data):
    print(f)


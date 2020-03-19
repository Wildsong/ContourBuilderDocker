import sys
import os

def build_surface(datadir):
    # Find all the bare earth coverages

    for f in os.listdir(datadir):
        print(f)


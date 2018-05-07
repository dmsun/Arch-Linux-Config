#! /usr/bin python

import os

# change the directory to the rom hub
cwd = os.chdir("/home/pi/RetroPie/roms")
extensions = ['.srm', '.eep', '.state', '.hi', '.hs', '.fs'
                                    '.dat', '.cfg', '.nv']
def get_files(directory=os.getcwd()):
    with open("/home/pi/testfile.txt", 'w') as test:
        for root, dir, files in os.walk(directory):
            for name in files:
                if name.endswith(tuple(extensions)):
                    test.write(os.path.join(root, name))
                    test.write("\n")
get_files()

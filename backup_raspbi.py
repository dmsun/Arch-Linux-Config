#! /usr/bin python

import os

# change the directory to the rom hub
cwd = os.chdir("/home/pi/RetroPie/roms")
extensions = ['.srm', '.eep', '.state', '.hi', '.hs', '.fs'
                                    '.dat', '.cfg', '.nv']
def get_files(directory=os.getcwd()):
    for root, dir, files in os.walk(directory):
        for name in files:
#        a, file_extension = os.path.splitext(file)
            if name.endswith(tuple(extensions)):
                print(os.path.join(root, name))
        #elif file_extension in extesions:
#            print(os.path.join(directory, file))
with open("/home/pi/testfile.txt") as test:
    get_files()

#! /usr/bin python

import os

# change the directory to the rom hub
cwd = os.chdir("/home/pi/RetroPie/roms")
extensions = ['.srm', '.eep', '.state', '.hi', '.hs', '.fs'
                                    '.dat', '.cfg', '.nv']
def get_files(directory=os.getcwd()):
    for root, dir, file in os.walk(directory):
        a, file_extension = os.path.splitext(file)
        if file.endswith(tuple(extensions)):
            print("yowza")
        elif file_extension in extesions:
            print(os.path.join(directory, file))
            filelist.write(os.path.join(directory,file))
            filelist.write("\n")
with open("/home/pi/testfile.txt") as test:
    get_files(cwd)

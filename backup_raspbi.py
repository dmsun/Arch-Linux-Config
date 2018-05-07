#! /usr/bin python

import os

# change the directory to the rom hub
os.chdir("/home/pi/RetroPie/roms")

def get_files(directory=os.getcwd()):
    filelist = open("testfile.txt", "w")
    folder_objects = os.listdir(directory)
    for file in folder_objects:
        a, file_extension = os.path.splitext(file)
        if os.path.isdir(os.path.join(directory, file)):
            directory_new =os.path.join(directory, file)
            get_files(directory_new)
        elif file_extension in ['.srm', '.eep', '.state', '.hi', '.hs', '.fs'
                                    '.dat', '.cfg', '.nv']:
            print(os.path.join(directory, file))
            filelist.write(os.path.join(directory,file))
            filelist.write("\n")
    filelist.close()

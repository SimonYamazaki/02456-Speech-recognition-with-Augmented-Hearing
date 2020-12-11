#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 30 11:27:11 2020

@author: simonyamazaki
"""

#from glob import glob
#
#os.chdir('/Users/simonyamazaki/Documents/Deep_learning/Data_recorded/')
#folder_files = glob('Clean_*') 
#folder_files = [f.split('.')[0] for f in folder_files]

import os,sys
os.environ["PATH"]+=":/usr/local/Cellar/ffmpeg/4.3.1_4"
os.environ["PATH"]+=":/usr/local/Cellar/ffmpeg/4.3.1_4/bin"
os.environ["PATH"]+=":/usr/local/Cellar/ffmpeg"
os.environ["PATH"]+=":/usr/local/bin/ffmpeg"
os.environ["PATH"]+=":/usr/local/Cellar/ffprobe"
os.environ["PATH"]+=":/usr/local/Cellar/libav/12.3_8"
print(os.environ["PATH"])

# folder in Data_recorded 
folder_of_interest = "Greek_clean"

folder = '/Users/simonyamazaki/Documents/Deep_learning/Data_recorded/' + folder_of_interest
for filename in os.listdir(folder):
       infilename = os.path.join(folder,filename)
       if not os.path.isfile(infilename): continue
       oldbase = os.path.splitext(filename)
       newname = infilename.replace('.tmp', '.m4a')
       output = os.rename(infilename, newname)


      
# Convert m4a extension files to wav extension files
      
import os
import argparse

from pydub import AudioSegment

formats_to_convert = ['.m4a']

for (dirpath, dirnames, filenames) in os.walk("/Users/simonyamazaki/Documents/Deep_learning/Data_recorded/" + folder_of_interest):
    for filename in filenames:
        if filename.endswith(tuple(formats_to_convert)):

            filepath = dirpath + '/' + filename
            (path, file_extension) = os.path.splitext(filepath)
            file_extension_final = file_extension.replace('.', '')
            try:
                track = AudioSegment.from_file(filepath,
                        file_extension_final)
                wav_filename = filename.replace(file_extension_final, 'wav')
                wav_path = dirpath + '/' + wav_filename
                print('CONVERTING: ' + str(filepath))
                file_handle = track.export(wav_path, format='wav')
                os.remove(filepath)
            except:
                print("ERROR CONVERTING " + str(filepath))

# Rename folder M4a_files as wav_files
#!mv M4a_files wav_files
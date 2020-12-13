#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 18 15:10:01 2020

@author: simonyamazaki
"""


import os
#os.environ["PATH"]+=":/Users/simonyamazaki/opt/anaconda3/lib/python3.7/site-packages"
#os.environ["PATH"]+=":/Users/simonyamazaki/opt/anaconda3/lib/python3.7/site-packages/ffprobe"
#os.environ["PATH"]+=":/Users/simonyamazaki/Documents/Deep_learning/ffmpeg"

#os.environ["PATH"]+=":/usr/local/Cellar/ffmpeg/4.3.1_4"
#os.environ["PATH"]+=":/usr/local/Cellar/ffmpeg/4.3.1_4/bin"
#os.environ["PATH"]+=":/usr/local/Cellar/ffmpeg"
#os.environ["PATH"]+=":/usr/local/bin/ffmpeg"
#os.environ["PATH"]+=":/usr/local/Cellar/ffprobe"
#print(os.environ["PATH"])

from glob import glob

# without _wav at the end
env = 'vietnamaccent'


os.chdir('/Users/simonyamazaki/Documents/Deep_learning/Data_recorded/' + env + '_wav/')

# find files starting with a specific name:
folder_files = glob('vietnam_*') 
#folder_files = glob(env+'_*')   #for files named the same as the folder

folder_files = [f.split('.')[0] for f in folder_files]
#folder_files = [f.split('/')[1] for f in folder_files]


for files in folder_files:
    from pydub import AudioSegment as am
    sound = am.from_file('/Users/simonyamazaki/Documents/Deep_learning/Data_recorded/' +env+ '_wav/' + files + '.wav', format='wav', frame_rate=44100)
    sound = sound.set_frame_rate(16000)
    sound = sound.set_channels(1)
    print("converted file: " + files)
    sound.export('/Users/simonyamazaki/Documents/Deep_learning/Data_recorded/'+env+'_resample_wav/' + files + '_16khz.wav', format='wav')




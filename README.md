# 02456-Speech-recognition-with-Augmented-Hearing

This repository includes all scripts used for preprocessing as well as audio transcription files to recreate main results. 

## Preprocessing 
- Addition of noise audio and speech audio was done using added_noise.m 
- White noise was added to the speech audio using white_noise.m
- Convertion of audio files from .m4a files to .wav files was done using the m4a2wav_converter.py
- Resampling audio files to represent a 16khz sampling rate was done using the resample.py 

## Result recreation
Main results is recreated by running the 02456_Results.ipynb in a Jupyter notebook. 

## Inference 
Inference was done using the docker implementation from [here](https://github.com/loretoparisi/wave2vec-recognize-docker). 




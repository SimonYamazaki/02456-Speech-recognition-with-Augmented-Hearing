# Speech-recognition-with-Augmented-Hearing
For project in Deep Learning course (02456) from the Technical University of Denmark.

By Victor Holm, Louis Lech Nissen and Simon Yamazaki Jensen.

This repository includes:

- all scripts used for preprocessing

- all speech data used for training and inference

- speech transcription files to recreate main results


## Preprocessing 
- Addition of noise audio and speech audio was done using added_noise.m 
- White noise was added to the speech audio using white_noise.m
- Convertion of audio files from .m4a files to .wav files was done using the m4a2wav_converter.py
- Resampling audio files to represent a 16khz sampling rate was done using the resample.py 

## Transcripts
The transcripts folder includes transcriptions produced by usage of the wav2vec 2.0 model for the ASR task and transcriptions produced by the benchmark ASR from google. 

file_name_split: refers to transcription files where the splitting token "//" was inserted to show where individual 10-30 second audio files transcriptions. 

file_name_half_split: refers to transcription files similar to file_name_split however with half the audio files (and the total amount of words spoken is therefore also halved).

## Training 
Training of a fine-tuned acoustic model was done using the training script provided by fairseq and can be found [here](https://github.com/pytorch/fairseq/blob/master/fairseq_cli/hydra_train.py) and training data can be found in "Japanese_train" folder in the data folder of this Github repository. 

## Inference 
Inference was done using the docker implementation from [here](https://github.com/loretoparisi/wave2vec-recognize-docker) or using the script infer.py from [here](https://github.com/pytorch/fairseq/blob/master/examples/speech_recognition/infer.py). All speech data used for inference can be found in the data folder. 

## Recreation of main results
Main results is recreated by running the 02456_Results.ipynb in a Jupyter notebook accompanied by the transcripts provided.

=====
Usage
=====

Using mSpelling
=================

mSpelling presents any auditory stimuli you want and saves the participant's response. To use
mSpelling you must specify a folder where to read the stimuli from and where to save the
data collected. We call this folder a **workspace**.

Workspace
=========

A workspace is just a folder that contains a folder named **stim**. mSpelling reads the stimuli 
to be presented from the **stim** folder. Inside the stim folder, you specify the stim in a simple
text (extension *.txt*) file called stim

mSpelling reads the stimuli to be presented from a folder inside the **workspace** that must be
named **stim** (e.g., workspace/stim). The stim folder must contain 2 things:

1. a text file (extension *.txt*) called stim, where each line contains a single word to be
   presented to the participant
2. the audio files (extension *.wav*) that contain the audio to present for each word. The name of 
   these files must be the word itself (i.e., if the stimulus is the word *dog*, the audio file
   must be named *dog*)

.. warning::
   mSpelling will not work if the word and audio stimuli are not in the folder it expects.

You can `download a demo workspace <https://github.com/mario-bermonti/mspelling/wiki>`_
to try mSpelling out! Don't forget to extract the contents of the workspace by openning it. 

Data
====

The data will be saved to a file called mspelling_data.sqlite inside the **workspace**. 
This file will contain the data for all participants.


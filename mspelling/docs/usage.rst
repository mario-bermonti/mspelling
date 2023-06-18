=====
Usage
=====

Running mSpelling
=================

To use mspelling:

1.  Open a terminal and change your working directory into mSpelling's directory (check this `cheatsheet`_ for more info)
2. Run the following command in the terminal

   .. code-block:: console

       $ poetry run mspelling

That is it! Wait a few seconds and mSpelling will start.

Session types
=============

mSpelling has 3 types of sessions that will be described below.

Demo
----

Demo sessions are designed to **give you** an idea of how mSpelling works and looks.
These sessions include a few trials with simple words.

To run a demo session, type `demo` when asked for a participant id.

.. note::
   Data is not saved for demo sessions.

Practice
--------

Practice sessions are designed to provide participants with practice trials to understand the activity.

To run a practice session, do not provide a participant id (i.e., leave blank).

For practice sessions, mSpelling expects word stimuli to be provided in a CSV file named `practice.csv`.

Experimental
------------

Experimental sessions are the ones designed to collect data from the participant's performance.

To run an experimental session, provide a participant id.

For experimental sessions, mSpelling expects stimuli to be provided in a CSV file named `experimental.csv`.

Stimuli
=======
The following information applies to all session types.

For practice and experimental sessions you must provide the word and audio stimuli. These are provided for you for demo sessions.

Word stimuli must be located at `mspelling/src/mspelling/stimuli/words`. The name of the column with the words must be `word`.

The audio files for each word must be at `mspelling/src/mspelling/stimuli/audio` folder. All audio files must be in `wav` format.

.. note::
   Remember that demo sessions provide stimuli for you.

.. warning::
   mSpelling will not work if word and audio stimuli are not in
   the folder it expects.

Results
=======

mSpelling saves the data from practice and experimental sessions in the `mspelling/src/mspelling/results` folder. A new file will be saved for each session. The name of the file will be identified with the participant's code (blank for practice sessions) and the current date and time.

.. _cheatsheet: https://www.makeuseof.com/tag/mac-terminal-commands-cheat-sheet/


# Table of Contents

1.  [This is mspelling!](#orgb264384)
2.  [Usage](#orgee6e301)
    1.  [Demo version](#orgdd68756)
    2.  [Practice session](#orgea73dbc)
    3.  [Experimental (real) session](#orgb2aefc1)
3.  [Requirements](#org4b945ac)


<a id="orgb264384"></a>

# This is mspelling!

mspelling is a Spanish spelling test developed for research on spelling
skills. Most of the research in which mspelling is with elementary-school
children so it is important to take that into consideration because it may
impact design decisions.

mSpelling was design to be as easy to administer and flexible as possible
to facilitate conducting research on spelling skills. It presents the words
to be spelled by playing audio files and the participant writes the word
using the keyboard.

At the end of the session, mspelling saves the results to an Excel file.

The software is developed using the programming language Python v3.

Feel free to use this software. It is distributed under the
GPL (see the LICENSE.md file included for details).

NOTE: Better documentation is coming very soon!


<a id="orgee6e301"></a>

# Usage


<a id="orgdd68756"></a>

## Demo version

Just run the mspelling.py file

That is it! The program will run using the demo words stored in the
Excel file `stimuli/words/practice.xlsx`


<a id="orgea73dbc"></a>

## Practice session

1.  Add the words for the practice session to the Excel file
    `stimuli/words/practice.xlsx`
2.  Add the audio for the words to `audio` folder
3.  Run the mspelling.py file
4.  When the program starts, it will ask you for a participant
    code, leave it blank.


<a id="orgb2aefc1"></a>

## Experimental (real) session

1.  Add the words for the experimental session to the Excel file
    `stimuli/words/experimental.xlsx`
2.  Add the audio for the words to `audio` folder
3.  Run the mspelling.py file
4.  When the program starts, it will ask you for a code, enter anything
    you want. It can contain letters, numbers, and symbols.
    
    At the end of the session, mSpelling stores the results in the
    `results` folder. The name of the file will be identified with
    the participant's code and the current date and time.


<a id="org4b945ac"></a>

# Requirements

mspelling requires python3 and a few other python libraries in order to run.
Please check the source files to identify which libraries you need to install.
It is usually as simple as entering "python3 -m pip install library-name" into
the terminal in order to install them.


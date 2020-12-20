
# Table of Contents

-   [This is mspelling!](#org4a53585)
-   [Installation](#org01d64e6)
-   [Description](#org50efb99)
-   [Usage](#org651842b)
-   [Contributing to this project](#orgb2b165a)
-   [Author](#orgdd6ae9c)
-   [License](#org8715b1b)


<a id="org4a53585"></a>

# This is mspelling!

mspelling is a Spanish spelling test developed for research on spelling
skills. 

mSpelling was design to be as easy to administer and as flexible as possible
to facilitate conducting research on spelling skills. It presents the words
to be spelled by playing audio files and the participant writes the word
using the keyboard.

At the end of the session, mspelling saves the results to a CSV file, which is supported
by most popular spreadsheet software these days like Excel.

The software is developed using the Python programming language v3.

Feel free to use this software. It is distributed under the
GPL (see the LICENSE.md file included for details).

**Better documentation is coming very soon!**

**Note:** Because mspelling is used mostly for research with elementary-school
        children the interface is adapted in a format appropriate for them and
        may not be appropriate for your other age groups.


<a id="org01d64e6"></a>

# Installation

1.  Install poetry ([instructions](https://python-poetry.org/docs/))
2.  [Download mspelling](https://github.com/mario-bermonti/mspelling/archive/master.zip) or clone it into your computer using git
3.  Open mspelling's directory using terminal or cmd ([check this cheatsheet](https://www.makeuseof.com/tag/mac-terminal-commands-cheat-sheet/) for more info)
4.  Run `poetry install`

**That is all! Everything ready!**


<a id="org50efb99"></a>

# Description

-   mspelling has a very simple interface and walks the user trough a series of
    screens. The sequence is as follows:
    -   Welcome message
    -   Login screen: Participants enter the id assigned to them
    -   Get ready message
    -   Spelling activity screen: Participants hear the words and type them. mspelling
        presents all the words specified in the stimuli file (see below).
    -   Goodbye message: Results are saved and the participants can press any key to
        end the session.


<a id="org651842b"></a>

# Usage

-   Just run the main.py file (`python3 main.py`) and mspelling will start
-   There are two types of sessions in mspelling: practice and experimental sessions
    -   The session is considered practice if no participant id is provided.
        In this cases, mspelling will read the words from
        `stimuli/words/practice.csv`.
    -   The session is considered an experimental session if a participant id is provided.
        The id can contain letters, numbers, and symbols. In this cases,
        mspelling will read the words from `mspelling/stimuli/words/experimental.csv`.
-   In both cases, mspelling expects:
    -   the audio for each word to be in the `mspelling/stimuli/audio/` folder.
        All audio files must be in `wav` format.
    -   The text stimuli must be words in a column named `word` of the CSV file.
-   At the end of the session, mSpelling stores the results in the
    `mspelling/results` folder. The name of the file will be identified with
    the participant's code (blank for practice sessions) and the current
    date and time.
    
    **mspelling comes with a short demo version of 5 Spanish words. Go ahead and
    try it! Just use mspelling like a practice session (no user id).**


<a id="orgb2b165a"></a>

# Contributing to this project

All contributions are welcome!

If you encounter any bugs, please open an issue on GitHub.

To contribute to this project, clone the repository, add your contribution, 
and submit a pull request. Be sure to run the tests or provided a test-case
if adding new functionality.


<a id="orgdd6ae9c"></a>

# Author

This project was developed by Mario E. Bermonti-Perez as part of
his academic research. Feel free to contact me at [mbermonti@psm.edu](mailto:mbermonti@psm.edu) or
[mbermonti1132@gmail.com](mailto:mbermonti1132@gmail.com)


<a id="org8715b1b"></a>

# License

This project is licensed under the  GPL License. See the LICENSE.txt file for
details.


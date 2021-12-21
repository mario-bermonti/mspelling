# mSpelling

[![PyPI - Version](https://img.shields.io/pypi/v/mspelling.svg)](https://pypi.python.org/pypi/mspelling)
[![PyPI - Python Version](https://img.shields.io/pypi/pyversions/mspelling.svg)](https://pypi.python.org/pypi/mspelling)
![GitHub](https://img.shields.io/github/license/mario-bermonti/mspelling)
[![Tests](https://github.com/mario-bermonti/mspelling/workflows/tests/badge.svg)](https://github.com/mario-bermonti/mspelling/actions?workflow=tests)
[![Codecov](https://codecov.io/gh/mario-bermonti/mspelling/branch/master/graph/badge.svg?token=YOURTOKEN)](https://codecov.io/gh/mario-bermonti/mspelling)
[![Read the Docs](https://readthedocs.org/projects/mspelling/badge/)](https://mspelling.readthedocs.io/)
[![Black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Measure of Spanish spelling skills

* GitHub repo: <https://github.com/mario-bermonti/mspelling.git>
* Documentation: <https://mspelling.readthedocs.io/>
* Free software: GNU General Public License v3

## Features
- Developed specifically for research on spelling skills
- Easy to administer
- Flexible and easy to extend
- Supports multiple platforms: MacOS, Windows, Linux
- Results are saved to a CSV file

## Description
mspelling is a Spanish spelling test developed for research on spelling
skills. mSpelling was design to be as easy to administer and as flexible as possible
to facilitate conducting research on spelling skills.

It presents the words to be spelled by playing audio files and the participant writes the word
using the keyboard.

At the end of the session, mspelling saves the results to a CSV file, which is supported
by most popular spreadsheet software these days like Excel.

The software is developed using the Python programming language v3.


## Getting Started
### Installation
1.  Install poetry ([instructions](https://python-poetry.org/docs/))
2.  [Download mspelling](https://github.com/mario-bermonti/mspelling/archive/master.zip) or clone it into your computer using git
3.  Open mspelling's directory using terminal or cmd ([check this cheatsheet](https://www.makeuseof.com/tag/mac-terminal-commands-cheat-sheet/) for more info)
4.  Run `poetry install` to install mspelling and all its dependencies. You can see the list
    in the `pyproject.toml` file

**That is it! mspelling is ready to be used!**

**Better documentation is coming very soon!**


<a id="orgbc46109"></a>

-   run the main.py file using python (`python3 main.py`) and mspelling will start
-   There are two types of sessions in mspelling: practice and experimental sessions
    -   The session is considered practice if no participant id is provided.
        In this case, mspelling will read the words from
        `stimuli/words/practice.csv`.
    -   The session is considered an experimental session if a participant id is provided.
        The id can contain letters, numbers, and symbols. In this case,
        mspelling will read the words from `mspelling/stimuli/words/experimental.csv`.
-   In both cases, mspelling expects:
    -   the audio for each word to be in the `mspelling/stimuli/audio/` folder.
        All audio files must be in `wav` format.
    -   The text stimuli must be in a column named `word` of the CSV file.
-   At the end of the session, mSpelling stores the results in the
    `mspelling/results` folder. The name of the file will be identified with
    the participant's code (blank for practice sessions) and the current
    date and time.

    **mspelling comes with a short demo version of 5 Spanish words. Go ahead and
    try it! Just use mspelling like a practice session (no user id).**


<a id="org1940749"></a>

### Usage
-   run the main.py file using python (`python3 main.py`) and mspelling will start
-   There are two types of sessions in mspelling: practice and experimental sessions
    -   The session is considered practice if no participant id is provided.
        In this case, mspelling will read the words from
        `stimuli/words/practice.csv`.
    -   The session is considered an experimental session if a participant id is provided.
        The id can contain letters, numbers, and symbols. In this case,
        mspelling will read the words from `mspelling/stimuli/words/experimental.csv`.
-   In both cases, mspelling expects:
    -   the audio for each word to be in the `mspelling/stimuli/audio/` folder.
        All audio files must be in `wav` format.
    -   The text stimuli must be in a column named `word` of the CSV file.
-   At the end of the session, mSpelling stores the results in the
    `mspelling/results` folder. The name of the file will be identified with
    the participant's code (blank for practice sessions) and the current
    date and time.

    **mspelling comes with a short demo version of 5 Spanish words. Go ahead and
    try it! Just use mspelling like a practice session (no user id).**

Check [the documentation][project_docs] for more details.

## Contributing to this project
  All contributions are welcome!

  Will find a detailed description of all the ways you can contribute to mspelling in
  [the contributing guide][contributing_guide].

  This is a beginner-friendly project so don't hesitate to ask any questions or get in touch
  with the project's maintainers.

  Please review the [project's code of conduct][code_conduct] before making
  any contributions.

## Author
This project was developed by Mario E. Bermonti-Pérez as part of
his academic research. Feel free to contact me at [mbermonti@psm.edu](mailto:mbermonti@psm.edu) or
[mbermonti1132@gmail.com](mailto:mbermonti1132@gmail.com)

## Credits

This package was created with [Cookiecutter][cookiecutter] and the [mario-bermonti/cookiecutter-modern-pypackage][cookiecutter-modern-pypackage] project template.

[cookiecutter]: https://github.com/cookiecutter/cookiecutter
[cookiecutter-modern-pypackage]: https://github.com/mario-bermonti/cookiecutter-modern-pypackage
[project_docs]: https://mspelling.readthedocs.io/
[code_conduct]: ./CODE_OF_CONDUCT.md
[contributing_guide]: ./contributing.md

#! /usr/bin/env python3
# -*- coding: utf-8 -*-

"""This module creates the main window. The windows size is automatically
selected using built-in functions. It displays a button that starts the program
it then asks the user's name and greets the user.

It also creates a menubar that brings the user back to the mainmenu, offers
administrative options y offers help to the user. The administrative
options just change the colors of the app.
"""

import tkinter as tk
import time
import random
import datetime
from os import listdir
from os.path import isfile, join
import json
import pandas as pd
import numpy as np
from pygame import mixer
import settings

settings = settings.Settings()

# Configure things
appFont = settings.appFont
fontColor = settings.fontColor
buttonColor = settings.buttonColor
backgroundColor = settings.backgroundColor


class MainApp(tk.Frame):
    def __init__(self, root):
        tk.Frame.__init__(self)
        self.root = root
        root.attributes('-fullscreen', True)

        self.root.configure(bg=backgroundColor)
        self.root.title("Deletreo")

        # Main frame where everything else goes.
        self.mainFrame = tk.Frame(root, bg=backgroundColor)
        self.mainFrame.pack(expand=tk.YES, fill=tk.BOTH)

        # Start application
        self.ask_for_id()

    def ask_for_id(self):
        self.participantCodeLabel = tk.Label(
            self.mainFrame,
            font=appFont,
            fg=fontColor,
            text="Código: ",
            bg=backgroundColor,
        )
        self.participantCodeLabel.pack()

        self.participantCode = tk.StringVar()
        self.participantCodeEntry = tk.Entry(
            self.mainFrame,
            text=self.participantCode,
            width=20,
            font=appFont
        )
        self.participantCodeEntry.pack()
        self.participantCodeEntry.focus_set()

        self.readyButton = tk.Button(
            self.mainFrame,
            font=("Arial", 24),
            text="Listo",
            width=8,
            bg=buttonColor,
            command= self.greetingStudent
        )
        self.readyButton.pack()

    def greetingStudent(self):
        """Creates a label that greets the user using his name."""

        self.erase_content()
        self.greetingFrame = tk.Frame(
            self.mainFrame,
            bg=backgroundColor
        )
        self.greetingFrame.pack(
            in_=self.mainFrame,
            side=tk.TOP,
            ipady=100
        )

        self.greetingLabel = tk.Label(
            self.greetingFrame,
            font=appFont,
            fg=fontColor,
            bg=backgroundColor,
            text="¡Comencemos!",
            justify=tk.CENTER,
            pady=2
        )
        self.greetingLabel.pack(pady=200)
        self.root.after(5000, self.start_spelling_measure)

    def erase_content(self):
        self.mainFrame.destroy()
        self.mainFrame = tk.Frame(root, bg=backgroundColor)
        self.mainFrame.pack(expand=tk.YES, fill=tk.BOTH)

    def start_spelling_measure(self):
        self.erase_content()
        spelling_measure = SpellingMeasure(
            self.participantCode.get().strip(),
            self.root
        )


class SpellingMeasure():
    def __init__(self, participantCode, root):
        # Config
        self.root = root
        self.participantCode = participantCode
        self.worksheetName, self.sessionNumber = \
            self.get_current_worksheet_name_and_session_number()
        self.worksheet = pd.read_excel(self.worksheetName)
        # Shuffles the worksheet so participants get different orders
        self.worksheet = self.worksheet.reindex(
            np.random.permutation(
                self.worksheet.index
            )
        )

        # Results
        self.results = []

        # Main frame where everything else goes.
        self.mainFrame = tk.Frame(root, bg=backgroundColor)
        self.mainFrame.pack(expand=tk.YES, fill=tk.BOTH)

        self.root.after(600000, self.close_app)
        self.present_next_item()

    def get_current_worksheet_name_and_session_number(self):
        """Get the worksheet number the user should work on for this session.
        It has to be worksheet that the participant has not worked on before.
        """

        worksheetPath = 'Stimuli/words/'
        # Present practice trials if participant's code is left blank
        if not self.participantCode:
            worksheet = '{}practice.xlsx'.format(worksheetPath)
        else:
            worksheetNames = [fname for fname in listdir(worksheetPath)
                              if isfile(join(worksheetPath, fname))]

            # Clean other system files and practice file from list
            worksheetNames = [fname for fname in worksheetNames if fname.startswith('worksheet_')]

            # File that specifies which worksheets has this participant
            # work with already
            try:
                with open('participants session progress.json') as jsonFile:
                    progressAllUsers = json.load(jsonFile)
                    progressUser = progressAllUsers.get(
                        str(self.participantCode),
                        []
                    )
            except FileNotFoundError:
                progressUser = []

            # Make sure the participant has not worked on the
            # selected worksheet already
            while True:
                worksheet = random.choice(worksheetNames)
                worksheet = '{}{}'.format(worksheetPath, worksheet)
                if worksheet not in progressUser:
                    break

        if 'practice' in worksheet:
            progressUser = 'practice'
        else:
            progressUser = len(progressUser) + 1

        return worksheet, progressUser

    def get_current_word(self):
        """Randomly select a row from the worksheet and drop it from the
        worksheet.
        """

        try:
            currentWord = self.worksheet.iloc[0]
            self.worksheet = self.worksheet.iloc[1:]
            return currentWord
        except IndexError:
            self.close_app()

    def present_audio(self, word):
        mixer.init(44100)
        soundPath = "Stimuli/audio/{}.wav".format(word.strip())
        sound = mixer.Sound(soundPath)
        sound.play()

    def present_next_item(self):
        self.erase_content()

        # Draw input box
        self.userResponse = tk.StringVar()
        self.userResponseEntry = tk.Entry(
            self.mainFrame,
            textvariable=self.userResponse,
            width=20,
            font=appFont
        )
        self.userResponseEntry.pack()
        self.userResponseEntry.focus_set()

        nextButton = tk.Button(
            self.mainFrame,
            font=("Arial", 24),
            text="Listo",
            width=8,
            bg=buttonColor,
            command=lambda: self.update_results(
                current_word.word,
                current_word['difficulty level']
            )
        )
        nextButton.pack()

        current_word = self.get_current_word()
        self.root.after(500, self.present_audio, current_word.word)

    def update_results(self, word, difficulty_level):
        self.results.append(
            [
                self.participantCode,
                self.sessionNumber,
                word.strip(),
                self.userResponse.get(),
                difficulty_level
            ]
        )
        self.present_next_item()

    def erase_content(self):
        self.mainFrame.destroy()
        self.mainFrame = tk.Frame(root, bg=backgroundColor)
        self.mainFrame.pack(expand=tk.YES, fill=tk.BOTH)

    def save_participant_progress(self):
        """Record and save to file the identifier of the worksheet the
        participant worked on. This is done in order to avoid repeating them.
        """

        filename = 'participants session progress.json'
        if filename in listdir('.'):
            with open(filename) as jsonFile:
                progress = json.load(jsonFile)
                progress.setdefault(
                    str(self.participantCode),
                    []).append(
                        self.worksheetName
                    )
        else:
            progress = {self.participantCode: [self.worksheetName]}

        with open(filename, 'w') as jsonFile:
            json.dump(progress, jsonFile)

    def save_results(self):
        """Save the participant's results for this session."""

        # goodbye message while results are saved
        message = "¡Terminamos! \n Guardando los resultados..."
        goodbye_message = tk.Label(
            self.mainFrame,
            font=appFont,
            fg=fontColor,
            bg=backgroundColor,
            text=message,
            justify=tk.CENTER,
            pady=2
        )
        goodbye_message.pack(pady=200)
        results_formatted = pd.DataFrame(
            self.results,
            columns=[
                'participant id',
                'session',
                'word',
                'response',
                'difficulty_level']
        )
        results_path = 'results/results_p{}_s{}_{}.xlsx'.format(
            self.participantCode,
            self.sessionNumber,
            datetime.datetime.now().strftime('%Y-%m-%d')
        )
        results_formatted.to_excel(results_path, index=False)
        self.root.after(2000, self.root.destroy)

    def end_practice(self):
        """End the practice session without saving the results."""

        # goodbye message
        message = "¡Terminamos la práctica! \n"
        goodbye_message = tk.Label(
            self.mainFrame,
            font=appFont,
            fg=fontColor,
            bg=backgroundColor,
            text=message,
            justify=tk.CENTER,
            pady=2
        )
        goodbye_message.pack(pady=200)
        self.root.after(2000, self.root.destroy)

    def close_app(self):
        """Saves the participant's progress and closes the app."""

        self.erase_content()
        if self.worksheetName != 'Stimuli/words/practice.xlsx':
            self.save_participant_progress()
            self.save_results()
        else:
            self.end_practice()


if __name__ == "__main__":
    root = tk.Tk()
    main_app = MainApp(root)
    root.mainloop()

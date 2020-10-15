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
import os 
import json
import pandas as pd
import numpy as np
from pygame import mixer
import settings

settings = settings.Settings()

# Configure settings 
appFont = settings.appFont
fontColor = settings.fontColor
buttonColor = settings.buttonColor
backgroundColor = settings.backgroundColor


class MainApp(tk.Frame):
    def __init__(self, root):
        tk.Frame.__init__(self)
        self.root = root
        # root.attributes('-fullscreen', True)

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
        self.practice = self.is_practice_session()
        self.cwd = os.getcwd() 
        self.worksheet = self.get_worksheet()
        self.trial = None
        # Shuffles the worksheet so participants get different orders
        self.worksheet = self.worksheet.reindex(
            np.random.permutation(
                self.worksheet.index
            )
        )

        self.results = []

        # Main frame where everything else goes.
        self.mainFrame = tk.Frame(root, bg=backgroundColor)
        self.mainFrame.pack(expand=tk.YES, fill=tk.BOTH)

        self.root.after(600000, self.close_app)
        self.present_next_item()

    def is_practice_session(self):
        """Returns True if this is a practice session. Else returns False."""

        if (self.participantCode is False) or (len(self.participantCode) == 0):
            return True
        else:
            return False

    def get_worksheet(self):
        """
        Determines if this is a practice or experimental session,
        reads the stimuli from a file and returns them.

        Returns
        -------
        stim (pandas.DataFrame): stimuli with any additional data
            contained in the stim file.
        """

        if self.practice:
            filename = "practice.xlsx"
        else:
            filename = "experimental.xlsx"

        file_path = os.path.join("stimuli", "words", filename)
        worksheet = pd.read_excel(file_path)

        return worksheet

    def get_trial(self):
        """Randomly select a row from the worksheet and drop it from the
        worksheet.
        """

        try:
            self.trial = self.worksheet.iloc[0]
            self.worksheet = self.worksheet.iloc[1:]
        except IndexError:
            self.close_app()

    def present_audio(self):
        mixer.init(44100)
        word = self.trial.word
        soundPath = os.path.join("stimuli", "audio", "{}.wav".format(word.strip()))
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
            command=self.update_results)
        nextButton.pack()

        self.get_trial()
        self.root.after(500, self.present_audio)

    def update_results(self):
        results_trial = self.format_trial_results()
        self.results.append(results_trial)
        self.present_next_item()

    def format_trial_results(self):
        """Formats the results of the current trial. This is important
        to be able to handle arbitrary data provided with the stimuli.

        Returns
        _______
        results_trial (list): formatted trial results
        """

        other_data = self.trial[1:].values.tolist()
        results_trial = [
            self.participantCode,
            self.trial.word,
            self.userResponse.get(),
        ]
        results_trial.extend(other_data)

        return results_trial

    def erase_content(self):
        self.mainFrame.destroy()
        self.mainFrame = tk.Frame(root, bg=backgroundColor)
        self.mainFrame.pack(expand=tk.YES, fill=tk.BOTH)

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

        header = self.format_results_header()


        results_formatted = pd.DataFrame(
            self.results,
            columns=header
        )

        results_path = os.path.join(
            'results',
            'results_p{}_{}.xlsx'.format(
                self.participantCode,
                datetime.datetime.now().strftime('%Y-%m-%d')
            )
        )

        if not os.path.isdir('results/'):
            os.mkdir('results/')

        results_formatted.to_excel(results_path, index=False)
        self.root.after(2000, self.root.destroy)

    def format_results_header(self):
        """Determines what should be the header of the results.

        Returns
        -------
        header (list): list of strings with the headers of the results file
        """

        header_worksheet_data = self.trial[1:].index.tolist()
        header = ['participant id', 'word', 'response']
        header.extend(header_worksheet_data)

        return header

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
        """Saves the participant's results and closes the app."""

        self.erase_content()
        if self.practice:
            self.end_practice()
        else:
            self.save_results()


if __name__ == "__main__":
    root = tk.Tk()
    main_app = MainApp(root)
    root.mainloop()

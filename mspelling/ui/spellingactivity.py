from kivy.uix.screenmanager import Screen
from kivy.app import App
from kivy.properties import ObjectProperty

import os

import worksheet

class SpellingActivityScreen(Screen):
    worksheet = ObjectProperty(None)

    def on_enter(self):
        self.app = App.get_running_app()
        self.check_if_practice_session()
        self.worksheet = self.get_stimuli()

    def submit(self, response):
        # process response
        self.set_trial()
        self.clear_screen()
    def check_if_practice_session(self):
        """Checks whether this is a practice session and sets a flag in
        the app's root to indicate it.
        """

        code = self.app.root.participant_code

        if len(code) == 0:
            self.app.root.is_practice = True
        else:
            self.app.root.is_practice = False


    def get_stimuli(self):
        """Create a new worksheet and return it.

        Returns
        -------
        stimuli (pandas.DataFrame): Stimuli worksheet 
        """

        filename = self.determine_stimuli_filename()
        stimuli = worksheet.Worksheet(filename, randomize=True)
        stimuli = stimuli.worksheet

        return stimuli

    def determine_stimuli_filename(self):
        """Determines the filename for the stimuli. The filename depends
        on whether this is a practice session.

        Returns
        -------
        path_stimuli (str): path to stimuli
        """

        is_practice = self.app.root.is_practice

        if is_practice:
            filename = "practice.xlsx"
        else:
            filename = "experimental.xlsx"

        path_stimuli = os.path.join("stimuli", "words", filename)

        return path_stimuli

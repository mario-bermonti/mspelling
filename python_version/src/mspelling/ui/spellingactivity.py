from kivymd.uix.screen import MDScreen
from kivy.app import App
from kivy.properties import ObjectProperty
from kivy.properties import BooleanProperty
from kivy.properties import NumericProperty
from kivy.core.audio import SoundLoader
from kivy.clock import Clock

from functools import partial

import pandas as pd
from kivy.app import App
from kivy.clock import Clock
from kivy.core.audio import SoundLoader
from kivy.properties import BooleanProperty, ObjectProperty
from kivymd.uix.screen import MDScreen

from ..worksheet import Worksheet


class SpellingActivityScreen(MDScreen):
    new_session = BooleanProperty(True)
    active_session = BooleanProperty(True)
    worksheet = ObjectProperty(None)
    trial = ObjectProperty(None)
    trial_number = NumericProperty(0)
    rest_period_active = BooleanProperty(False)
    rest_interval = NumericProperty(5)
    active_session = BooleanProperty(True)

    def on_enter(self):
        if self.new_session:
            # TODO: integrate into method (init)
            self.reset_everything()
            self.app = App.get_running_app()
            self.app.determine_session_name()
            self.BASE_PATH = self.app.get_base_path()
            self.worksheet = self.get_stimuli()
            self.trial = None
            self.results = self.app.results
            self.new_session = False
        self.rest_period_active = False
        self.present_trial()

    def submit(self, response):
        """Pass the participant's response to the appropriate function
        so results can be updated and schedule next trial.

        Parameters
        ----------
        response: str
            User's response
        """

        self.results.update_results(
            response=response,
            trial_data=self.trial,
            )
        self.reset_everything()
        self.trial_number += 1        
        if self.active_session and not self.rest_period_active:
            Clock.schedule_once(self.present_trial, 1)

    def get_stimuli(self):
        """Get the stimuli that will be used by the spelling activity.
        It calls other functions to get the stimuli.

        Returns
        -------
        stimuli (pandas.DataFrame): Stimuli worksheet
        """

        filename = self.determine_stimuli_filename()
        data = pd.read_csv(filename)
        worksheet = Worksheet(data, randomize=True)
        stimuli = worksheet.data

        return stimuli

    def determine_stimuli_filename(self):
        """Determines the filename for the stimuli. The filename depends
        on whether this is a practice session.

        Returns
        -------
        path_stimuli (str): path to stimuli
        """

        # TODO: don't use intermediate vars (clean up)
        session_name = self.app.session_name

        if session_name == "demo":
            filename = "demo.csv"
        elif session_name == "practice":
            filename = "practice.csv"
        elif session_name == "experimental":
            filename = "experimental.csv"

        # TODO: Don't separate text stim from audio files to avoid too many dir
        path_stimuli = self.BASE_PATH / "stimuli" / "words" / filename

        return path_stimuli

    def set_trial(self):
        """Removes a row from the worksheet and assigns it as the
        current one.

        The app will be closed if there are no words left.
        """

        try:
            self.trial = self.worksheet.iloc[0]
            self.worksheet = self.worksheet.iloc[1:]
        except IndexError:
            self.end_spelling_activity()

    def present_trial(self, *args):
        """Setup and present the trial.

        The user's response is delayed to avoid him/her providing
        their response while the audio is still being played. Otherwise
        the response would be contaminated by that cue.
        """

        self.set_trial()
        if self.active_session:
            self.present_audio()
            Clock.schedule_once(
                partial(self.toggle_disabling_response, disable_response=False), 1
            )

    def present_audio(self):
        word = self.trial.word
        word = word.strip()
        path_stimuli_audio = self.BASE_PATH / "stimuli" / "audio" / f"{word}.wav"

        sound = SoundLoader.load(str(path_stimuli_audio))
        sound.play()

    def toggle_disabling_response(self, *args, disable_response=True):
        """Enable or disable user's response."""

        self.ids.response_input.disabled = disable_response
        self.ids.submit_button.disabled = disable_response
        self.ids.response_input.focus = True

    def end_spelling_activity(self):
        self.active_session = False
        self.reset_everything()
        self.go_to_save_screen()

    def go_to_save_screen(self):
        self.manager.current = "save_screen"
    
    def reset_everything(self):
        self.clear_screen()
        self.toggle_disabling_response(disable_response=True)

    def clear_screen(self):
        """Clear screen to allow next response."""

        self.ids.response_input.text = ""

    def on_trial_number(self, instance, value):
        """Go to rest period screen if appropriate."""
        
        if self.present_rest_period:
            self.go_to_rest_screen()
    
    @property
    def present_rest_period(self):
        """Determine if it is time for a rest period."""

        return not self.trial_number % self.rest_interval
        
    def go_to_rest_screen(self):
        """Present the rest period screen."""

        self.rest_period_active = True
        self.manager.current = "rest_period_screen"
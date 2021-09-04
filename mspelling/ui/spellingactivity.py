from kivy.uix.screenmanager import Screen
from kivy.app import App
from kivy.properties import ObjectProperty
from kivy.properties import BooleanProperty
from kivy.core.audio import SoundLoader
from kivy.clock import Clock

from pathlib import Path
from functools import partial
import pandas as pd

from worksheet import Worksheet

PATH_PROJECT_ROOT = Path(__file__).resolve().parent.parent

class SpellingActivityScreen(Screen):
    worksheet = ObjectProperty(None)
    trial = ObjectProperty(None)
    active_session = BooleanProperty(True)

    def on_enter(self):
        self.app = App.get_running_app()
        self.check_if_practice_session()
        self.worksheet = self.get_stimuli()
        self.trial = None
        self.present_trial()
        self.results = self.app.results

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
        if self.active_session:
            self.present_trial()

    def check_if_practice_session(self):
        """Checks whether this is a practice session and sets a flag in
        the app's root to indicate it.
        """

        code = self.app.participant_id

        if len(code) == 0:
            self.app.is_practice = True
        else:
            self.app.is_practice = False


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

        is_practice = self.app.is_practice

        if is_practice:
            filename = "practice.csv"
        else:
            filename = "experimental.csv"

        path_stimuli = PATH_PROJECT_ROOT / "stimuli" / "words" / filename

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

    def present_trial(self):
        """Setup and present the trial.

        The user's response is delayed to avoid him/her providing
        their response while the audio is still being played. Otherwise
        the response would be contaminated by that cue.
        """

        self.clear_screen()
        self.toggle_disabling_response(disable_response=True)
        self.set_trial()
        if self.active_session:
            self.present_audio()
            Clock.schedule_once(
                partial(
                    self.toggle_disabling_response,
                    disable_response=False
                ),
                1
            )

    def present_audio(self):
        word = self.trial.word
        word = word.strip()
        path_stimuli_audio = PATH_PROJECT_ROOT / "stimuli" / "audio" / f"{word}.wav"

        sound = SoundLoader.load(str(path_stimuli_audio))
        sound.play()

    def toggle_disabling_response(self, *args, disable_response=True):
        """Enable or disable user's response."""

        self.ids.response_input.disabled = disable_response
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

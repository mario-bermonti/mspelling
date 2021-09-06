from pathlib import Path

import kivy
kivy.require('1.11.1')
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import StringProperty
from kivy.properties import BooleanProperty
from kivy.properties import ObjectProperty

# needs to be imported or kivy won't find them
# at least the first screen
from ui.welcomescreen import WelcomeScreen
from ui.loginscreen import LoginScreen
from ui.startscreen import StartScreen
from ui.beginmessagescreen import BeginMessageScreen
from ui.spellingactivity import SpellingActivityScreen
from ui.savescreen import SaveScreen
from ui.endscreen import EndScreen

import results

class MSpellingRoot(BoxLayout):
    pass

class MSpellingApp(App):
    title = "mDeletreo"
    kv_directory = "ui"
    participant_id = StringProperty("")
    is_practice = BooleanProperty(False)
    results = ObjectProperty(None)
    PATH_PROJECT_ROOT = Path(__file__).resolve().parent

    def on_start(self):
        self.results = results.Results()


    def build(self):
        return MSpellingRoot()

    def save_results(self):
        self.results.save_results()

    def determine_if_practice_session(self):
        """Checks whether this is a practice session and sets a flag in
        the app's root to indicate it.
        """

        if len(self.participant_id) == 0:
            self.is_practice = True
        else:
            self.is_practice = False

if __name__ == "__main__":
    MSpellingApp().run()

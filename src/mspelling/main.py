from pathlib import Path

import kivy

kivy.require("1.11.1")
from kivy.lang import Builder
from kivy.properties import BooleanProperty, ObjectProperty, StringProperty
from kivymd.app import MDApp

from .results import Results
# needs to be imported or kivy won't find them
# at least the first screen
from .ui.beginmessagescreen import BeginMessageScreen
from .ui.endscreen import EndScreen
from .ui.loginscreen import LoginScreen
from .ui.savescreen import SaveScreen
from .ui.spellingactivity import SpellingActivityScreen
from .ui.startscreen import StartScreen
from .ui.welcomescreen import WelcomeScreen
from .ui.restscreen import RestPeriodScreen



class MSpellingApp(MDApp):
    title = "mDeletreo"
    kv_directory = "ui"
    participant_id = StringProperty("")
    session_name = StringProperty("")
    results = ObjectProperty(None)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.theme_cls.theme_style = "Dark"
        self.theme_cls.primary_palette = "Teal"

    def on_start(self):
        self.results = Results()

    def build(self):
        path_root = Path(__file__).resolve().parent / "ui" / "mspelling.kv"
        self.root = Builder.load_file(str(path_root))

        return self.root

    def save_results(self):
        self.results.save_results()

    def determine_session_name(self):
        """Determine the kind of session. Options are 'demo', 'practice', 'experimental'."""

        if self.participant_id == "demo":
            self.session_name = "demo"
        elif len(self.participant_id) == 0:
            self.session_name = "practice"
        else:
            self.session_name = "experimental"

    def get_base_path(self):
        """Determine the path to use as base.

        Use the project's root as the base path if this is a demo session, otherwise
        use the cwd.
        """

        if self.session_name == "demo":
            base_path = PATH_PROJECT_ROOT = Path(__file__).resolve().parent
        else:
            base_path = PATH_PROJECT_ROOT = Path().cwd().resolve()

        return base_path


def main():
    MSpellingApp().run()

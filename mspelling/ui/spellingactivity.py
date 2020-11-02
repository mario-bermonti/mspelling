from kivy.uix.screenmanager import Screen
from kivy.app import App

class SpellingActivityScreen(Screen):
    def on_enter(self):
        self.app = App.get_running_app()
        self.check_if_practice_session()
    def check_if_practice_session(self):
        """Checks whether this is a practice session and sets a flag in
        the app's root to indicate it.
        """

        code = self.app.root.participant_code

        if len(code) == 0:
            self.app.root.is_practice = True
        else:
            self.app.root.is_practice = False
        else:
            app.root.is_practice = False


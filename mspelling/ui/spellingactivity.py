from kivy.uix.screenmanager import Screen
from kivy.app import App

class SpellingActivityScreen(Screen):
    def on_enter(self):
        self.check_if_practice_session()
    def check_if_practice_session(self):
        """Checks whether this is a practice session and sets a flag in
        the app's root to indicate it.
        """

        app = App.get_running_app()
        code = app.root.participant_code

        if len(code) == 0:
            app.root.is_practice = True
        else:
            app.root.is_practice = False


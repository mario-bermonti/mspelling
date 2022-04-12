from kivy.app import App
from kivymd.uix.screen import MDScreen


class LoginScreen(MDScreen):
    def on_enter(self):
        self.ids.code_input.focus = True

    def submit_participant_id(self, code):
        """Set the participant's code as an atttibute of the app's root.

        Parameter
        ---------
        code (str): participant's code
        """

        app = App.get_running_app()
        code = code.strip()
        app.participant_id = code

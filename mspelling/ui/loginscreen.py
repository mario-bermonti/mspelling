from kivy.uix.screenmanager import Screen
from kivy.app import App

class LoginScreen(Screen):
    def submit_participant_code(self, code):
        """Set the participant's code as an atttibute of the app's root.

        Parameter
        ---------
        code (str): participant's code
        """

        app = App.get_running_app()
        code = code.strip()
        app.root.participant_code = code

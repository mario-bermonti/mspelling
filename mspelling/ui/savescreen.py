from kivy.uix.screenmanager import Screen
from kivy.app import App
from kivy.clock import Clock

class SaveScreen(Screen):
    def on_enter(self):
        self.app = App.get_running_app()
        Clock.schedule_once(self.save_results, 2)

    # TODO: Only show data saving screen if not in demo
    def save_results(self, *args):
        if self.app.session_name != "demo":
            self.app.save_results()
        self.manager.current = "end_screen"

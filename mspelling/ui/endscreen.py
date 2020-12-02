from kivy.uix.screenmanager import Screen
from kivy.core.window import Window
from kivy.app import App

class EndScreen(Screen):
    def on_enter(self):
        app = App.get_running_app()
        Window.bind(on_key_up=app.stop)

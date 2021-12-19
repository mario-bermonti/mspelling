from kivymd.uix.screen import MDScreen
from kivy.core.window import Window
from kivy.app import App

class EndScreen(MDScreen):
    def on_enter(self):
        app = App.get_running_app()
        Window.bind(on_key_up=app.stop)

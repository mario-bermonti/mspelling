from kivy.uix.screenmanager import Screen
from kivy.clock import Clock

class BeginMessageScreen(Screen):
    def on_enter(self):
        Clock.schedule_once(self.go_to_next_screen, 2)

    def go_to_next_screen(self, *args):
        self.manager.current = "spelling_activity_screen"

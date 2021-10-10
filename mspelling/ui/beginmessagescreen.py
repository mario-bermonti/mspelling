from kivymd.uix.screen import MDScreen
from kivy.clock import Clock

class BeginMessageScreen(MDScreen):
    def on_enter(self):
        Clock.schedule_once(self.go_to_next_screen, 2)

    def go_to_next_screen(self, *args):
        self.manager.current = "spelling_activity_screen"

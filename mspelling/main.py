import kivy
kivy.require('1.11.1')
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import StringProperty
from kivy.properties import BooleanProperty

# needs to be imported or kivy won't find them
# at least the first screen
from ui.welcomescreen import WelcomeScreen
from ui.loginscreen import LoginScreen
from ui.startscreen import StartScreen
from ui.beginmessagescreen import BeginMessageScreen
from ui.spellingactivity import SpellingActivityScreen
from ui.savescreen import SaveScreen
from ui.endscreen import EndScreen

import results

class MSpellingRoot(BoxLayout):
    participant_id = StringProperty("")
    is_practice = BooleanProperty(False)
    results = results.Results()


    def save_results(self):
        self.results.save_results()
        self.present_end_screen()


    def present_end_screen(self):
        self.ids.mspelling_screen_manager.current = "end_screen"

class MSpellingApp(App):
    title = "mDeletreo"
    kv_directory = "ui"

    def build(self):
        return MSpellingRoot()
    
if __name__ == "__main__":
    MSpellingApp().run()

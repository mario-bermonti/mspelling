import kivy
kivy.require('1.11.1')
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import StringProperty

# needs to be imported or kivy won't find them
# at least the first screen
from ui.welcomescreen import WelcomeScreen
from ui.loginscreen import LoginScreen
from ui.startscreen import StartScreen
from ui.spellingactivity import SpellingActivityScreen
from ui.goodbyescreen import GoodbyeScreen


class MSpellingRoot(BoxLayout):
    participant_code = StringProperty("")

class MSpellingApp(App):
    title = "mDeletreo"
    kv_directory = "ui"

    def build(self):
        return MSpellingRoot()
    
if __name__ == "__main__":
    MSpellingApp().run()

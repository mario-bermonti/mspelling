import kivy
kivy.require('1.11.1')
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout

# needs to be imported or kivy won't find them
# at least the first screen
from welcomescreen import WelcomeScreen
from loginscreen import LoginScreen
from startscreen import StartScreen
from mspellingroot import MSpellingRoot
from spellingactivity import SpellingActivityScreen
from goodbyescreen import GoodbyeScreen
from mspellingroot import MSpellingRoot


class MSpellingApp(App):
    title = "mDeletreo"

    def build(self):
        return MSpellingRoot()
    
if __name__ == "__main__":
    MSpellingApp().run()

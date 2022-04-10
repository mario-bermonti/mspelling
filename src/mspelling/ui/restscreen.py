from pathlib import Path

from kivymd.uix.screen import MDScreen
from kivy.lang import Builder


# TODO Improve this
# The ui is not build if the kv file is not manually loaded
path_root = Path(__file__).resolve().parent / "restscreen.kv"
Builder.load_file(str(path_root))

class RestPeriodScreen(MDScreen):
    pass
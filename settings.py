class Settings():
    def __init__(self):
        self.appFont = ("Arial", 24)
        self.fontColor = "#970000"
        self.buttonColor = "#ffff97"
        self.backgroundColor = "#aeaeff"

    def get_screen_dimensions(self, root):
        self.screenHeightUsed = (root.winfo_screenheight() - 100)
        self.screenWidthTotal = root.winfo_screenwidth()
        self.screenWidthUsed = self.screenWidthTotal - 15

        return self.screenHeightUsed, self.screenWidthUsed

#! /usr/bin/env python3
# -*- coding: utf-8 -*-

"""This module creates the main window. The windows size is automatically
selected using built-in functions. It displays a button that starts the program
it then asks the user's name and greets the user.

It also creates a menubar that brings the user back to the mainmenu, offers
administrative options y offers help to the user. The administrative
options just change the colors of the app.
"""

import tkinter as tk
import tkinter.colorchooser
import time
import sys
import os
import random
import PIL.ImageTk
import PIL.Image

import iofiles
import intervention
import settings


class MainApp(tk.Frame):
    """Uses tkinter and other classes defined by the developer to create the
    app.
    """

    def __init__(self, root):
        tk.Frame.__init__(self)
        self.root = root
        self.settings = settings.Settings()
        self.iodata = iofiles.IOData()
        self.userId = self.get_user_id()

        # Constants
        self.appFont = self.settings.appFont
        self.fontColor = self.settings.fontColor
        self.buttonColor = self.settings.buttonColor
        self.backgroundColor = self.settings.backgroundColor

        if "win" in sys.platform:
            topLevel = root.winfo_toplevel()
            topLevel.wm_state("zoomed")
        elif "linux" in sys.platform:
            root.attributes("-zoomed", True)

        self.root.configure(bg=self.backgroundColor)
        self.root.title("Intervención")

        # Main frame where everything else goes.
        self.mainFrame = tk.Frame(root, bg=self.backgroundColor)
        self.mainFrame.pack(expand=tk.YES, fill=tk.BOTH)

        # For erasing. Bottom frame
        self.bottomFrame = tk.Frame(self.mainFrame, bg=self.backgroundColor)
        self.bottomFrame.pack(
            in_=self.mainFrame,
            side=tk.BOTTOM,
            fill=tk.BOTH,
            expand=tk.YES
        )

        # Menu
        self.menuBar = MenuBar(
            self.mainFrame,
            self.back_to_main,
            self.user_help,
            self.admi_options,
            self.appFont,
            self.fontColor,
            self.buttonColor,
            self.backgroundColor
        )

        # To be able to change widgets configuration
        self.menuFrame, self.mainMenuButton, self.helpButton, \
            self.admiButton = self.menuBar.widget_return()

        ###########################
        # These buttons are disabled because their features have not been
        # added yet. Will be enable once they are.
        self.helpButton.forget()
        self.admiButton.forget()

        # Widgets frame
        self.widgetFrame = tk.Frame(self.bottomFrame, bg=self.backgroundColor)
        self.widgetFrame.pack(
            in_=self.bottomFrame,
            side=tk.TOP,
            ipady=100
        )

        self.startButton = tk.Button(
            self.widgetFrame,
            font=self.appFont,
            text='Comenzar',
            bg=self.buttonColor,
            command=self.welcome_screen
        )
        self.startButton.pack(side=tk.BOTTOM)

    def erase_content(self):
        """Erases the current bottomFrame's content and draws a new "bottomFrame"
        to draw new content.
        """

        self.bottomFrame.destroy()
        self.bottomFrame = tk.Frame(self.mainFrame, bg=self.backgroundColor)
        self.bottomFrame.pack(
            in_=self.mainFrame,
            side=tk.BOTTOM,
            fill=tk.BOTH,
            expand=tk.YES
        )

    def welcome_screen(self):
        """Creates a frame that covers the whole window and a frame for
        the widgets. It also creates a label that asks the user his
        name, an entry widget to write it and a button to continue.
        """

        self.erase_content()

        self.widgetFrame = tk.Frame(self.bottomFrame, bg=self.backgroundColor)
        self.widgetFrame.pack(
            in_=self.bottomFrame,
            side=tk.TOP,
            ipady=75
        )
        self.readyButton = tk.Button(
            self.widgetFrame,
            font=("Arial", 24),
            text="Listo",
            width=8,
            bg=self.buttonColor,
            command= self.greetingStudent
        )
        self.readyButton.pack(side=tk.BOTTOM, pady=3)

        self.usernameVariable = tk.StringVar()
        self.nameEntry = tk.Entry(
            self.widgetFrame,
            textvariable=self.usernameVariable,
            width=20,
            font=self.appFont
        )
        self.nameEntry.pack(side=tk.BOTTOM, pady=3)
        self.nameEntry.focus_set()

        self.nameLabel = tk.Label(
            self.widgetFrame,
            font=self.appFont,
            fg=self.fontColor,
            text="Escribe tu nombre para comenzar:",
            bg=self.backgroundColor,
        )
        self.nameLabel.pack(side=tk.BOTTOM, pady=3)

    def greetingStudent(self):
        """Creates a label that greets the user using his name."""

        self.erase_content()

        self.greetingFrame = tk.Frame(
            self.bottomFrame,
            bg=self.backgroundColor
        )
        self.greetingFrame.pack(
            in_=self.bottomFrame,
            side=tk.TOP,
            ipady=100
        )

        self.username = self.usernameVariable.get()
        self.greetingMessage1 = "Bienvenido"
        self.greetingMessage2 = "{}".format(self.username)
        self.greetingFont = ("Arial", 32)

        self.greetingLabelConfig = (
            (20, self.greetingMessage2),
            (12, self.greetingMessage1)
        )

        for _width, _text in self.greetingLabelConfig:
                self.greetingLabel = tk.Label(
                    self.greetingFrame,
                    font=self.greetingFont,
                    fg=self.fontColor,
                    bg=self.backgroundColor,
                    width=_width,
                    text=_text,
                    justify=tk.CENTER,
                    pady=2
                )
                self.greetingLabel.pack(side=tk.BOTTOM)

        self.assign_user_id()
        self.save_user_id()
        # This has to change in the future because it can't be interrupted.
        self.root.after(2000, self.start_letter_ordering)

    def back_to_main(self):
        """Erases the current window (main frame) and draws the main menu. To do
        this, it reuses the code from the __init__ method.
        """

        self.erase_content()

        self.widgetFrame = tk.Frame(self.bottomFrame, bg=self.backgroundColor)
        self.widgetFrame.pack(
            in_=self.bottomFrame,
            side=tk.TOP,
            ipady=100
        )

        self.startButton = tk.Button(
            self.widgetFrame,
            font=self.appFont,
            text='Comenzar',
            bg=self.buttonColor,
            command=self.welcome_screen
        )
        self.startButton.pack(side=tk.BOTTOM)

    def user_help(self):
        """Offers help with the current task. I haven't decided if it will be
        included in the final version.
        """
        self.mensajeAyuda = """Esta es la ayuda para esta actividad."""
        # Here goes the widget that will offer help.

    # Administrative tools
    def login_admi(self, menuFrame):
        """Erases the current content and creates a series of nestes frames
        so the login can be organized. In the future the app should use
        the grid manager and this should go away.

        The entries are in a different frame than the their labels. It then
        calls the admin_access method to verify the info.
        """

        self.erase_content()

        # Nested frames
        self.containingFrame = tk.Frame(self.bottomFrame, bg=self.backgroundColor)
        self.containingFrame.pack(in_=self.bottomFrame, pady=120)

        self.widgetFrame = tk.Frame(self.containingFrame, bg=self.backgroundColor)
        self.widgetFrame.pack(in_=self.containingFrame, ipady=15)

        self.loginFrame = tk.Frame(self.widgetFrame, bg=self.backgroundColor)
        self.loginFrame.pack(in_=self.widgetFrame, side=tk.TOP)

        self.buttonFrame = tk.Frame(self.widgetFrame, bg=self.backgroundColor)
        self.buttonFrame.pack(in_=self.widgetFrame, side=tk.BOTTOM)

        self.labelFrame = tk.Frame(self.loginFrame, bg=self.backgroundColor)
        self.labelFrame.pack(in_=self.loginFrame, side=tk.LEFT)

        self.entryFrame = tk.Frame(self.loginFrame, bg=self.backgroundColor)
        self.entryFrame.pack(in_=self.loginFrame, side=tk.RIGHT)

        # Login
        self.authorizedUsers = {"mario.bermonti": "trabajo.minions"}
        self.userName = tk.StringVar()
        self.password = tk.StringVar()

        self.loginLabelConfig = ("Usuario", "ContraseÃ±a")

        for _text in self.loginLabelConfig:
            self.loginLabel = tk.Label(
                self.labelFrame,
                font=self.appFont,
                fg=self.fontColor,
                text=_text,
                bg=self.backgroundColor
            )
            self.loginLabel.pack()

        self.userNameEntry = tk.Entry(
            self.entryFrame,
            width=20,
            font=self.appFont,
            textvariable=self.userName
        )
        self.userNameEntry.pack()
        self.userNameEntry.focus_set()

        self.passwordEntry = tk.Entry(
            self.entryFrame,
            width=20,
            font=self.appFont,
            textvariable=self.password
            )
        self.passwordEntry.pack()

        self.enterButton = tk.Button(
            self.buttonFrame,
            font=("Arial", 20),
            text="Entrar",
            bg=self.buttonColor,
            width=8,
            command= self.admin_access
        )
        self.enterButton.pack()

    def admin_access(self):
        """Checks that the information provided is in the dictonary of
        authorized users. Offers  message indicating if access is granted.
        """

        self.erase_content()

        self.widgetFrame = tk.Frame(self.bottomFrame,  bg=self.backgroundColor)
        self.widgetFrame.pack(
            in_=self.bottomFrame,
            side=tk.TOP,
            ipady=100
        )

        self.userNameUsed = self.userName.get()
        self.passwordUsed = self.password.get()
        self.message = tk.StringVar()

        if (self.userNameUsed in self.authorizedUsers and
                self.passwordUsed == self.authorizedUsers[self.userNameUsed]):
            self.admi_options()

        else:
            self.message.set("El nombre de usuario o contraseña son incorrectos.")
            self.accessMessage = self.message.get()
            self.accessLabel = tk.Label(
                self.widgetFrame,
                font=self.appFont,
                fg=self.fontColor,
                text=self.accessMessage,
                bg=self.backgroundColor
            )
            self.accessLabel.pack(side=tk.BOTTOM)

    def admi_options(self, menuFrame):
        """Presents available adminsitrative options."""

        self.erase_content()

        self.widgetFrame = tk.Frame(self.bottomFrame,  bg=self.backgroundColor)
        self.widgetFrame.pack(
            in_=self.bottomFrame,
            side=tk.TOP,
            ipady=100
        )

        self.colorButton = tk.Button(
            self.widgetFrame,
            font=self.appFont,
            text='Apariencia',
            bg=self.buttonColor,
            command=self.app_appearance
            )
        self.colorButton.pack(side=tk.BOTTOM)

    def app_appearance(self):
        """Changes the app's appearence, such as the color. The widgets have to
        be re-drawn in order for the eefects to take place.
        """

        self.erase_content()
        self.widgetFrame = tk.Frame(self.bottomFrame,  bg=self.backgroundColor)
        self.widgetFrame.pack(
            in_=self.bottomFrame,
            side=tk.TOP,
            ipady=80
        )

        self.colorChooserConfig = (
            ("Color Texto", self.font_colorchooser),
            ("Color Botones", self.choose_Buttoncolor),
            ("Color Frames", self.choose_backgroundcolor)
        )

        for _text, _callBack in self.colorChooserConfig:
            self.buttonColors = tk.Button(
                self.widgetFrame,
                font=self.appFont,
                text=_text,
                bg=self.buttonColor,
                width=13,
                command=_callBack
                )
            self.buttonColors.pack(side=tk.BOTTOM, pady=10)

    def choose_Buttoncolor(self):
        """Lets the user select the color of the buttons. The changes are not
        permanent, but the colors are printed in the shell and written
        to a file named "config" so they can be used to manually set the
        desired button color.
        """

        self.myColor = tkinter.colorchooser.askcolor()
        self.colorSelected = self.myColor[1]
        self.buttonColor = self.colorSelected
        self.mainMenuButton["background"] = self.colorSelected
        self.helpButton["background"] = self.colorSelected
        self.admiButton["background"] = self.colorSelected
        self.app_appearance()
        print("Numeración del color: {}".format(self.colorSelected))

    def choose_backgroundcolor(self):
        """Lets the user select the color of the background. The changes are not
        permanent, but the colors are printed in the shell and written
        to a file named "config" so they can be used to manually set the
        desired background color.
        """

        self.myColor = tkinter.colorchooser.askcolor()
        self.colorSelected = self.myColor[1]
        self.backgroundColor = self.colorSelected
        self.menuFrame["background"] = self.colorSelected
        self.app_appearance()
        print("Numeración del background: {}".format(self.colorSelected))

    def font_colorchooser(self):
        """Lets the user select the color of the widgets. The changes are not
        permanent, but the colors are printed in the shell and written
        to a file named "config" so they can be used to manually set the
        desired widget color.
        """

        self.myColor = tkinter.colorchooser.askcolor()
        self.colorSelected = self.myColor[1]
        self.fontColor = self.colorSelected
        self.app_appearance()
        print("Numeración del background: {}".format(self.colorSelected))

    def start_letter_ordering(self):
        self.erase_content()
        letter_ordering = intervention.LetterOrdering(
            parent=self.bottomFrame,
            studentName=self.username
            )

    def assign_user_id(self):
        """Gets a new ID for the user if he or she doesn't already have one,
        if they do it will retrieve it. This will help protect his identity.
        """

        if self.username in self.userId:
            self.username = self.userId[self.username]
        else:
            self.userId[self.username] = str(random.randrange(1000, 9999))
            self.username = self.userId[self.username]

    def get_user_id(self):
        """Reads a json file that contains the user IDs information."""

        try:
            userId = self.iodata.read_pickle(
                os.path.join(
                    os.getcwd(),
                    "data",
                    "id"
                )
            )

            return userId

        except FileNotFoundError:
            return {}

    def save_user_id(self):
        """Saves a json file with the user IDs information."""

        self.iodata.write_pickle(
            os.path.join(
                os.getcwd(),
                "data",
                "id"
            ),
            self.userId
        )


class MenuBar(tk.Frame):
    """Creates a custom menubar on the top of the app. The following options
    are available from the menubar: Main menu, help (not supportes yet)
    and administrative options.

    ---------
    Parameters
    ---------

    parent = parent widget
    command1, 2, 3 = The commands for the buttons
    font = font type
    fg = text color
    bgButton = button background color
    bgFrame = frame background color
    """

    def __init__(self, parent, command1, command2, command3, font, fg, bgButton, bgFrame):
        tk.Frame.__init__(self)
        self.mainFrame = parent
        self.appFont = font

        # Constants
        self.appFont = ('Arial', 20)
        self.menuFrame = tk.Frame(
            self.mainFrame,
            bg=bgFrame,
            borderwidth=3,
        )
        self.menuFrame.pack(
            in_=self.mainFrame,
            side=tk.TOP,
            fill=tk.X
        )

        # This button only exists so the image is saved as its attribute and
        # doesn't get get eliminated by the garbage collector.
        placeHolderForImage = tk.Button()
        self.homeImage = PIL.Image.open(
            os.path.join(os.getcwd(), "images", "home.png"))
        placeHolderForImage.image = PIL.ImageTk.PhotoImage(self.homeImage)

        self.mainMenuButton = tk.Button(
            self.menuFrame,
            image=placeHolderForImage.image,
            font=self.appFont,
            bg=bgFrame,
            relief=tk.FLAT,
            command=command1
        )
        self.mainMenuButton.pack(side=tk.LEFT, padx=2)

        self.helpButton = tk.Button(
            self.menuFrame,
            text="Ayuda",
            font=self.appFont,
            bg=bgButton,
            command=command2
            )
        self.helpButton.pack(side=tk.LEFT, padx=2)

        self.admiButton = tk.Button(
            self.menuFrame,
            text="Administrativo",
            font=self.appFont,
            bg=bgButton,
            command=lambda: command3(self.menuFrame)
        )
        self.admiButton.pack(side=tk.LEFT, padx=2)

    def widget_return(self):
        """This function is used by the main app to return the name of buttons and
        frames created so the main app can change their configuration (color).
        """

        return self.menuFrame, self.mainMenuButton, self.helpButton, self.admiButton


if __name__ == "__main__":
    root = tk.Tk()
    main_app = MainApp(root)
    root.mainloop()

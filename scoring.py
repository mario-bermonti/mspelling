import tkinter as tk
import PIL.ImageTk
import PIL.Image
import os

import settings


class Scoring():
    """This class contains the methods that will score the user's responses."""

    def __init__(self, parent, canvas, backgroundColor):
        self.canvas = canvas
        self.backgroundColor = backgroundColor
        self.parent = parent
        self.settings = settings.Settings()

    def determine_if_ordered_correctly(self, word, letterIds):
        """Determines if the user placed the letters in the correct order.
        Returns true if the order in which the user organized the letters
        is the same as the order of the letters in the word.
        """

        orderOfOrganizedLetters = self.get_letter_coordinates(letterIds)
        score = orderOfOrganizedLetters == word
        self.show_feedback(score=score)

        if score:
            return 1
        else:
            return 0

    def get_letter_coordinates(self, letterIds):
        """Returns a dictionary with the letters as the keys and their x
        coordinates as their values.
        """

        lettersXCoordinates = dict()
        for letterId in letterIds:
            letterTags = self.canvas.gettags(letterId)
            letterCoordinates = tuple(self.canvas.coords(letterId))

            if letterTags[1] not in lettersXCoordinates:
                lettersXCoordinates[letterTags[1]] = letterCoordinates
            else:
                letterTag = letterTags[1] + "1"
                lettersXCoordinates[letterTag] = letterCoordinates

        return self.get_comparison_string(lettersXCoordinates)

    def get_comparison_string(self, lettersXCoordinates):
        """Returns a string representing the order in which the user organized
        the letters. It will be used as a comparison to determine if
        the user ordered correctly the letters.

        -------------------
        Parameter
        lettersXCoordinates: A dictionary with the letters as the keys
        and their x coordinates as their values.
        """

        lettersXCoordinates = self.order_dictionary(
            lettersXCoordinates,
            (1, 0)
        )

        orderedLetters = []
        for items in lettersXCoordinates:
            orderedLetters.append(items[0][0])

        comparisonString = "".join(orderedLetters)

        return comparisonString

    def determine_if_written_correctly(self, usersResponse, word):
        """Determines if the user wrote correctly the word in step 3. Returns
        true if the user wrote the word in the correct order.
        """

        score = usersResponse.lower() == word.lower()
        self.show_feedback(score=score)

        if score:
            return 1
        else:
            return 0

    def order_dictionary(self, dictName, indexes):
        """Returns a list of tuples ordered by the index specified by the
        method get_index_for_sorting.
        """

        self.indexesToSortBy = indexes
        itemsForSorting = self.prepare_for_sorting(dictName)

        itemsForSorting.sort(key=self.get_index_for_sorting)

        return itemsForSorting

    def prepare_for_sorting(self, dictName):
        """Returns a list of the items in the dictionary dictName.

        -----------------------
        Parameter:
        dictName: Is the dictionary that will be sort by the
        order_dictionary method.
        """

        return list(dictName.items())

    def get_index_for_sorting(self, dictName):
        """This method is used to extract the index by which the sort method
        will sort the items in the center_dictionary space method. x and y
        had to be defined by instance variables because this method is used
        by the sort method which only accepts one parameter and it has to be
        the dictionary name.

        -----------------------
        Parameter:
        dictName: Is the dictionary that will be sort by the
        order_dictionary method.
        """

        x, y = self.indexesToSortBy[0], self.indexesToSortBy[1]

        return dictName[x][y]

    def show_feedback(self, score):
        """This method presents feedback based on the user's response."""

        self.clean_screen()
        x, y = self.get_feedback_coordinates()

        if score:
            self.image = PIL.Image.open(
                os.path.join(os.getcwd(), "images", "happy_face.png")
            )
        else:
            self.image = PIL.Image.open(
                os.path.join(os.getcwd(), "images", "sad_face.png"))

        self.canvas.background = PIL.ImageTk.PhotoImage(self.image)
        self.canvas.create_image(x, y, image=self.canvas.background)

        self.hold_feedback()

        return

    def hold_feedback(self):
        """Keeps the feedback on the screen for one second. Uses a local loop
        that is created by tk methods to avoid crashing the application.
        """

        self.continueWithFeedback = tk.IntVar()
        self.canvas.after(1000, self.continue_with_feedback)
        self.canvas.wait_variable(self.continueWithFeedback)

        return

    def continue_with_feedback(self):
        """This is a helper function that sets continueWithFeedback to 1,
        So the feedback can escape the loop.
        """

        self.continueWithFeedback.set(1)

        return

    def clean_screen(self):
        """Clears the canvas so new things can be drawn on it."""

        self.canvas.delete("all")

        return

    def get_screen_coordinates(self):
        """Gets the windows coordinates so the images and feedback can be drawn on
        the screen on the right place.
        """

        canvasHeight, canvasWidth = (
            self.settings.get_screen_dimensions(root=self.parent)
        )

        return canvasWidth, canvasHeight

    def get_feedback_coordinates(self):
        """Gets the coordinatesfor the window which will contain what ever widget
        is presented that the user.
        """

        canvasWidth, canvasHeight = self.get_screen_coordinates()

        return canvasWidth/2, canvasHeight/3

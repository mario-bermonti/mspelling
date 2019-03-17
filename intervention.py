#! /usr/bin/env python3
# -*- coding: utf-8 -*-

import tkinter as tk
import random
import time
import sys
import os
import threading
import PIL.ImageTk
import PIL.Image

import scoring
import settings
import data
import storage
import audio
import iofiles


class LetterOrdering(tk.Frame):
    """Creates a pc version of the Letter ordering for spelling
    intervention.
    """

    def __init__(self, parent, studentName):
        """Creates a canvas on which draggable objects will be placed and a
        button to continue. It also calls the get_words and step1 methods.
        """

        tk.Frame.__init__(self)
        self.studentName = studentName
        self.parent = parent
        self.settings = settings.Settings()
        self.appFont = ("Arial", 22)
        self.fontColor = self.settings.fontColor
        self.buttonColor = self.settings.buttonColor
        self.backgroundColor = self.settings.backgroundColor

        self.dataStorage = storage.DataStorage()
        self.iodata = iofiles.IOData()
        self.totalNumberOfSessions = self.get_total_number_of_sessions()
        self.dataHandling = data.DataHandling(
            username=self.studentName,
            sessions=self.totalNumberOfSessions
        )
        self.audio = audio.Audio(
            self.studentName,
            self.dataHandling.get_session_number()
        )
        self.audio.get_recording_attributes_ready()
        self.isRecording = False
        self.usersDifficultyLevel = self.get_users_difficulty_level()

        self.canvasHeight, self.canvasWidth = (
            self.settings.get_screen_dimensions(root=self.parent)
        )

        self.canvas = tk.Canvas(
            self.parent,
            background=self.backgroundColor,
            highlightbackground=self.backgroundColor
        )
        self.canvas.pack(fill=tk.BOTH, expand=tk.YES)

        self.scoringSystem = scoring.Scoring(
            parent=self.parent,
            canvas=self.canvas,
            backgroundColor=self.backgroundColor
        )

        self.get_words()
        self.step1()

    def get_words(self):
        """It reads a file with the words to be used as a list of words and
        randomized the order of the words. The maximun number of letters a
        word can have is 11.

        To do:
        1. Will be replaced with the Readwrite class found on the ReadStimulus
        module.
        2. Include a test for the maximun number of letter in a word (11).
        """

        self.iodata.read_file_lines(
            os.path.join(
                os.getcwd(),
                "stimuli",
                "words",
                "{}.txt".format(
                    self.usersDifficultyLevel[self.studentName][-1]
                )
            ),
            errorHandling="ignore")
        self.words = self.iodata.get_data()
        random.shuffle(self.words)

        return

    def next_word(self):
        """Prepares the words that are going to be used next. It gets one
        word from the list, finds its length, turns the word into a list,
        were every letter is an element and randomized the order of the
        letters. It returns a list of letters that make up the word.
        """

        if len(self.words) == 0:
            self.save_exit_application()
        self.word = self.words.pop()
        self.word = self.word.lower()
        self.wordLen = len(self.word)
        correctOrder = list(self.word)
        self.randomizedWord = list(self.word)
        while True:
            random.shuffle(self.randomizedWord)
            if self.randomizedWord == correctOrder:
                random.shuffle(self.randomizedWord)
            else:
                break

        return self.randomizedWord

    def boxes_coordinates(self):
        """Returns the coordinates of the first box to be drawn. The canvas'
        coordinates are used to determined them. They will be used to place
        the letters.
        """

        self.y1 = self.canvasHeight - 568
        self.y2 = self.y1 + 125
        self.centerpoint = self.canvasWidth/2
        self.x1 = self.centerpoint - (58 * self.wordLen)

        # If boxes go too much to the left, it assigns a default value so
        # it doesn't let the boxes fall of the screen.
        if self.x1 <= 5:
            self.x1 = 5

        self.x2 = self.centerpoint + (85 * self.wordLen)
        return self.x1, self.y1, self.x2, self.y2

    def create_letter_boxes(self):
        """Creates boxes for the letters to be places in. The maximun is
        11 boxes so they don't fall off the screen. It uses the
        boxes_coordinates method to get the coordinates that are going
        to be used to draw the lettes.
        """

        x1, y1, x2, y2 = self.boxes_coordinates()
        self.x1 = x1
        self.x2 = self.x1 + 110
        self.y1 = y1
        self.y2 = y2

        for letter in range(self.wordLen):
            LetterBoxes = self.canvas.create_rectangle(
                (self.x1, self.y1, self.x2, self.y2),
                fill=self.buttonColor,
                width=0,
                tags="letterboxes"
            )
            self.x1 = self.x2 + 5
            self.x2 = self.x1 + 110

    def draw_letters(self, randomizedWord):
        """It accepts the parameter randomizedWord, which is a list with the
        letters of the word to be presented. It also calls the
        create_letter_boxes method to create the boxes in which the
        letters will be placed by the user.

        It turns every letter of the word 'randomizedWord' into a movable
        object that can be dragged on the screen.
        It creates a dictionary to keep track of the leeters movements and
        binds the mouses' function on the letters to their respective function.
        """

        self.create_letter_boxes()

        # Helps keep track of the item being moved
        self.dragData = {"x": 0, "y": 0, "item": None}

        # Bindings for clicking, dragging and releasing objects (letters)
        self.canvas.tag_bind(
            "letters", "<ButtonPress-1>", self.on_object_press
        )
        self.canvas.tag_bind(
            "letters", "<ButtonRelease-1>",
            self.on_object_release)
        self.canvas.tag_bind("letters", "<B1-Motion>", self.on_object_motion)

        # Determines the position of the first letter
        self.x = (self.centerpoint + 55) - (self.wordLen * 55)
        # If x falls out of the screen, 50 is used as the default value of x
        if self.x <= 30:
            self.x = 50

        for letter in randomizedWord:
            movableLetter = self.canvas.create_text(
                self.x,
                525,
                text=letter,
                font=("Arial", 90),
                fill=self.fontColor,
                activefill="black",
                tags=("letters", letter)
            )

            self.x += 107

    def on_object_press(self, event):
        """First it resets the information of the last object's movement. Then,
        it stores the information for the new movable object: an identifier
        (number that represents the order in which it was created), its x and
        y position. The positions are relative to the canvas.
        """

        self.dragData["item"] = None
        self.dragData["x"] = 0
        self.dragData["y"] = 0

        self.dragData["item"] = self.canvas.find_closest(event.x, event.y)[0]
        self.dragData["x"] = event.x
        self.dragData["y"] = event.y

    def on_object_release(self, event):
        """Calls the method that organizes the letters in the respective
        box.
        """

        self.organize_letters()

    def on_object_motion(self, event):
        """Calculates the delta of movement in order to determine the
        object's new position. Uses the change in position
        (final - initial).
        """

        # Slows the object's movement to avoid lagging behind
        time.sleep(.05)

        delta_x = event.x - self.dragData["x"]
        delta_y = event.y - self.dragData["y"]

        # Moves the object to the apropiate position
        self.canvas.move(self.dragData["item"], delta_x, delta_y)

        # Saves the object's new position
        self.dragData["x"] = event.x
        self.dragData["y"] = event.y

    def step1(self):
        """This is the first step described in the Letter Ordering for Spelling
        intervention. It determines the next step to go to and calls the
        ______ method to get a new word. It then calls the  _____ method
        which presents the word verbally. Then it calls the draw_letters method
        which draws the word on the screen.

        Finally, it draws a button that the user will press when he has
        finished and the button will cal the scoring method.
        """

        currentStep = 1
        self.randomizedWord = self.next_word()
        self.instructions_ordering_letters()
        self.draw_letters(self.randomizedWord)

        self.checkmark = PIL.Image.open(
            os.path.join(os.getcwd(), "images", "checkmark.png"))
        self.canvas.background = PIL.ImageTk.PhotoImage(self.checkmark)

        self.nextButton = tk.Button(
            font=self.appFont,
            image=self.canvas.background,
            bg=self.buttonColor,
            relief=tk.FLAT,
            command=lambda: self.scoring(currentStep)
        )
        self.buttonWindow = self.canvas.create_window(
            (self.canvasWidth - 150),
            (self.canvasHeight - 300),
            window=self.nextButton,
            tags="readybutton",
        )

    def step2(self):
        """This is the second step described in the Letter Ordering for Spelling
        intervention. It's virtually the same as step1, but it doesn't call
        next_word.

        It determines the next step to go to and it then calls the
         _____ method which presents the word verbally. Then
        it calls the draw_letters method which draws the word
        (which is the same as in step1) on the screen.

        Finally, it draws a button that the user will press when he has
        finished and the button will call the scoring method.
        """

        currentStep = 2
        self.clean_screen()
        random.shuffle(self.randomizedWord)
        self.draw_letters(self.randomizedWord)

        self.checkmark = PIL.Image.open(
            os.path.join(os.getcwd(), "images", "checkmark.png"))
        self.canvas.background = PIL.ImageTk.PhotoImage(self.checkmark)

        self.nextButton = tk.Button(
            font=self.appFont,
            bg=self.buttonColor,
            image=self.canvas.background,
            command=lambda: self.scoring(currentStep)
        )
        self.buttonWindow = self.canvas.create_window(
            (self.canvasWidth - 150),
            (self.canvasHeight - 300),
            window=self.nextButton,
            tags="readybutton"
        )

    def step3(self):
        """This is the third step described in the Letter Ordering for Spelling
        intervention.

        It determines the next step to go to and it then calls the eecord_audio
        method so the user can say the word outloud. It then calls the ________
        method to clear the screen. It then draws an entry for the user to
        write the word.

        Finally, it draws a button that the user will press when he has
        finished and the button will call the scoring method.
        """

        currentStep = 3
        self.clean_screen()
        self.wordResponseLabel = tk.Label(
            font=("Arial", 32),
            text="Escribe la palabra",
            bg=self.backgroundColor,
            fg=self.fontColor,
            width=20,
            )
        self.labelWindow = self.canvas.create_window(
            (self.canvasWidth - 700),
            (self.canvasHeight - 500),
            window=self.wordResponseLabel,
            tags="label"
        )

        self.wordResponseEntry = tk.StringVar()
        self.wordResponseEntry = tk.Entry(
            font=self.appFont,
            textvariable=self.wordResponseEntry,
            width=20,
            )
        self.entrywindow = self.canvas.create_window(
            (self.canvasWidth - 700),
            (self.canvasHeight - 425),
            window=self.wordResponseEntry,
            tags="entry"
        )
        self.wordResponseEntry.focus_set()

        self.checkmark = PIL.Image.open(
            os.path.join(os.getcwd(), "images", "checkmark.png"))
        self.canvas.background = PIL.ImageTk.PhotoImage(self.checkmark)

        self.nextButton = tk.Button(
            font=self.appFont,
            image=self.canvas.background,
            bg=self.buttonColor,
            command=lambda: self.scoring(currentStep)
        )
        self.nextbuttonWindow = self.canvas.create_window(
            (self.canvasWidth - 150),
            (self.canvasHeight - 300),
            window=self.nextButton,
            tags="readybutton"
        )

    def organize_letters(self):
        """This method organizes (centers) the letters on the box in which
        the letter was placed by the user. It uses the method is_close_enough
        to determine if the letter is close enough to justify its arrangement.
        If it is, it calls the method which_is_boxes_closest to determine which
        box is closest and then arranges the letter inside that box.
        """

        if self.is_close_enough(self.dragData["item"]):
            orderedBoxCoordinates = self.which_box_is_closest(
                self.dragData["item"]
            )

            self.canvas.coords(
                self.dragData["item"],
                orderedBoxCoordinates[0],
                orderedBoxCoordinates[1]
            )

    def is_close_enough(self, movedLetter):
        """Determines if the letter moved by the user is close enough to the
        boxes so that it should be organized.

        Returns true if the letter moved by the user is inside a specific
        region that determines that is close enough.

        ------------------------------
        Parameter:
        movedLetter: it is an integer that specifies the object's position
        in the display list.
        """

        self.x1, self.y1, self.x2, self.y2 = self.canvas.bbox("letterboxes")

        enclosedItems = self.canvas.find_enclosed(
            self.x1-35,
            self.y1-50,
            self.x2+35,
            self.y2+50
        )

        return (movedLetter in enclosedItems)

    def which_box_is_closest(self, movedLetter):
        """Determines which of the boxes is closest to the letter moved by the
        user. Calls different methods to determine a point in the center
        of the boxes, determines the distance of each box from the letter,
        and to organize the coordinates for the point in the center of the
        boxes in ascending order based its the distance from the letter.

        Returns the coordinates for the center of the box in which the letter
        will be arranged in.

        -----------------------
        Parameter:
        movedLetter: it is an integer that specifies the object's position
        in the display list.
        """

        letterCoordinateX = self.canvas.coords(movedLetter)[0]
        centerOfBoxes = self.get_center_of_boxes(
            self.canvas.find_withtag("letterboxes")
        )

        distancesFromLetter = self.get_distance_letter_and_boxes(
            letterCoordinateX,
            centerOfBoxes
        )

        newLetterCoords = self.order_dictionary(distancesFromLetter, (1, 2))

        return (newLetterCoords[0][1][0:2])

    def get_center_of_boxes(self, boxesIds):
        """Returns a dictionary with the box's ID as the key and as its
        value, a tuple comprising a point at the center of the box in the form
        x, y.

        ----------------------
        parameter:
        boxesIds: is an sequence which represents the order in the display list
        of the objects. Its values are integers.
        """

        centerOfBoxes = dict()
        for box in boxesIds:
            x1, y1, x2, y2 = self.canvas.bbox(box)
            boxWidth = x1 + ((x2 - x1)/2)
            boxHeight = y1 + ((y2 - y1)/2)
            centerOfBoxes[box] = (int(boxWidth), int(boxHeight))

        return centerOfBoxes

    def get_distance_letter_and_boxes(self, letterCoordinateX, centerOfBoxes):
        """Returns a dictionary with the box's ID as the key and a tuple
        containing its x coordinate, y coordinate, and distance from the letter
        as its value.

        --------------
        parameters:
        letterCoordinateX: It's the x-coordinate for the  letter moved.
        centerOfBoxes: Is a dictionary with the every box's ID as the key and
        as its value, a tuple comprising a point at the center of the box in
        the form x, y.
        """

        boxDistanceFromLetter = dict()
        for box in centerOfBoxes:
            distance = abs(letterCoordinateX - centerOfBoxes[box][0])
            boxDistanceFromLetter[box] = (centerOfBoxes[box] +
                                          (distance, )
                                          )

        return boxDistanceFromLetter

    def record_audio(self, step):
        """Displays recording instructions and calls the functions that
        record audio.
        """

        self.clean_screen()
        x, y = self.get_instructions_coordinates("text")
        self.canvas.create_text(
            x,
            y-125,
            text="Presiona el botón y di la palabra",
            font=("Arial", 30),
            fill=self.fontColor,
            activefill="black",
            tags="record instructions"
        )

        # This button only exists so the image is saved as its attribute and
        # doesn't get get eliminated by the garbage collector.
        placeHolderForImage = tk.Button()
        self.recordingImage = PIL.Image.open(
            os.path.join(os.getcwd(), "images", "recording.png"))
        placeHolderForImage.image = PIL.ImageTk.PhotoImage(self.recordingImage)

        x, y = self.get_instructions_coordinates("button")
        self.recordButton = tk.Button(
            font=self.appFont,
            image=placeHolderForImage.image,
            bg=self.buttonColor,
            activebackground="red",
            width=175,
            height=165
        )
        self.recordWindow = self.canvas.create_window(
            x,
            y-75,
            window=self.recordButton,
        )
        self.recordButton.bind("<Button-1>", self.record)
        self.recordButton.bind("<ButtonRelease-1>", self.audio.stop_recording)

        self.checkmark = PIL.Image.open(
            os.path.join(os.getcwd(), "images", "checkmark.png"))
        self.canvas.background = PIL.ImageTk.PhotoImage(self.checkmark)
        self.doneRecording = tk.Button(
            font=self.appFont,
            image=self.canvas.background,
            bg=self.buttonColor,
            relief=tk.FLAT,
        )
        if step == "step 2":
            self.doneRecording.config(command=self.step2)
        elif step == "step 3":
            self.doneRecording.config(command=self.step3)

        self.doneRecordingWindow = self.canvas.create_window(
            (self.canvasWidth - 150),
            (self.canvasHeight - 300),
            window=self.doneRecording,
        )

    def record(self, event):
        """Indicates to the user that the program's recording."""

        # x, y = self.get_instructions_coordinates("text")
        #self.canvas.create_text(
            #x,
            #y,
            #text="grabando",
            #font=("Arial", 30),
            #fill=self.fontColor,
            #activefill="black"
        #)
        t = threading.Thread(
            target=self.audio.record_audio,
            args=(self.word, )
        )
        t.start()

        return

    def present_audio(self):
        """Presents instructions for the user and plays the file saying the
        word that the user must organize."""

        #self.audio.play_audio(os.path.join(
            ##os.getcwd(),
            ##"stimuli",
            ##"instructions",
            ##"instructions_ordering_letters")
        ##)

        self.audio.play_audio(os.path.join(
            os.getcwd(),
            "stimuli",
            "audio",
            self.word.lower())
        )

        # think this fn call and the method can be eliminated
        self.hold_recording_instructions()

        return

    def hold_recording_instructions(self):
        """Keeps the feedback on the screen for one second. Uses a local loop
        that is created by tk methods to avoid crashing the application.
        """

        a = 1

        return

    # think this method can be eliminated
    def continue_execution(self):
        """This is a helper function that sets continueWithFeedback to 1,
        So the feedback can escape the loop.
        """

        self.continueExecution.set(1)

        return

    ##############################################
    ############# Needs fixing ###################
    ## If no instructions are gonna be given then change the name should
    ## change and the code that presented the instructions should be
    ## eliminated.
    def instructions_ordering_letters(self):
        #"""Presents written instructions to the user."""
#
        ##self.canvas.create_text(
            ##self.canvasWidth/2,
            ##self.canvasHeight - 568,
            ##text="Escucha con mucha atención.",
            ##font=("Arial", 50),
            ##fill=self.fontColor,
            ##tags="instructions"
        ##)

        self.canvas.after(100, self.present_audio)

        return

    def scoring(self, currentStep):
        """This method will score the participants' answer. It has specific
        procedures depending on the current step, determined by currentStep.

        Then, the method calls the appropiate 'next step'.
        """

        if currentStep == 1:
            print("scoring step 1")
            score = self.scoringSystem.determine_if_ordered_correctly(
                word=self.word,
                letterIds=self.canvas.find_withtag("letters")
            )

            self.dataHandling.update_word(self.word)
            ##########################################################
            # self.dataHandling.update_results_for_current_word's first
            ## parameter needs to be updated when the methods to whatever time
            ## took the user to complete it.
            self.dataHandling.update_results_for_current_word(score, 0.0)
            self.clean_screen()
            self.record_audio("step 2")

        elif currentStep == 2:
            print("scoring step 2")
            score = self.scoringSystem.determine_if_ordered_correctly(
                word=self.word,
                letterIds=self.canvas.find_withtag("letters")
            )

            ##########################################################
            ## self.dataHandling.update_results_for_current_word's first
            ## parameter needs to be updated when the methods to whatever time
            ## took the user to complete it.
            self.dataHandling.update_results_for_current_word(score, 0.0)

            self.clean_screen()
            self.record_audio("step 3")

        elif currentStep == 3:
            print("scoring step 3")
            score = self.scoringSystem.determine_if_written_correctly(
                usersResponse=self.wordResponseEntry.get(),
                word=self.word
            )

            ##########################################################
            ## self.dataHandling.update_results_for_current_word's first
            ## parameter needs to be updated when the methods to whatever time
            ## took the user to complete it.
            self.dataHandling.update_results_for_current_word(score, 0.0)
            self.dataHandling.update_global_measures_for_word()

            self.clean_screen()
            self.step1()

        return

    def clean_screen(self):
        """Clears the canvas so new things can be drawn on it."""

        self.canvas.delete("all")

        return

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

    def save_session_info(self):
        """Saves the global session's info."""

        self.dataHandling.update_global_session_info()
        userData = self.dataHandling.get_active_session_info()
        self.dataStorage.export_to_csv(
            username=self.studentName,
            sessionNumber=self.dataHandling.get_session_number(),
            data=userData
        )

        return

    def get_instructions_coordinates(self, object):
        """Gets the coordinatesfor the window which will contain what ever widget
        is presented that the user.
        """

        canvasWidth, canvasHeight = self.get_screen_coordinates()

        if object == "button":
            return canvasWidth/2 - 20, canvasHeight/3 + 80
        else:
            return canvasWidth/2 - 20, canvasHeight/3

    def get_screen_coordinates(self):
        """Gets the windows coordinates so the images and feedback can be drawn on
        the screen on the right place.
        """

        canvasHeight, canvasWidth = (
            self.settings.get_screen_dimensions(root=self.parent)
        )

        return canvasWidth, canvasHeight

    def determine_users_working_level(self):
        """Determine the difficulty level that the user should work on the
        next session.
        """

        correctPercentage = self.dataHandling.get_correct_percentage()
        if correctPercentage >= 80:
            newLevel = self.usersDifficultyLevel[self.studentName][-1] + 1
            self.usersDifficultyLevel[self.studentName].append(newLevel)
        elif correctPercentage < 40:
            newLevel = self.usersDifficultyLevel[self.studentName][-1] - 1
            self.usersDifficultyLevel[self.studentName].append(newLevel)
        else:
            newLevel = self.usersDifficultyLevel[self.studentName][-1]
            self.usersDifficultyLevel[self.studentName].append(newLevel)

    def get_users_difficulty_level(self):
        """Reads a json file with the difficulty levels that each user has
        worked on.
        """

        if self.totalNumberOfSessions < 2:
            return {self.studentName: [1]}
        else:
            difficultyLevel = self.iodata.read_json(os.path.join(
                os.getcwd(),
                "data",
                "difficulty level"
                )
            )
            if self.studentName not in difficultyLevel:
                difficultyLevel[self.studentName] = [1]

            return difficultyLevel

    def save_difficulty_level_information(self):
        """Saves the difficulty level information to json file."""

        self.iodata.write_json(
            os.path.join(
                os.getcwd(),
                "data",
                "difficulty level"
            ),
            self.usersDifficultyLevel,
            mode="w"

        )

    def get_total_number_of_sessions(self):
        """Reads a json file indicating the total number of sessions."""

        try:
            totalNumberOfSessions = self.iodata.read_json(os.path.join(
                os.getcwd(),
                "data",
                "number of sessions"
                )
            )
        except FileNotFoundError:
            return 1

        return totalNumberOfSessions

    def save_total_number_of_sessions(self):
        """Saves total number of sessions to json file."""

        self.iodata.write_json(
            os.path.join(
                os.getcwd(),
                "data",
                "number of sessions"
            ),
            self.totalNumberOfSessions,
            mode="w"

        )

    def save_exit_application(self):
        """Closes the aplication."""

        self.save_session_info()
        self.totalNumberOfSessions += 1
        self.determine_users_working_level()
        self.save_difficulty_level_information()
        self.save_total_number_of_sessions()
        self.dataHandling.save_all_users_session_count()
        self.audio.end_all()
        sys.exit()

if __name__ == "__main__":
    root = tk.Tk()
    letter_ordering = LetterOrdering(root)
    root.mainloop()

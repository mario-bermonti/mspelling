import os
import iofiles


class DataHandling:
    """These class handles all of the user's data."""

    def __init__(self, username, sessions):
        """Initializes all needed data."""

        self.iodata = iofiles.IOData()
        self.username = username
        self.wordCount = 0
        self.word = None
        self.participantScore = dict()

        self.numberOfSessions = sessions
        self.allUsersSessionCount = self.get_all_users_session_count()
        self.activeSessionInfo = {
            "total session score": {
                "number of words": 0,
                "total score": 0,
                "correct percentage": 0,
                "incorrect percentage": 0
            }
        }

    def update_word(self, word):
        """It sets self.word to the current word."""

        self.word = word
        self.add_word_to_session_info()
        self.update_word_count()

    def add_word_to_session_info(self):
        """Adds the new word to the session info dictionary so then it scores can
        be associated with it.
        """

        self.activeSessionInfo[self.word] = []

        return

    def update_word_count(self):
        """Updates the variable self.wordCount by one to establish the total
        number of words the user has worked on.
        """

        self.wordCount += 1

        return

    def update_all_users_session_count(self):
        """Updates self.allUsersSessionCount which contains the session
        number for all users.
        """

        if self.numberOfSessions < 2:
            return
        else:
            if self.username not in self.allUsersSessionCount:
                self.allUsersSessionCount[self.username] = 1
            else:
                self.allUsersSessionCount[self.username] += 1

        return

    def get_all_users_session_count(self):
        """Reads a json file with the number of sessions for each user."""

        if self.numberOfSessions < 2:
            return {self.username: 1}
        else:
            usersSessionCount = self.iodata.read_json(os.path.join(
                os.getcwd(),
                "data",
                "users session count"
                )
            )
            if self.username not in usersSessionCount:
                usersSessionCount[self.username] = 1
            else:
                usersSessionCount[self.username] += 1

            return usersSessionCount

    def save_all_users_session_count(self):
        """Saves the information of the session count for all the users."""

        self.iodata.write_json(
            os.path.join(
                os.getcwd(),
                "data",
                "users session count"
            ),
            self.allUsersSessionCount,
            mode="w"

        )

    def update_results_for_current_word(self, score1, score2):
        """Updates the results for the current word. It is called 5 times: the
        first three times correspond to the scores of three steps of the
        intervention, the fourth time it is called to include a global measure
        of time, and the fifth time it is called to include a global score for
        the current word.

        -------------
        parameters
        score1 and score2 will be integers or float numbers that represent
        a score, time, total score, or average.
        """

        self.activeSessionInfo[self.word].append((score1, score2))

        return

    def update_global_measures_for_word(self):
        """Uses calculate_global_measures to calculate global score measures
        and calculate global time measures for the current word and
        uses update_results_for_current_word to include the measures in
        wordInfo.
        """

        totalScore, averageScore = self.calculate_global_measures(0)
        self.update_results_for_current_word(*(totalScore, averageScore))
        totalTime, averageTime = self.calculate_global_measures(1)
        self.update_results_for_current_word(*(totalTime, averageTime))

        return

    def calculate_global_measures(self, x):
        """Calculates and returns the total and average scores for the score
        type indicated by the tuple index x.
        """

        total = sum(
            (
                self.activeSessionInfo[self.word][0][x],
                self.activeSessionInfo[self.word][1][x],
                self.activeSessionInfo[self.word][2][x]
            )
        )

        average = round(total/3, 3)

        return total, average

    def update_global_session_info(self):
        """Updates the info for the whole active session."""

        self.activeSessionInfo["total session score"]["number of words"] = \
            self.wordCount
        self.activeSessionInfo["total session score"]["total score"] = \
            self.calculate_total_score()
        self.activeSessionInfo["total session score"]["correct percentage"] = \
            self.calculate_correct_percentage()
        self.activeSessionInfo["total session score"]["incorrect percentage"] = \
            self.calculate_incorrect_percentage()

    def calculate_total_score(self):
        """Calculates the total score for the session."""

        total = 0
        for word, info in self.activeSessionInfo.items():
            if word == "total session score":
                continue
            else:
                total += info[3][0]

        return total

    def calculate_correct_percentage(self):
        """Calculates and returns the percentage of correctly completed
        tasks.
        """

        totalSessionScore = self.activeSessionInfo["total session score"]\
            ["total score"]

        return ((totalSessionScore/(self.wordCount * 3)) * 100)

    def calculate_incorrect_percentage(self):
        """Calculates and returns the percentage of incorrectly completed
        tasks.
        """

        return 100 - self.activeSessionInfo["total session score"]\
            ["correct percentage"]

    def get_active_session_info(self):
        """Returns the user's data for the session. Used for data storage."""

        return self.activeSessionInfo

    def get_session_number(self):
        """Returns the active session number for the user."""

        return self.allUsersSessionCount[self.username]

    def get_correct_percentage(self):
        """Returns the user's correct percentage for the current session. """

        return self.activeSessionInfo["total session score"]["correct percentage"]

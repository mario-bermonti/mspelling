import iofiles
import os


class DataStorage:
    def __init__(self):
        self.iodata = iofiles.IOData()

    def export_to_csv(self, username, sessionNumber, data):
        """Exports data data to a csv file."""

        self.filename = username
        if sessionNumber < 2:
            self.write_header()
        self.write_data(data, sessionNumber)

        return

    def write_header(self):
        """Writes the user's data header to a csv file."""

        self.write_line_one()
        self.write_line_two()
        self.write_line_three()

        return

    def write_line_one(self):
        """Writes the first line of the user's data header."""

        header = [" ", " ", " ", " ", " "]
        extension = list()

        for i in range(119):
            extension.extend(["word", " ", " ", " ", " ", " ", " ", " ", " ",
                              " ", " "])

        header.extend(extension)
        self.iodata.write_csv_row(
            os.path.join(os.getcwd(), "data", str(self.filename)),
            header
        )

        return

    def write_line_two(self):
        """Writes the second line of the user's data header."""

        header = [" ", " ", " ", " ", " ", " "]
        extension = list()

        for i in range(119):
            extension.extend(["step 1", " ", "step 2", " ", "step 3", " ",
                              "word score", " ", "word time", " ", " "])

        header.extend(extension)

        self.iodata.write_csv_row(
            file=os.path.join(os.getcwd(), "data", str(self.filename)),
            data=header,
            mode="a"
        )

        return

    def write_line_three(self):
        """Writes the third line of the user's data header."""

        header = ["session number", "number of words", "total score",
                  "correct percentage", "incorrect percentage", " "]
        extension = list()

        for i in range(119):
            extension.extend(["score", "time", "score", "time", "score",
                              "time", "total", "average", "total", "average",
                              " "])

        header.extend(extension)

        self.iodata.write_csv_row(
            file=os.path.join(os.getcwd(), "data", str(self.filename)),
            data=header,
            mode="a"
        )

        return

    def write_data(self, data, sessionNumber):
        """Writes the user's session data to a csv file."""

        data = self.prepare_data(data, sessionNumber)
        self.iodata.write_csv_row(
            file=os.path.join(os.getcwd(), "data", str(self.filename)),
            data=data,
            mode="a"
        )

        return

    def prepare_data(self, data, sessionNumber):
        """This method structures the data in a way that's writtable to a
        csv file.
        """

        formatedData = [
            sessionNumber, data["total session score"]["number of words"],
            data["total session score"]["total score"],
            data["total session score"]["correct percentage"],
            data["total session score"]["incorrect percentage"]
        ]

        for word, info in data.items():
            if word == "total session score":
                continue
            else:
                formatedData.append(word)
                for scorePair in info:
                    for item in scorePair:
                        formatedData.append(item)

        return formatedData

#! "C:\Python33\python.exe"
# -*- coding: utf-8 -*-


class IOData():
    """Helps read and write files."""

    def __init__(self):
        self.data = list()
        self.importedAlready = list()

    def read_file_lines(self, file, sep="\n"):
        """Reads the file "file" and stores its content on self.data.
        Uses a for loop to clean up any empty lists that are contained in
        self.data.

        ---------
        Parameters
        ---------
        sep = the separator that is going to be used to split the file into a
        list.
        """

        with open(file) as inFile:
            for line in iter(inFile.readline, ""):
                items = line.split(sep)
                self.data.extend(items)

        # cleans up the lists
        for line in self.data[:]:
            line = line.strip()
            if (len(line)) == 0:
                lineIndex = self.data.index(line)
                del self.data[lineIndex]

    def split_lines(self, sep="\n"):
        """Splits each line in self.data (read from a file) into list of
        str.
        """

        self.data = [line.split(sep) for line in self.data]

    def get_data(self, duplicates="y"):
        """returns the data read from a file with the function
        read_sequence.

        Duplicates = if 'y' (default) the secuence includes duplicates if
        any and is a list. If 'n', the secuence is a set and doesn't not
        include duplicates.
        """

        if duplicates == "n":
            return set(self.data)
        elif duplicates == "y":
            return self.data
        else:
            raise TypeError("Parámetro inválido. Parámetros válidos: 'y', 'n'")

    def write_lines_to_file(self, file, obj, type="a"):
        """Writes the object 'obj' to the file 'file'. If the object is not a
        string, the exception TypeError is raised and obj is transformed
        into a str using the "to_string" method.

        The first line of the file is blank, but when 'read_sequence' reads
        the file it deletes the line.

        ----------
        Parameters
        ----------

        type = indicates how to write the information. The default is 'a'
               which writes it to the end of the file. The options are the
               same as for the built-in method 'write' for file IO.
        """

        try:
            with open(file, type) as outFile:
                obj = [item.strip() for item in obj]
                outFile.write("\n")
                outFile.write("\n".join(obj))

        except TypeError:
            writableSeq = self.to_string(obj)
            with open(file, type) as outFile:
                outFile.write("\n")
                outFile.write("\n".join(writableSeq))

    def to_string(self, obj):
        """Returns a new list containing every element in obj as a str.
        Used when and invalid obj is given to the constructor and it needs
        to be converted to a str before in can be written.
        """

        convertedString = list()
        for item in obj:
            convertedString.append(str(item))

        return (convertedString)

    def write_csv_row(self, file, data, mode="w"):
        """Writes one row to a csv file."""

        import csv

        file = "{}.csv".format(file)

        with open(file=file, mode=mode, newline="") as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(data)

    def write_csv_rows(self, file, data, mode="w"):
        """Writes one row to a csv file."""

        import csv

        file = "{}.csv".format(file)
        with open(file=file, mode=mode, newline="") as csvfile:
            writer = csv.writer(csvfile)
            writer.writerows(data)


if __name__ == "__main__":
    read_write_file = IOData()

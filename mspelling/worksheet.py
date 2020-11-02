import os
import pandas as pd
import numpy as np


class Worksheet(object):
    def __init__(self, filename, randomize=False, **kwargs):
        """
        Parameters
        ----------
        filename (str): Specifies the name of the file with he stimuli
        randomize (bool): Specified whether the stimuli should be randomized.
             It randomizes files with multiple columns (additional data)
             correctly.
        """

        self._worksheet = self.get_worksheet(filename)
        if randomize:
            self._worksheet = self.randomize_stimuli()

    def randomize_stimuli(self):
        randomized_data = self._worksheet.reindex(
            np.random.permutation(
                self._worksheet.index
            )
        )

        return randomized_data

    def get_worksheet(self, filename):
        """
        Reads the stimuli from a file and returns them. 

        Parameters
        ----------
        filename (str): Specifies the path to the file with the stimuli.
             Only supports Excel files currently.

        Returns
        -------
        stim (pandas.DataFrame): stimuli with any additional data
            contained in the stim file.
        """

        return pd.read_excel(filename)

    @property
    def worksheet(self):
        return self._worksheet

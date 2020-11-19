import os
import pandas as pd
import numpy as np


class Worksheet(object):
    def __init__(self, data, randomize=False):
        """Creates the worksheet object.

        Parameters
        ----------
        data : pandas.DataFrame
            Data that will be used to construct the worksheet.

        randomize (bool): Specifies if the data should be randomized.
            It assumes that each row is a piece of data and keeps columns
            together.
        """

        if randomize:
            self._data = self.randomize_stimuli(data)
        else:
            self._data = data

    def randomize_stimuli(self, data):
        """Randomizes the stim and returns a new version.

        Parameters
        ----------
        data : pandas.DataFrame
            Stimuli with any additional data.

        Returns
        -------
        data : pandas.DataFrame
            Stimuli with any additional data.
        """

        new_index = np.random.permutation(data.index)
        randomized_data = data.reindex(new_index)

        return randomized_data

    @property
    def data(self):
        return self._data

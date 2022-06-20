import os

import numpy as np
import pandas as pd


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

        original_index = data.index
        # TODO Check if this is necessary; np.random.permutation creates copy
        new_index = data.index.copy()
        while True:
            new_order = np.random.permutation(new_index)
            new_index = pd.Index(new_order)
            if original_index.equals(new_index):
                new_index = np.random.permutation(new_index)
            else:
                break

        randomized_data = data.reindex(new_index)

        return randomized_data

    @property
    def data(self):
        return self._data

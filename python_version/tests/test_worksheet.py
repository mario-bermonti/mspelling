import pandas as pd

from mspelling.worksheet import Worksheet


class TestWorksheet(object):
    def test_randomize_stimuli(self):
        data = {"word": ["perro", "gato", "cerdo"], "meta_data": [4, 4, 5]}
        stim = pd.DataFrame(data)

        worksheet = Worksheet(stim, randomize=True)
        stim_randomized = worksheet.data

        assert stim.index.equals(stim_randomized.index) is False

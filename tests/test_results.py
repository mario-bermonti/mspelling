import pandas as pd
from mspelling.results import Results

class TestResults(object):
    """Test results object."""

    def test_add_additional_data(self):
        data = {
            "stim": "gato",
            "response": "gato",
            "participant_id": "",
        }

        data_incomplete = {"stim": data["stim"]}
        trial_data_incomplete = pd.Series(data_incomplete)

        results = Results(testing=True)
        trial_data_returned = results.add_additional_data(
            response=data["response"],
            trial_data=trial_data_incomplete
        )

        trial_data_complete = pd.Series(data)

        assert trial_data_complete.equals(trial_data_returned)

    def test_organize_trial_data_index(self):
        data = {"word": "gato", "other_data": 5}
        trial_data = pd.Series(data)
        trial_data_index_expected = pd.Index(
            ["participant_id", "word", "response", "other_data"]
        )

        results = Results(testing=True)
        trial_data_index_returned = results.organize_trial_data_index(trial_data)
        print(trial_data_index_returned)

        assert trial_data_index_expected.equals(trial_data_index_returned)

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



from kivy.app import App
import pandas as pd

class Results(object):
    """Manages, stores and saves results from the session."""

    def __init__(self):
       self._results = [] 

    def update_results(self, response, trial_data):
        """Calls all the functions that format and store results.

        Parameters
        ----------
        response: str
            User's response
        data: pandas.Series
            Data included in the stimuli file by the user. It includes
            the stimuli.
        """

        results_trial = self.format_trial_results(
            response,
            trial_data
        )
        self._results.append(results_trial)

    def format_trial_results(self, response, trial_data):
        """Formats the results of the current trial. This is important
        to be able to handle arbitrary data provided with the stimuli.

        Note
        ----
        Makes a copy of the trial_data (pandas.Series)

        Parameters
        ----------
        response: str
            User's response
        trial_data: pandas.Series
            Data included in the stimuli file by the user. It includes
            the stimuli.

        Returns
        _______
        pandas.Series
            Formatted trial results and arbitrary which includes arbitrary data.
        """

        trial_data_extended = self.add_additional_data(response, trial_data)
        trial_data_order = self.organize_trial_data_index(trial_data)
        trial_data_formatted = trial_data_extended[trial_data_order]

        return trial_data_formatted

    def add_additional_data(self, response, trial_data):
        """Adds additional data to the trial's data.

        Note
        ----
        Makes a copy of the trial_data (pandas.Series)

        Parameters
        ----------
        trial_data: pandas.Series
            Data included in the stimuli file by the user. It includes
            the stimuli. 

        Returns
        -------
        pandas.Series
            trial data with additional data from the session.
        """

        trial_data_extended = trial_data.copy()
        trial_data_extended["response"] = response

        app = App.get_running_app()
        participant_id = app.root.participant_id
        trial_data_extended["participant_id"] = participant_id

        return trial_data_extended

    def organize_trial_data_index(self, trial_data):
        """Determine the order of the trial_data.

        Note
        ----
        Makes a copy of the trial_data (pandas.Series)

        Parameters
        ----------
        trial_data: pandas.Series
            Data included in the stimuli file by the user. It includes
            the stimuli. 

        Returns
        _______
        pandas.Index
            Index specifying the order of the trial's data.
        """

        trial_data = trial_data.copy() # don't modify original data
        other_data = trial_data.drop(labels="word")

        index_other_data = other_data.index
        index_main_data = pd.Index(["participant_id", "word", "response"])

        index_trial = index_main_data.append(index_other_data)

        return index_trial

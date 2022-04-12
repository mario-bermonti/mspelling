import datetime
from pathlib import Path

import pandas as pd
from kivy.app import App

PATH_CWD = Path().cwd()


class Results(object):
    """Manages, stores and saves results from the session."""

    def __init__(self):
        self.app = App.get_running_app()
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

        results_trial = self.format_trial_results(response, trial_data)
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

    def add_additional_data(self, response, trial_data, testing=False):
        """Adds additional data to the trial's data.

        Note
        ----
        Makes a copy of the trial_data (pandas.Series)

        Parameters
        ----------
        response : str
            User's response for the current trial.

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

        participant_id = self.get_participant_id(testing)
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

        trial_data = trial_data.copy()  # don't modify original data
        other_data = trial_data.drop(labels="word")

        index_other_data = other_data.index
        index_main_data = pd.Index(["participant_id", "word", "response"])

        index_trial = index_main_data.append(index_other_data)

        return index_trial

    def save_results(self):
        """Save the participant's results to a file."""

        results = self.format_results_data()
        self.save_results_file(results)

    def format_results_data(self):
        """Formats the results to a better format.

        Parameters
        ----------

        Returns
        -------
        pandas.DataFrame
            Formatted results
        """

        results_formatted = pd.DataFrame(self._results)

        return results_formatted

    def save_results_file(self, results, testing=False):
        """Save results to file, creating the dir if it doesn't exist.

        Parameters
        ----------
        results: pandas.DataFrame
            Participant's results for the session
        """

        date = datetime.datetime.now().strftime("%Y-%m-%d-h%H-m%M")

        participant_id = self.get_participant_id(testing)

        path_results = PATH_CWD / "results" / f"results_p{participant_id}_{date}.csv"

        self.create_results_dir_if_necessary()
        results.to_csv(path_results, index=False)

    def create_results_dir_if_necessary(self):
        """Creates the dir where the results will be saved in if it
        doesn't already exist.
        """

        path_results = PATH_CWD / "results"
        if not path_results.exists():
            path_results.mkdir()

    def get_participant_id(self, testing=False):
        """Get participant id.

        Parameters
        ----------
        testing : bool
            Flags whether this is a real session or just running tests.

        Returns
        -------
        str
            participant's id
        """

        # todo: improve how to handle this when running tests
        if testing:
            participant_id = ""
        else:
            app = App.get_running_app()
            participant_id = app.participant_id

        return participant_id

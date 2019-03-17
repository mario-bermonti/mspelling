import pyaudio
import wave
import time
import threading
import os


class Audio:
    """Plays and records audio. end_all() has to be call at the end of the
    session to terminate pyaudio.
    """

    def __init__(self, name, sessionNumber):
        self.name = str(name)
        self.sessionNumber = str(sessionNumber)
        self.numberOfRecordings = 0
        self.pyAudio = pyaudio.PyAudio()
        self.playingAudio = False

    def play_audio(self, file):
        """Plays an audio file to the user."""

        self.playingAudio = True
        self.prepare_audio_playing(file)
        self.stream.start_stream()

        while self.stream.is_active():
            time.sleep(0.1)

        self.clean_up()

        return

    def prepare_audio_playing(self, file):
        """Opens the audio file and audio stream."""

        self.playAudio = wave.open(
            os.path.join(os.getcwd(),
                         "stimuli",
                         "audio",
                         "{}.wav".format(file)),
            'rb'
            )

        self.stream = self.pyAudio.open(
            format=self.pyAudio.get_format_from_width(
                self.playAudio.getsampwidth()),
            channels=self.playAudio.getnchannels(),
            rate=self.playAudio.getframerate(),
            output=True,
            stream_callback=self.start_playing
        )

        return

    def clean_up(self):
        """Closes the audio stream."""

        self.stream.stop_stream()
        self.stream.close()
        #if self.playingAudio:
            #self.playAudio.close()

        return

    def start_playing(self, in_data, frame_count, time_info, status):
        """Reads the audio frame so they can be played."""

        data = self.playAudio.readframes(frame_count)

        return (data, pyaudio.paContinue)

    def record_audio(self, file):
        """Records audio from the user while he presses a button."""

        self.file = file
        self.isRecording = True
        self.start_recording()

        return

    def get_recording_attributes_ready(self):
        """Defines basic attributes needes to record audio and pens the audio
        stream. Binds the press of the button to the function that records
        the audio.
        """

        self.chunk = 1024
        self._format = pyaudio.paInt16
        self.channels = 1
        self.rate = 44100
        self.outStream = self.pyAudio.open(
            format=self._format,
            channels=self.channels,
            rate=self.rate,
            input=True,
            frames_per_buffer=self.chunk
        )

        return

    def start_recording(self):
        """Saves the audio provided by the user into memory."""

        print("* Recording")
        self.frames = []
        while self.isRecording:
            data = self.outStream.read(self.chunk, exception_on_overflow=False)
            self.frames.append(data)
        #self.outStream.write(b''.join(self.frames))

        return

    def stop_recording(self, event):
        """Stops the recording. It's called when the users stops pressing
        the button.
        """

        self.isRecording = False
        self.save_recording(self.file)

        return

    def save_recording(self, file):
        """Saves the recording to disk."""

        self.numberOfRecordings += 1
        savePath = os.path.join(
            os.getcwd(),
            "data",
            "audio",
            self.name,
            self.sessionNumber
        )
        if not os.path.exists(savePath):
            os.makedirs(savePath)

        recordedAudio = wave.open(
            os.path.join(
                savePath,
                "{}_{}.wav".format(file, self.numberOfRecordings)),
            "wb")

        recordedAudio.setnchannels(self.channels)
        recordedAudio.setsampwidth(self.pyAudio.get_sample_size(self._format))
        recordedAudio.setframerate(self.rate)
        recordedAudio.writeframes(b''.join(self.frames))
        recordedAudio.close()

    def end_all(self):
        """Terminates pyaudio. It has to be called at the end so it can
        continually play or record audio."""

        self.pyAudio.terminate()

        return

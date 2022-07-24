import os
import re
import time

from multiprocessing import Process
from dota2_adapter.bot.__bot import Bot
from dota2_adapter.parser.__parser import Parser
from dota2_adapter.sender.__sender import Sender


class Dota2Adapter:
    def __init__(self,
                 dota2_path: str,
                 parser: Parser,
                 bot: Bot,
                 sender: Sender):
        self._dota2_path = dota2_path
        self._logfile = os.path.join(dota2_path, 'console.log')
        self._parser = parser
        self._bot = bot
        self.__process = None
        self._sender = sender

    @staticmethod
    def __follow(file):
        """generator function that yields new lines in a file
        """
        # seek the end of the file
        file.seek(0, os.SEEK_END)

        # start infinite loop
        while True:
            # read last line of file
            try:
                line = file.readline()
                # sleep if file hasn't been updated
                if not line:
                    time.sleep(0.1)
                    continue
                yield line
            except:
                pass

    def entry_point(self):
        logfile = open(self._logfile, "r")
        log_lines = self.__follow(logfile)
        # iterate over the generator
        for line in log_lines:
            self.__logfile_handler(line)
            self.__line_handler(line)

    def __line_handler(self, line):
        state = self._parser.parse(line)
        if state is not None:
            command = self._bot.handler(state)
            self._sender.send_command(command)

    def deactivate(self):
        self.__process.close()
        self.__process = None

    def activate(self):
        if self.__process is not None:
            self.deactivate()

        self.__process = Process(target=self.entry_point)
        self.__process.start()

    def __logfile_handler(self, line):
        res = re.findall(r"\[EngineServiceManager] Tearing off console log, will continue using suffix '.?\d*'", line)
        if len(res) != 0:
            suffix = re.findall(r"'.?\d*'", res[0])[0].replace("'", '')
            time.sleep(1)
            self._logfile = os.path.join(self._dota2_path, f'console{suffix}.log')
            self.activate()

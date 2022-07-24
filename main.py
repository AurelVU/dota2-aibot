from dota2_adapter import Dota2Adapter
import time

from dota2_adapter.bot.__bot import Bot
from dota2_adapter.mapper.__command_mapper import CommandMapper
from dota2_adapter.parser.__parser import Parser
from dota2_adapter.sender.__sender import Sender


if __name__ == '__main__':
    adapter = Dota2Adapter(
        dota2_path=r'D:\SteamLibrary\steamapps\common\dota 2 beta\game\dota',
        bot=Bot(),
        parser=Parser(),
        sender=Sender(
            command_mapper=CommandMapper()
        )
    )

    adapter.activate()
    while True:
        time.sleep(0.1)

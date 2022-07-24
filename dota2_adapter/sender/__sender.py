from dota2_adapter.mapper.__command_mapper import CommandMapper


class Sender:
    def __init__(self, command_mapper: CommandMapper):
        self.command_mapper = command_mapper

    def send_command(self, command):
        str_command = self.command_mapper.map_command(command)
        print(f'Mapper::command {str_command}')

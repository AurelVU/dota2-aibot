import re


class Parser:
    def parse(self, line):
        result = ''
        if '[VScript]' in line:
            result = line[25:]
        if len(result) != 0:
            return result
        else:
            return None

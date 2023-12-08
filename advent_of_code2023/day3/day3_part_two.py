#
# TODO
# - create 
#

class SchematicAnalyzer:

    def __init__(self) -> None:
        self.schematic = []
        self._valid_parts = []
        self._valid_parts_to_string = ''
        self._schematic_len_y = None
        self._schematic_len_x = None
        self._sum_of_parts = 0
        self._answer = 553825
    
    def load_schematic(self, file):
        """ Open file and read contents to schematic variable in 2D array
        """
        with open(file) as f:
            for line in f.read().splitlines():
                self.schematic.append(list(line))

        self._schematic_len_y = len(self.schematic) - 1
        self._schematic_len_x = len(self.schematic[0]) - 1

    def print_schematic(self) -> str:
        """ Display schematic in pretty view
        """
        for x in self.schematic: print(x)

    def _get_schematic(self, cordinates: set):
        """ Verify Y,X cordinates are withing index range of schematic, and padd borders with '.'
        """
        row, column = cordinates
        if (row >= 0 and row <= self._schematic_len_x) and (column >= 0 and column <= self._schematic_len_y):
            return self.schematic[row][column]
        else:
            return '.'

    def _is_part(self, char: str) -> bool:
        """ Return char asd
        """
        digits = '0123456789'
        return char in digits and len(char) != 0

    def _is_symbol(self, char: str) -> bool:
        """ Return bool if char is symbol
        """
        sym = '0123456789.'
        #print('symbol: {}'.format(char))
        return char not in sym and  len(char) != 0

    def _is_adjacent(self, cordinates: set) -> bool:
        """ Check cordinate for adjacensies  
        """
        adjacencies = [
            (-1, -1), # Top-left
            (-1, 0),  # Up
            (-1, 1),  # Top-right
            (0, -1),  # Left
            (0, 1),   # Right
            (1, -1),  # Bottom-left
            (1, 0),   # Down
            (1, 1)    # Bottom-right
        ]
        
        verify_char = self._get_schematic(cordinates)
        if not self._is_part(verify_char):
            raise Exception('ERROR: {} is not a part!'.format(verify_char))

        c_y,c_x = cordinates
        for a_y, a_x in adjacencies:
            if self._is_symbol(self._get_schematic((c_y + a_y, c_x + a_x))):
                return True

    def _expand_partnumber(self, cordinates: set) -> list:
        """ Scan cordinates horizontally for full part number 
        """

        y, x = cordinates
        part_cordinates = []
        print(cordinates)
        if not self._is_part(self._get_schematic((y,x))):
            print('method._expand_partnumber: WHAT THE FUCK ARE YOU DOING')
            return

        while self._is_part(self._get_schematic((y,x))): # left-side-search
            part_cordinates.append((y,x))
            x -= 1
            if (x < 0):
                break
        
        x = cordinates[1] + 1

        while self._is_part(self._get_schematic((y,x))): # right-side-search
            part_cordinates.append((y,x))
            x += 1
            if (x >= self._schematic_len_x):
                break
        
        return sorted(part_cordinates)

    def _validate_schematic(self) -> list:
        """ Initiate analysis of schematic and return list of valid parts
        """

        for y in range(self._schematic_len_y + 1):
            for x in range(self._schematic_len_x + 1):

                char = self._get_schematic((y,x))
                if not self._is_part(char):
                    continue

                partnumber = self._expand_partnumber((y,x))
                if str(partnumber) in str(self._valid_parts):
                    continue

                for part in partnumber:

                    adjacent = self._is_adjacent(part)
                    if adjacent:
                        self._valid_parts += [partnumber]
                        break

        return self._valid_parts

    def analyze(self):
        """ Main function of class: performs analysis of valid parts and returns list of partnumbers
        """
        
        valid_parts = self._validate_schematic()
        for partnumbers in valid_parts:
            chars = ''
            for part in partnumbers:
                chars += self._get_schematic(part)
            #print('Valid partnumber: {}'.format(chars))
            #print('chars: {} - {}'.format(chars,int(chars)))
            self._valid_parts_to_string += chars + '\n'
            self._sum_of_parts += int(chars)
        
        self.answer()
        #print('Sum of parts is {}'.format(self._sum_of_parts))

    def answer(self) -> str:
        if self._sum_of_parts == self._answer:
            print('Answer is correct: {}'.format(self._sum_of_parts))
        elif self._sum_of_parts > self._answer:
            print('Sum is too high: {}'.format(self._sum_of_parts))
        elif self._sum_of_parts < self._answer:
            print('Sum is too low: {}'.format(self._sum_of_parts))

    def _debug_part(self, cordinates: set):
        """ Debug function: run analysis for a single part
        """
        char = self._get_schematic(cordinates)
        if not self._is_part(char):
            print('char: {}, cords: {}, _is_part: {}'.format(char, cordinates, self._is_part(char)))
            return

        print('\n_get_schematic: {}'.format(char))
        print('_cordinates: {}'.format(cordinates))
        print('_is_part: {0}'.format(self._is_part(char)))
        partnumber = self._expand_partnumber(cordinates)
        number = ''
        for p in partnumber:
            number += self._get_schematic(p)

        print('_expand_partnumber: {}'.format(partnumber))
        #print('number: {}'.format(number))
        for part in partnumber:
            char_part = self._get_schematic(part)
            adjacent = self._is_adjacent(part)
            if adjacent:
                not_adjacent = False
                print('_is_adjacent ({}): {}\n'.format(char_part,adjacent))
                print('Number is valid: {}\n'.format([number]))
                self._valid_parts += [partnumber]
                break
        if not adjacent:
            print('DEBUG !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!: _is_adjacent ({}): {}\n'.format(part,adjacent))


def main():
    import os, sys; os.chdir(sys.path[0])

    file = 'files/puzzle1.txt'
    analyzer = SchematicAnalyzer()
    analyzer.load_schematic(file)
    #analyzer.analyze()


    #d_y = 12 ; for d_x in range(analyzer._schematic_len_x+1): analyzer._debug_part((d_y,d_x))
    d_cord = (12,49) # 143 missing
    #d_cord = (23,138) # 25 / 258

    #analyzer._debug_part(d_cord)
    c = analyzer._get_schematic(d_cord)
    print(c)
    expand = analyzer._expand_partnumber(d_cord)
    print(expand)


    #with open('debug_file_two.txt' ,'w') as f:
        #f.write(analyzer._valid_parts_to_string)


if __name__ == "__main__":
    main()

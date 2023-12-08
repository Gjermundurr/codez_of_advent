#
# TODO
# - create 
#

class SchematicAnalyzer:

    def __init__(self) -> None:
        self.schematic = []
        self._valid_parts = []
        self._schematic_len_y = None
        self._schematic_len_x = None
    
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

    def _get_schematic(self, row, column):
        return self.schematic[row][column]

    def _is_part(self, char) -> bool:
        """ Return char asd
        """
        return char.isdigit() == True


    def _is_symbol(self, char):
        """ Return bool if char is symbol or part
        """
        return not char != '.' or not char.isdigit()
    

    def _check_adjacencies(self, cordinates: set):
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
        
        c_y,c_x = cordinates
        for a_y, a_x in adjacencies:
            if self._is_symbol(self.schematic[c_y + a_y][c_x + a_x]):
                return True



    def _expand_partnumber(self, cordinates: set):
        """ Scan cordinates horizontally for full part number 
        """
        print('method _expand_part_cordinates: {}'.format(cordinates))
        y = cordinates[0]
        x = cordinates[1]
        part_cordinates = []

        while self._is_part(self.schematic[y][x]): # left-side-search
            part_cordinates.append((y,x))
            x -= 1
            if (x <= 0):
                break
        
        x = cordinates[1] + 1

        while self._is_part(self.schematic[y][x]): # right-side-search
            part_cordinates.append((y,x))
            x += 1
            if (x >= self._schematic_len_x):
                break
        
        return part_cordinates


    def run(self):
        """ Initiate analysis of schematic and find all legitimate part numbers
        """

        for y in range(self._schematic_len_y):
            for x in range(self._schematic_len_x):
                #print(self.schematic[y][x])

                char = self.schematic[y][x]

                if self._is_part(char):
                    partnumber = self._expand_partnumber(cordinates=(y,x))
                    for part in partnumber:
                        print(part)
                        adjacent_result = self._check_adjacencies(cordinates=part)
                        print('result adjacencies: {}'.format(adjacent_result))
                


def main():
    file = 'C:\\Git_repo\\test-project\\AOC2023\\day3\\files\\sample1.txt'
    analyzer = SchematicAnalyzer()
    analyzer.load_schematic(file)
    #analyzer.print_schematic()
    #analyzer.run()

    print(analyzer._get_schematic(0,11))

if __name__ == "__main__":
    main()

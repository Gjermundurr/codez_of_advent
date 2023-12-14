
class LotterBot:

    def __init__(self) -> None:
        pass
        self._tickets = []

    def load_file(self, file):
        # load filecontents into variable
        with open(file) as f:
            for ln in f.read().splitlines():

                card_ln = ln.split(':')[0].split(' ')
                wins_ln, nums_ln = ln.split(':')[1].split('|')

                card_nr =   [c for c in card_ln if c != ''][1]
                nums    =   [n for n in nums_ln.split(' ') if n != '']
                wins    =   [w for w in wins_ln.split( ' ') if w != '']

                ticket_dict = {
                    'card': card_nr,
                    'nums': nums,
                    'wins': wins,
                    'count': 0
                }
                self._tickets += [ticket_dict]

    def print_tickets(self):
        # Print tickets array to terminal
        for tkt in self._tickets:
            print(tkt)
    
    def analyze_ticket_copies(self):

        for t_i in range(len(self._tickets)): # ticket_index
            ticket = self._tickets[t_i]
            print('Current ticket: {}'.format(self._tickets[t_i]))

            cp_range = range(len([n for n in ticket['nums'] if n in ticket['wins']]))
            print(cp_range)
            for c in cp_range:
                self._tickets[t_i + c]['count'] += 1



def main():
    #print('hello world!')
    import os, sys; os.chdir(sys.path[0])

    filepath = 'files/sample.txt'
    lotter = LotterBot()
    lotter.load_file(filepath)
    #lotter.print_tickets()
    #ticks = lotter._tickets
    #print(ticks[0])
    lotter.analyze_ticket_copies()






if __name__ == "__main__":
    main()
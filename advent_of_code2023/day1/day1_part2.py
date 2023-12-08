

filepath = 'C:\\Git_repos\\test-projects\\AOC23\\day1\\puzzle\\part2.txt'
map = {'zero': 0,'one': 1,'two': 2,'three': 3,'four': 4,'five': 5,'six': 6,'seven': 7,'eight': 8,'nine': 9}
verbals = ['zero','one','two','three','four','five','six','seven','eight','nine']
numerals = [n for n in range(0,10)]
sum = 0
ln_nr = 0

# Read file contents to variable
with open(filepath, 'r') as file:
    lines = file.read().splitlines()

#lines = ['6qsmcvfoursmlsevensix4lkpxxcnk']

for ln in lines:

    print('Line {}: {}'.format(ln_nr, ln)) # Debug print
    ln_nr += 1    
    ln_dict = {}
    ln_arr = []

    for verb in verbals:
        # Find all verbals with index position and add to ln_dict
        fi = 0 # find-index
        index = 0 # 
        while index != -1 and index <= ln.__len__() - 1:
            index = ln.find(verb, fi)

            if index != -1:
                #print(verb)
                ln_dict[index] = map[verb]
                fi = index + 1 

    for n in numerals:
        # Find numerals with index position and add to ln_dict
        fi = 0
        index = 0
        while index != -1 and index <= ln.__len__() - 1:
            index = ln.find(str(n), fi)
            
            if index != -1:
                ln_dict[index] = str(n)
                fi = index + 1 

    #print('dict: {}'.format(ln_dict))
    keys = sorted(list(ln_dict.keys()))       # sort dict based on index value 
    ln_arr = ([ln_dict[k] for k in keys])   # create array with sorted dict values
    line_sum = str(ln_arr[0]) + str(ln_arr[-1])
    sum += int((str(ln_arr[0]) + str(ln_arr[-1]))) # add first and last digit to sum

    print('Line {}: {} - {}'.format(ln_nr,line_sum, ln_arr)) # Debug print


print('Answer: {}'.format(sum))


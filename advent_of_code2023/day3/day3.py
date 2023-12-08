import re

schematic = []
dummy_list = []
shit_list = []
rindex = 0 # row index
parts_sum = 0
parts_list = []
re_num = r'\d{1,}'
re_sym = r'[^\d\.\n]'

# create 2D map of schematic
with open('C:\\Git_repo\\test-project\\AOC2023\\day3\\files\\sample1.txt') as f:
    file = f.read().splitlines()

# create list with strings
for ln in file:
    schematic.append(ln)

y_start = 0
y_end = 1
y_count = 0
for y_ln in schematic:

    parts = re.findall(re_num, y_ln)

    if y_count > 1:
        y_start += 1

    if y_count < len(schematic) - 1:
        y_end += 1
    
    for part in parts:

        x_start = y_ln.find(part)
        x_end = x_start + len(part)

        if x_start > 0:
            x_start -= 1 

        if x_end < len(y_ln):
            x_end += 1
        
        # begin looping schema
        search_ln = ''
        for y in range(y_start, y_end):
            search_ln += schematic[y][x_start:x_end]
        
        
        part_sym = re.findall(re_sym, search_ln)
        if part_sym != dummy_list:
            print('{} - Part: {} - REGISTERED\n'.format(search_ln, part))
            parts_sum += int(part)
            parts_list.append(int(part))
        else:
            print('{} - Part: {} - NONE\n'.format(search_ln, part))
        
    y_count +=1       
        

print('Answer: {}'.format(parts_sum)) # woop de fuckin doo
# max answer:  614 994
# prob answer: 554 197
# real answer: 553 825






        


# Dice bag loadout: 12 red cubes, 13 green cubes, and 14 blue cubes.
loadout = {}
loadout['red'] = 12
loadout['green'] = 13
loadout['blue'] = 14

# variables
play_table = []

with open('C:\\Git_repos\\test-projects\\AOC23\\day2\\files\\puzzle1.txt', 'r') as f:
    file = f.read().splitlines()

for ln in file:

    game = {}
    game['play'] = 'ok'
    game['round'] = ln.split(': ')[0].split(' ')[1] # fetch round number

    for dicepull in ln.split(': ')[1].split('; '):  # split into sets
        for set in dicepull.split(', '):            # split set into dice count and color

            count = int(set.split(' ')[0]) # dice count
            color = set.split(' ')[1].strip(',') # dice color
            color_min = color + '_min'
            
            if count > loadout[color]:
                game['play'] = 'fail'
            
            if color not in game.keys():
                # Create key if not found
                game[color] = 0
                game[color_min] = count
            
            if count > game[color_min]:
                game[color_min] = count

            game[color] += count
    
    # Extract min keys and calculate power of colors
    min_keys = [k for k in list(game) if k.endswith('_min')]
    game['power'] = 1
    for min in min_keys:
        game['power'] *= game[min]

    play_table += [game] # add game to summary table


#for d in play_table: print(d) # Debug print

# sum game round to find answer
answer_one = [int(g['round']) for g in play_table if g['play'] == 'ok']
answer_two = [p['power'] for p in play_table]

print('Answer part one: {}'.format(sum(answer_one)))
print('Answer part two: {}'.format(sum(answer_two)))
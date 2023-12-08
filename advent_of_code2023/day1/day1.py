
filename = 'C:\\Git_repos\\test-projects\\AOC23\\puzzle\\day1.txt'

with open(filename, 'r') as f:
    contents = f.read()


ln = 1
res = ''
arr = []
sum = 0
calibration = ''

for c in contents:
    

    #print(' ')
    #print('char: {}'.format(c))
    if not c.isalnum() or c == '\n':

        if (res.__len__() < 2):
            calibration = res + res
        else:
            calibration += res[0]
            calibration += res[-1]

        sum += int(calibration)

        print('Linez {}: {}'.format(ln,calibration))
        res = ''
        calibration = ''
        ln += 1
        #print('--- END ---')

    elif c.isdecimal():
        #print('decimal: {}'.format(c))
        res += c
    #else:
        #print('not dec: {}'.format(c))

# calibrate last line
if (res.__len__() < 2):
    calibration = res + res
else:
    calibration += res[0]
    calibration += res[-1]

sum += int(calibration)
print('Linez {}: {}'.format(ln,calibration))

 
print('Answer: {}'.format(sum))
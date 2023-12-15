import os,sys ; os.chdir(sys.path[0])

class FertilizerConverter:
    import json
    def __init__(self) -> None:
        self._seeds = []
        self._seeds_extended = []
        self._maps = []
        
    def load_file_converter(self, file) -> None:
        with open(file) as f:
            #file_maps = [ln.replace(f'\n', ' ') for ln in f.read().split('\n\n')]
            file_maps = f.read().split('\n\n')
            self._seeds = [int(seed) for seed in file_maps[0].split(':')[1].split(' ') if seed != '']
            file_maps.pop(0)

            #print(file_maps[0])

            for map in file_maps:

                map_dict = {}
                map_name, map_strings = map.split(':')
                map_dict['name'] = map_name.split(' ')[0]
                src_to_dst_list = [num for num in map_strings.split('\n') if num != '']
                map_dict['map'] = []

                #print(f'map_strings: {map_strings}')

                for values in src_to_dst_list:
                    
                    dst_start, src_start, range_len = [int(n) for n in values.split(' ')]
                    map_dict['map'] += [[src_start, dst_start, range_len]]
                
                self._maps += [map_dict]
                
        #print(self._maps)
    
    def _convert_seeds_extended(self) -> None:
        #self._seeds
        #seeds = [79, 14, 55, 13, 44, 21, 12, 4, 1, 6]
        for x in range(0,len(self._seeds),2):
            seed_pair = []
            for s in range(x, x+2):
                seed_pair += [self._seeds[s]]
            
            self._seeds_extended += [seed_pair]


    def _convert_value_to_map(self, value: int, map: dict) -> int:
        
        #print(map)
        for map_list in map['map']:
            src, dst, range_len = map_list
            src_range = range(src, src + range_len)
            
            if value in src_range:
                src_index = src_range.index(value)
                dst_range = range(dst, dst + range_len)
                return dst_range[src_index]
        
        return value

    def convert_seeds_to_location(self) -> list:
        print('seeds: {}'.format(self._seeds))
        seed_results = []
        #self._seeds = [79]
        for seed in self._seeds:
            #print('selecting seed: {}'.format(seed))
            seed_string = ''
            seed_converted = seed
            seed_string += '{}: {}'.format('seed', seed_converted)
            for map_dict in self._maps:
                seed_converted = self._convert_value_to_map(seed_converted, map_dict)
                seed_string += ', {}: {}'.format(map_dict['name'].split('-')[2], seed_converted)
            print(seed_string)
            seed_results += [seed_converted]
        return seed_results
    
    def convert_seeds_extented_to_location(self):
        self._convert_seeds_extended()
        seed_results = []
        for seed_nr, seed_range in self._seeds_extended:
            print('current seed pair: {}, {}'.format(seed_nr, seed_range))
            
            seed_range = range(seed_nr, seed_nr + seed_range)
            for seed in seed_range:
                
                seed_string = ''
                seed_converted = seed
                seed_string += '{}: {}'.format('seed', seed_converted)
                for map_dict in self._maps:
                    seed_converted = self._convert_value_to_map(seed_converted, map_dict)
                    seed_string += ', {}: {}'.format(map_dict['name'].split('-')[2], seed_converted)
                #print(seed_string)
                seed_results += [seed_converted]
        return seed_results

    
    def print_maps(self) -> None:
        for map_dict in self._maps:
            print('\nConversion: {}'.format(map_dict['name']))
            print('src: {}'.format(map_dict['src']))
            print('dst: {}'.format(map_dict['dst']))


def main():
    import os,sys ; os.chdir(sys.path[0])

    file = 'files/puzzle.txt'
    fertilizer = FertilizerConverter()

    fertilizer.load_file_converter(file)
    res = fertilizer.convert_seeds_extented_to_location()

    print('resulting location: {}'.format(sorted(res)))

if __name__ == "__main__":
    main()
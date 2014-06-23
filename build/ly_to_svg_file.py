#!/usr/bin/env python

from ly_to_svg import ly_to_svg
from sys import argv

if __name__ == '__main__':
    if (len(argv) == 3):
    	return_value = ly_to_svg(argv[1], argv[2])
    	if (return_value):
    		exit(0)
    	else:
    		exit(1)
    else:
        print('Invalid number of arguments!')
        exit(1)
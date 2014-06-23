#!/usr/bin/env python

"""
This script converts LilyPond script to a tightly-cropped .svg file.
Created by Alexei Baboulevitch.
"""

# TODO: multiple pages?
# TODO: paper height and width
# TODO: extra files
# TODO: move to ruby?
# TODO: spaces in filenames

from subprocess import Popen, PIPE, STDOUT
from os import getcwd
import abutil_june_2014 as abutil

lilypond_path = 'build/LilyPond.app/Contents/Resources/bin/lilypond'
inkscape_path = 'build/Inkscape.app/Contents/Resources/script'

ly_pagesize = '#(set-global-staff-size 30)'

# removes the default footer
ly_header = '\header {\n tagline = ""  % removed \n}'

def ly_to_svg(ly_string, output_path):
    abutil.message('starting conversion')

    ly_string = ly_pagesize + '\n' + ly_header + '\n' + ly_string

    abutil.message('calling lilypond')

    p = Popen([lilypond_path, '-dbackend=svg', '-dresolution=300', '--output=' + output_path, '-'], stdout=PIPE, stdin=PIPE, stderr=STDOUT)
    output = p.communicate(input = ly_string + '\n')[0]
    print(output)

    abutil.message('calling inkscape')

    output_filename = output_path + '.svg'

    if not abutil.file_exists(output_filename):
        abutil.error('svg not found')
        return False

    absolute_inkscape_filename = '%s/%s' % (getcwd(), inkscape_path)
    absolute_output_filename = '%s/%s' % (getcwd(), output_filename)

    p = Popen([absolute_inkscape_filename, '--verb=FitCanvasToDrawing', '--verb=FileSave', '--verb=FileClose', absolute_output_filename])
    output = p.communicate()[0]
    print(output)

    abutil.message('conversion complete')

    return True

#!/usr/bin/env python
#-*- coding: utf-8 -*- 

import os
import glob

# svg2ttf v0.3
# Copyleft 2014 Christoph Haag 
#
# BASED ON:
# svg2ttf v0.1
# Copyleft 2008-2009 Ricardo Lafuente

# generate a .ttf file from a set of .svg files
#
# before running this script, create a blank font file in Fontforge
# (make a New font and save it as it is) and change the BLANK_FONT location
#
# you might also want to edit the metadata (title, license, etc.) before
# saving it, or just edit the blank.sfd file afterwards
#
# finally, change the LETTERS_DIR value to the folder where your .svg
# files are; they ought to be named according to their unicode value

LETTERS_DIR = "./tmp"
BLANK_FONT = "./i/utils/blank.sfd"

letters = glob.glob(os.path.join(LETTERS_DIR, "*.svg"))

# right-o, here we go
import fontforge

# open a blank font template
# TODO: dynamically generate the space character
font = fontforge.open(BLANK_FONT)


for letter in letters:
	outlines = os.path.basename(letter)
	code = "\u" + os.path.splitext(outlines)[0]
#	print(code)
#	print(code.decode('unicode-escape'))
#	print(ord(code.decode('unicode-escape')))
        char = ord(code.decode('unicode-escape'))

# make new glyph
#	font.createMappedChar(letter)
	font.createChar(char)
# import outline file
# notice that font[glyphname] returns the appropriate glyph
# fontforge is awesome :o)
#	font[letter].importOutlines(LETTERS_DIR + "/" + letter + ".svg")
	font[char].importOutlines(LETTERS_DIR + "/" + outlines )
# same spacing for each letter, this is a hack after all
	font[char].left_side_bearing = 45
	font[char].right_side_bearing = 45
# generate TrueType hints
#	font[letter].autoInstr()


# create the output truetype file
font.generate("output.ttf")
##


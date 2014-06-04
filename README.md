Basic setup to create a font on inkscape layers
and render a truetype from there.

HOWTO:
------

- run ./make_template.sh
  This will create template svg
  with guide and work layers
- edit your characters in the template fil
- run ./make_font.sh path/to/input.svg
  to create a truetype font


- uses Fira Sans as Reference
  http://mozilla.github.io/Fira/  

DEPENDENCIES:
-------------

- Fira Sans

- recode
- python-fontforge
- ...

KNOWN ISSUES:
-------------

- Accents in description if french
- VSHIFT wrong
- ignoring sodipodi elements (guide/visibility)

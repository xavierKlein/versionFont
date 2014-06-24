#!/bin/bash

  VSHIFT=22.9

  OSVG=i/svg/dummy.svg
  FONTFAMILY="Fira Sans"
  LETTERLIST=i/letter.list

  ANSWER=y

  if [ -f $OSVG ]; then
       echo "$OSVG does exist"
       read -p "overwrite ${OSVG}? [y/n]" ANSWER
  fi

if [ $ANSWER = y ] ; then

  if [ -f $OSVG ]; then rm $OSVG ; fi
# --------------------------------------------------------------------------- # 
  e() { echo $1 >> ${OSVG}; }

     e '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
     e '<svg width="1000" height="1000" id="svg" version="1.1"'
     e 'xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"'
     e 'xmlns:dc="http://purl.org/dc/elements/1.1/"'
     e 'xmlns:cc="http://creativecommons.org/ns#"'
     e 'xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"'
     e 'xmlns:svg="http://www.w3.org/2000/svg"'
     e 'xmlns="http://www.w3.org/2000/svg"'
     e 'xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"'
     e 'inkscape:version="0.48.3.1 r9886"'
     e 'sodipodi:docname="dummy.svg"'
     e '>'
     e '<sodipodi:namedview>'
     e '<sodipodi:guide position="0,215" orientation="0,1000" id="descent" />'
     e '</sodipodi:namedview>'

# --------------------------------------------------------------------------- # 
  for CHARACTER in `cat $LETTERLIST | \
                    head -n 158 | \
                    grep -v "^$" | \
                    sed 's/ /adw32DJSu/g'`
   do

       CHARACTER=`echo $CHARACTER | sed 's/adw32DJSu/ /g' | cut -d " " -f 2`
       ORIGINAL=`echo $CHARACTER | sed 's/adw32DJSu/ /g' | recode HTML..utf-8`
 
       INFO=`echo $CHARACTER | \
              recode HTML..dump-with-names | \
              tail -2 | \
              head -1`
  
        UNICODE=`echo $INFO | cut -d " " -f 1`
        DESCRIPTION=`echo $INFO | \
                     cut -d " " -f 3- | \
                     unaccent utf-8`

        LAYER=$UNICODE
      # GUIDE="XX_$UNICODE ($ORIGINAL = $DESCRIPTION)"
        GUIDE="XX_$UNICODE ($DESCRIPTION)"

      # ATTRIBUTES FOR GUIDE LAYER
        LABEL=$GUIDE
        ID=XX_$UNICODE
        LOCK="sodipodi:insensitive=\"true\""
        FILL="#ff0000"
        OPACITY="0.5"
        DISPLAY="display:none"

     for PAIR in 1 2
      do

     e "<g inkscape:label=\"$LABEL\" inkscape:groupmode=\"layer\"" 
     e " $LOCK id=\"$ID\" style=\"$DISPLAY\" transform=\"translate(0,$VSHIFT)\" >"
     e '<flowRoot xml:space="preserve" id="flowRoot"'

     e "style=\"font-size:900px;\
                font-style:normal;\
                font-variant:normal;\
                font-weight:normal;\
                font-stretch:normal;\
                text-align:center;\
                line-height:125%;\
                letter-spacing:0px;\
                word-spacing:0px;\
                writing-mode:lr-tb;\
                text-anchor:middle;\
                fill:$FILL;\
                fill-opacity:$OPACITY;\
                stroke:none;\
                font-family:$FONTFAMILY;\
               -inkscape-font-specification:$FONTFAMILY\""
     e '><flowRegion id="flowRegion">'
   # e "<rect id=\"rect$UNICODE\" width=\"1000\" height=\"1200\" x=\"0\" y=\"$VSHIFT\" />"
     e "<rect id=\"rect$UNICODE\" width=\"1000\" height=\"1200\" x=\"0\" y=\"0\" />"
     e "</flowRegion><flowPara id=\"flowPara\">$CHARACTER</flowPara></flowRoot>"
     e '</g>'

      # ATTRIBUTES FOR WORK AND EXPORT LAYER
        LABEL=$LAYER
        ID=$UNICODE
        LOCK=""
        FILL="#000000"
        OPACITY="1"
        DISPLAY="display:none"

      done 
  done
# --------------------------------------------------------------------------- # 
     e '</svg>'
# --------------------------------------------------------------------------- # 

else
     exit 0;
fi

 
exit 0;
##



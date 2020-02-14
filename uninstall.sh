#!/bin/bash

MARKER="vivaldi-safari-style";

DIR=$(dirname "$BASH_SOURCE");

S="";
E="";

find /Applications/Vivaldi*.app/Contents/ -type f -name common.css | while read FILE ; do

  START=$(grep -n " <$MARKER> " "$FILE" | cut -f1 -d:);
  END=$(grep -n " </$MARKER> " "$FILE" | cut -f1 -d:);

  if [ "$START" != "" ]; then

    S=$(expr $START - 1);

    if [ "$END" != "" ]; then
      E=$(expr $END - 0);
      
      sed $S','$E'd' "$FILE" > "$FILE".bak;
    else
      sed $S',$d' "$FILE" > "$FILE".bak;
    fi
    mv -f "$FILE".bak "$FILE";
  fi

  
  if [ "$S" != "" ]; then
    echo -n 'Uninstalling "'$FILE'"';
    echo -n " (Line $S";
    if [ "$S" != "" ]; then
      echo -n "-$E";
    fi
    echo ")... done";
  else
    echo 'Uninstalling in "'$FILE'"... not found';
  fi

done;

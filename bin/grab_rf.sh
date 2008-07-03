#!/bin/sh
/usr/bin/nget -q -g abo -R 'author pinchy|PrivateKane|jewbagel =~ age 7d < && subject par|sfv|louie !~ &&'
#castellan

cd '/music/Music/RF/Ron and Fez'
FILES=/music/incoming/2008*R\&F*mp3
for file in $FILES
do
  BASE=`basename $file .mp3`
  echo ffmpeg -i $file -f mp4 $BASE.m4b
  yes n | ffmpeg -i $file -f mp4 $BASE.m4b > /dev/null 2>&1 && rm $file
done

cd '/music/Music/RF/Opie and Anthony'
FILES=/music/incoming/2008*O\&A*mp3
for file in $FILES
do
  BASE=`basename $file .mp3`
  echo ffmpeg -i $file -f mp4 $BASE.m4b
  yes n | ffmpeg -i $file -f mp4 $BASE.m4b > /dev/null 2>&1 && rm $file
done

#mp3splt -f -t 30.00 $FILES
#rm $FILES
#cd '/music/Music/RF/Opie and Anthony'
#FILES=/music/incoming/2007*O\&A*mp3
#mp3splt -f -t 30.00 $FILES
#rm $FILES

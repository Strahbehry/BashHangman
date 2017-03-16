#!/bin/bash


word=$(shuf -n 1 /usr/share/dict/words)
echo $word

if [[ $word =~ [^a-z] ]]
then
	echo false
else
	echo true
fi

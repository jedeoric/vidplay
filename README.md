[![Build Status](https://travis-ci.org/oric-software/vidplay.svg?branch=master)](https://travis-ci.org/oric-software/vidplay)

vidplay : a video player for the oric


How to do a video for Orix (with Oric HD):

Source code of Displaying a video


* Download VLC
* you need pictconv (OSDK package)
* you need XA (OSDK package)
* oric-common (https://github.com/jedeoric/oric-common)

1) use vlc to convert video into 240*XXX video
2) use VLC to have each frames : https://www.isimonbrown.co.uk/vlc-export-frames/
3) and use this code (replace in source code the path of the video)
modify also make_data.bat in order to generate frame and to generate one file (in make_data.bat, it's "type" command)

Each frames are in raw

Format :
0 'V'
1 'H'
2 'I'
3 0 ; Format (0=Raw)
4 (2 bytes : number of frames 16 bits)
6 (Size of the frames : 16 bits)
Fourth : type 
  0 : raw with the next 2 bytes the size of each frames, and all the frames are filled in the file




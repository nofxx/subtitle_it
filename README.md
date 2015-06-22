          __                                            __
        /    )          /          ,        /           /
    ----\--------------/__--_/_------_/_---/----__-----/---_/_-
         \     /   /  /   ) /    /   /    /   /___)   /    /
    _(____/___(___(__(___/_(_ __/___(_ __/___(___ _ _/_ __(_ __


[![Build Status](https://travis-ci.org/nofxx/subtitle_it.svg?branch=master)](https://travis-ci.org/nofxx/subtitle_it)


Ruby tool to download, create, convert and fix subtitles.


# Features

* Automatic Download on the terminal
* To and from: SRT, SUB, XML(TT), YML, MPL2, RSB and ASS.
* Fixes delays. (SrtResync)
* Compatibility with "sube" (http://github.com/vic/sube)


# Synopsis

Download subtitle:

    subtitle_it Cool-Video.avi

This will search all languages for the video. You can filter:

    subtitle_it -l Eng Cool-Video.avi

You can use -c option. It convert subtitles to given format:

    subtitle_it -l Eng -c srt Cool-Video.avi

## Bash tool

Convert a srt to sub:

    subtitle_it in.srt out.sub

or

    subtitle_it -c sub in.srt

Add a delay of 1 minute:

    subtitle_it -d 60 in.srt

Create a template

    subtitle_it unexistent.file


## Install


    gem install subtitle_it


## The "Ruby Subtitle" Format - RSB

It`s just a easy way, proof of concept to edit subtitles.
Here is what it looks like:

```
00:32 => 00:33 == Nice police work! | Thank you!
00:35 => 3 == Nice job!

MM:SS => MM:SS or N == TEXT | NEWLINE
```

Create a template to check it out.


## Automatic Download

* OpenSubtitles.org   -  WORK SubtitleIt Agent
* addic7ed.com        -  `gem install addic7ed`
* legendas.tv         -  EVIL NOAPI


*NOAPI = Mechanize playground...


## Dev

To run tests:

  rake spec or autotest

Documentation => doc
Subtitle examples => spec/fixtures


## Others

Series: https://github.com/michaelbaudino/addic7ed-ruby

## Editors

Try those nice editors too, if SubtitleIt does not fit your need:

Jubler: http://www.jubler.org/

Aegisub: http://www.malakith.net/aegiwiki/Main_Page


## THANKS

* Johanlunds - Opensubtitle.org code (to be used as a gem soon).
* Marcin (tiraeth) Chwedziak - Sub format first implementation.


## TODO

Please visit:

* http://github.com/nofxx/subtitle_it
* Support http://www.podnapisi.net/

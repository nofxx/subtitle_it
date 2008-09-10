h1. Subtitle It

Ruby tool to work with subtitle files.

h1. FEATURES:

* Converts to and from: SRT, SUB, XML(TT), YML, MPL2, RSB and ASS.
* Fixes delays. (SrtResync)

h2. TODO:

* Compatibility with "sube" (http://github.com/vic/sube)
* Download subtitles. (http://github.com/johanlunds/downsub/tree)

h1. SYNOPSIS:

Bash tool:

Convert a srt to sub:
  subtitle_it in.srt out.sub

Add a delay of 1 minute:
  subtitle_it -d 60 in.srt
 
Create a template
  subtitle_it unexistent.file 
  

h1. INSTALL:

 sudo gem install SubtitleIt


h1. THE "Ruby Subtitle" Format - RSB

It`s just a easy way, proof of concept to edit subtitles. Here is what it looks like:

00:32 => 00:33 == Nice police work! | Thank you!
MM:SS => N == TEXT | NEWLINE

Create a template to check it out.
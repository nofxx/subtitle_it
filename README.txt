= Subtitle It

Ruby tool to work with subtitle files.


== FEATURES:

* To and from: SRT, SUB, XML(TT), YML, MPL2, RSB and ASS.
* Download from opensubtitles.org
* Fixes delays. (SrtResync)

== TODO:

* Compatibility with "sube" (http://github.com/vic/sube)
* Fix delays
* Convert 1 to 2 CD`s and versa-vice
* ASS Format (Yes, for the funny of it...)


== REQUIREMENTS:

* hpricot


== SYNOPSIS:

Bash tool:

Convert a srt to sub:
  subtitle_it in.srt out.sub

Add a delay of 1 minute:
  subtitle_it -d 60 in.srt
 
Create a template
  subtitle_it unexistent.file 
  

== INSTALL:

 sudo gem install SubtitleIt


== THE "Ruby Subtitle" Format - RSB

It`s just a easy way, proof of concept to edit subtitles. Here is what it looks like:

00:32 => 00:33 == Nice police work! | Thank you!
MM:SS => N == TEXT | NEWLINE

Create a template to check it out. 


== DEV:

To run tests:

  rake spec or autotest
  
Documentation => doc
Subtitle examples => spec/fixtures
  

== SUBTITLE EDITORS:

Try those nice editors too, if SubtitleIt does not fit your need:

Jubler: http://www.jubler.org/

Aegisub: http://www.malakith.net/aegiwiki/Main_Page


== LICENSE:

(The MIT License)

Copyright (c) 2008 Marcos Piccinini, Johanlunds, Warlley Rezende


Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
= rmmseg
    by pluskid
    http://rmmseg.rubyforge.org

== DESCRIPTION:

RMMSeg is an implementation of MMSEG Chinese word segmentation
algorithm. It is based on two variants of maximum matching
algorithms. Two algorithms are available for using: 

* simple algorithm that uses only forward maximum matching.
* complex algorithm that uses three-word chunk maximum matching and 3
  additonal rules to solve ambiguities.

For more information about the algorithm, please refer to the
following essays:

* http://technology.chtsai.org/mmseg/
* http://pluskid.lifegoo.com/?p=261

== FEATURES/PROBLEMS:

* Provides +rmmseg+ command line tool for quick and easy way to access
  the word segment feature.  
* Provides an +Analyzer+ for integrating with Ferret[http://ferret.davebalmain.com/trac].

== SYNOPSIS:

Using the command line tool +rmmseg+ is simple:
  $ rmmseg --separator _ < input.txt
passing option +-h+ can get an overview of all supported options.

Using the +Analyzer+ for Ferret is even easier:

  require 'rmmseg'
  require 'rmmseg/ferret'

  alalyzer = RMMSeg::Ferret::Analyzer.new
  index = Ferret::Index::Index.new(:analyzer => analyzer)

For more details, please refer to the {homepage usage section}[http://rmmseg.rubyforge.org/index.html#Usage].

== REQUIREMENTS:

* ruby

== INSTALL:

* sudo gem install rmmseg

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

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

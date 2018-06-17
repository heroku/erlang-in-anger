#!/usr/bin/env perl

$latex = 'uplatex -synctex=1 %O %S';
$pdflatex = 'pdflatex %O -synctex=1 -interaction=nonstopmode -shell-escape %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$pdf_mode = 3;

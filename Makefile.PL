require 5.004;
use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Bio::ASN1::EntrezGene',
  VERSION_FROM => 'lib/Bio/ASN1/EntrezGene.pm',
  AUTHOR       => 'Mingyi Liu (mingyi.liu[at]gpc-biotech.com)',
  PREREQ_PM    => {'Bio::Index::AbstractSeq' => '0'}
);

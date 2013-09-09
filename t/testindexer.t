#!/usr/bin/env perl -w
use strict;
use Test::More tests => 11;

my ($noindex, $noabseq, $nogene, $noseq, $noseqindex);

BEGIN {
  diag("\n\nTest indexers (Bio::ASN1::EntrezGene::Indexer, Bio::ASN1::Sequence::Indexer)\nIndexing and retrieval:\n");
  use_ok('Bio::ASN1::EntrezGene') || $nogene++;
  use_ok('Bio::Index::AbstractSeq') || $noabseq++;
  use_ok('Bio::ASN1::EntrezGene::Indexer') || $noindex++;
  use_ok('Bio::ASN1::Sequence') || $noseq++;
  use_ok('Bio::ASN1::Sequence::Indexer') || $noseqindex++;
}
diag("\n\nFirst testing gene indexer:\n");
if(!$nogene)
{
  # test indexer
  if(!$noabseq)
  {
    if(!$noindex)
    {
      my $inx = Bio::ASN1::EntrezGene::Indexer->new(-filename => 't/testgene.idx',
                  -write_flag => 'WRITE');
      isa_ok($inx, 'Bio::ASN1::EntrezGene::Indexer');
      $inx->make_index('t/input.asn', 't/input1.asn');
#      cmp_ok($inx->count_records, '==', 4, 'total number of indexed gene records');
      my $value = $inx->fetch_hash(3);
      isa_ok($value, 'ARRAY');
      cmp_ok($value->[0]{'track-info'}[0]{geneid}, '==', 3, 'correct gene record retrieved');
    }
    else
    {
      diag("\nThere's some problem with the installation of Bio::ASN1::EntrezGene::Indexer!\nTry install again using:\n\tperl Makefile.PL\n\tmake\nQuitting now");
    }
  }
  else
  {
    diag("\nYou need to have Bio::Index::AbstractSeq (bioperl.org)\ninstalled for testing the indexer!\nQuitting now");
  }
}
else
{
  diag("\nThere's some problem with the installation of Bio::ASN1::EntrezGene!\nTry install again using:\n\tperl Makefile.PL\n\tmake\nQuitting now");
}
diag("\n\nNow testing sequence indexer:\n");
if(!$noseq)
{
  # test indexer
  if(!$noabseq)
  {
    if(!$noseqindex)
    {
      my $inx = Bio::ASN1::Sequence::Indexer->new(-filename => 't/testseq.idx',
                  -write_flag => 'WRITE');
      isa_ok($inx, 'Bio::ASN1::Sequence::Indexer');
      $inx->make_index('t/seq.asn');
#      cmp_ok($inx->count_records, '==', 2, 'total number of sequence ids in index');
      my $value = $inx->fetch_hash('AF093062');
      isa_ok($value, 'ARRAY');
      cmp_ok($value->[0]{'seq-set'}[0]{seq}[0]{id}[0]{genbank}[0]{accession}, 'eq', 'AF093062', 'correct sequence record retrieved');
    }
    else
    {
      diag("\nThere's some problem with the installation of Bio::ASN1::Sequence::Indexer!\nTry install again using:\n\tperl Makefile.PL\n\tmake\nQuitting now");
    }
  }
  else
  {
    diag("\nYou need to have Bio::Index::AbstractSeq (bioperl.org)\ninstalled for testing the indexer!\nQuitting now");
  }
}
else
{
  diag("\nThere's some problem with the installation of Bio::ASN1::Sequence!\nTry install again using:\n\tperl Makefile.PL\n\tmake\nQuitting now");
}


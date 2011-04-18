use strict;
use warnings FATAL => 'all';
use 5.008001;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'WWW-Mailchimp',
  VERSION_FROM => 'lib/WWW/Mailchimp.pm',
  PREREQ_PM => {
    'JSON' => '0',
    'LWP' => '0',
    'Moose' => '0.93',
    'URI' => '0',
    'URI::QueryParam' => '0',
  },
);


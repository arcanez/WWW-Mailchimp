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
  META_MERGE      => {
    resources => {
      license     =>      'http://dev.perl.org/licenses/',
      bugtracker  =>      'http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Mailchimp',
      repository  =>      'https://github.com/arcanez/www-mailchimp',
    },
  },
);


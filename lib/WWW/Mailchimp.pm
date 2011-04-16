package WWW::Mailchimp;
use Moose;
use LWP;
use JSON;

our $VERSION = '0.001';
$VERSION = eval $VERSION;

my @api_methods;

has api_version => (
  is => 'ro',
  isa => 'Num',
  lazy => 1,
  default => 1.3,
);

has datacenter => (
  is => 'ro',
  isa => 'Str',
  lazy => 1,
  default => 'us1',
);

has apikey => (
  is => 'ro',
  isa => 'Str',
  required => 1,
);

has api_url => (
  is => 'rw',
  isa => 'Str',
  lazy => 1,
  default => sub { my $self = shift; return 'https://' . $self->datacenter . '.api.mailchimp.com/' . $self->api_version . '/'; },
);

has output_format => (
  is => 'rw',
  isa => 'Str',
  lazy => 1,
  default => 'json',
);

has ua => (
  is => 'ro',
  isa => 'LWP::UserAgent',
  lazy => 1,
  builder => '_build_lwp',
  handles => [ qw(request) ],
);

for my $method (@api_methods) {
  __PACKAGE__->meta->add_method( $method => sub { shift->_request($method, @_) } );
}

sub _build_lwp {
  my $self = shift;
  my $ua = LWP::UserAgent->new( agent => __PACKAGE__ . ' ' . $VERSION );
}

sub _request {
  my $self = shift;
  my $method = shift;
  my %args = ref($_[0]) ? %{$_[0]} : @_;
  my $url;
  $url  = $self->api_url;
  $url .= '?apikey=' . $self->apikey;
  $url .= '&output=' . $self->output_format;
  $url .= '&method=' . $method;

  if (scalar keys %args) {
    $url .= '&' . (join '&', map { "$_=$args{$_}" } keys %args);
  }

  my $request = HTTP::Request->new( GET => $url );
  my $response = $self->request($request);

  return $response->is_success ? from_json($response->content) : $response->status_line;
}

@api_methods = qw(
campaignContent
campaignCreate
campaignDelete
campaignEcommOrderAdd
campaignPause
campaignReplicate
campaignResume
campaignSchedule
campaignSegmentTest
campaignSendNow
campaignSendTest
campaignShareReport
campaignTemplateContent
campaignUnschedule
campaignUpdate
campaigns
campaignAbuseReports
campaignAdvice
campaignAnalytics
campaignBounceMessage
campaignBounceMessages
campaignClickStats
campaignEcommOrders
campaignEepUrlStats
campaignEmailDomainPerformance
campaignGeoOpens
campaignGeoOpensForCountry
campaignHardBounces
campaignMembers
campaignSoftBounces
campaignStats
campaignUnsubscribes
campaignClickDetailAIM
campaignEmailStatsAIM
campaignEmailStatsAIMAll
campaignNotOpenedAIM
campaignOpenedAIM
ecommOrderAdd
ecommOrderDel
ecommOrders
folderAdd
folderDel
folderUpdate
folders
campaignsForEmail
chimpChatter
generateText
getAccountDetails
inlineCss
listsForEmail
ping
listAbuseReports
listActivity
listBatchSubscribe
listBatchUnsubscribe
listClients
listGrowthHistory
listInterestGroupAdd
listInterestGroupDel
listInterestGroupUpdate
listInterestGroupingAdd
listInterestGroupingDel
listInterestGroupingUpdate
listInterestGroupings
listLocations
listMemberActivity
listMemberInfo
listMembers
listMergeVarAdd
listMergeVarDel
listMergeVarUpdate
listMergeVars
listStaticSegmentAdd
listStaticSegmentDel
listStaticSegmentMembersAdd
listStaticSegmentMembersDel
listStaticSegmentReset
listStaticSegments
listSubscribe
listUnsubscribe
listUpdateMember
listWebhookAdd
listWebhookDel
listWebhooks
lists
apikeyAdd
apikeyExpire
apikeys
templateAdd
templateDel
templateInfo
templateUndel
templateUpdate
templates
);

1;

use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Mo::utils qw(check_bool);
use Test::More 'tests' => 6;
use Test::NoWarnings;

# Test.
my $self = {
	'key' => 0,
};
my $ret = check_bool($self, 'key');
is($ret, undef, 'Right bool value.');

# Test.
$self = {
	'key' => 1,
};
$ret = check_bool($self, 'key');
is($ret, undef, 'Right bool value.');

# Test.
$self = {};
eval {
	check_bool($self, 'key');
};
is($EVAL_ERROR, "Parameter 'key' doesn't exist.\n",
	"Parameter 'key' doesn't exist.");
clean();

# Test.
$self = {
	'key' => 2,
};
eval {
	check_bool($self, 'key');
};
is($EVAL_ERROR, "Parameter 'key' must be a bool (0/1).\n",
	"Parameter 'key' must be a bool (0/1).");
clean();

# Test.
$self = {
	'key' => 'foo',
};
eval {
	check_bool($self, 'key');
};
is($EVAL_ERROR, "Parameter 'key' must be a bool (0/1).\n",
	"Parameter 'key' must be a bool (0/1).");
clean();

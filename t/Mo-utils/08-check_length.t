use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Mo::utils qw(check_length);
use Test::More 'tests' => 6;
use Test::NoWarnings;

# Test.
my $self = {
	'key' => 'foo',
};
eval {
	check_length($self, 'key', 2);
};
is($EVAL_ERROR, "Parameter 'key' has length greater than '2'.\n",
	"Parameter 'key' has length greater than '2'.");
clean();

# Test.
my $ret = check_length($self, 'key', 3);
is($ret, undef, 'Right length of value is present (foo and 3).');

# Test.
$ret = check_length($self, 'key', 4);
is($ret, undef, 'Right length of value is present (foo and 4).');

# Test.
$self = {};
eval {
	check_length($self, 'key', 4);
};
is($EVAL_ERROR, "Parameter 'key' doesn't exist.\n",
	"Parameter 'key' doesn't exist.");
clean();

# Test.
$self = {
	'key' => undef,
};
$ret = check_length($self, 'key', 4);
is($ret, undef, 'Right length of value is present (undef value).');

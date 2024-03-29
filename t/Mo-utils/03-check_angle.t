use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean err_msg_hr);
use Mo::utils qw(check_angle);
use Test::More 'tests' => 13;
use Test::NoWarnings;

# Test.
my $self = {
	'key' => 'foo',
};
eval {
	check_angle($self, 'key');
};
is($EVAL_ERROR, "Parameter 'key' must be a number.\n",
	"Parameter 'key' must be a number (foo).");
my $err_msg_hr = err_msg_hr();
is($err_msg_hr->{'Value'}, 'foo', 'Test error parameter (Value: foo).');
clean();

# Test.
$self = {
	'key' => -1,
};
eval {
	check_angle($self, 'key');
};
is($EVAL_ERROR, "Parameter 'key' must be a number between 0 and 360.\n",
	"Parameter 'key' must be a number between 0 and 360 (-1).");
$err_msg_hr = err_msg_hr();
is($err_msg_hr->{'Value'}, -1, 'Test error parameter (Value: -1).');
clean();

# Test.
$self = {
	'key' => 360.1,
};
eval {
	check_angle($self, 'key');
};
is($EVAL_ERROR, "Parameter 'key' must be a number between 0 and 360.\n",
	"Parameter 'key' must be a number between 0 and 360 (360.1).");
$err_msg_hr = err_msg_hr();
is($err_msg_hr->{'Value'}, 360.1, 'Test error parameter (Value: 360.1).');
clean();

# Test.
$self = {
	'key' => 10,
};
my $ret = check_angle($self, 'key');
is($ret, undef, 'Right number is present (10).');

# Test.
$self = {
	'key' => 10.0001,
};
$ret = check_angle($self, 'key');
is($ret, undef, 'Right number is present (10.0001).');

# Test.
$self = {
	'key' => '0',
};
$ret = check_angle($self, 'key');
is($ret, undef, 'Right number is present (0).');

# Test.
$self = {
	'key' => 360,
};
$ret = check_angle($self, 'key');
is($ret, undef, 'Right number is present (360).');

# Test.
$self = {};
$ret = check_angle($self, 'key');
is($ret, undef, 'Right not exist key.');

# Test.
$self = {
	'key' => undef,
};
$ret = check_angle($self, 'key');
is($ret, undef, "Value is undefined, that's ok.");

# --
# Copyright (C) 2012-2022 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use Kernel::System::VariableCheck qw(:all);

use vars (qw($Self));

# get the Znuny Selenium object
my $SeleniumObject = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

# store test function in variable so the Selenium object can handle errors/exceptions/dies etc.
my $SeleniumTest = sub {

    # initialize Znuny Helpers and other needed objects
    my $HelperObject      = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
    my $ZnunyHelperObject = $Kernel::OM->Get('Kernel::System::ZnunyHelper');
    my $FAQObject         = $Kernel::OM->Get('Kernel::System::FAQ');

    $HelperObject->ConfigSettingChange(
        Key   => 'Frontend::RichText',
        Value => 0,
        Valid => 1,
    );

    my %TestUser = $SeleniumObject->AgentLogin(
        Groups => [ 'admin', 'users' ],
    );

    $SeleniumObject->AgentRequest(
        Action => 'AgentFAQAdd',
    );

    $SeleniumObject->PageContains(
        String  => 'HasCKEInstance',
        Message => 'Agent Interface RichText CKEditor initialized'
    );
};

$SeleniumObject->RunTest($SeleniumTest);

1;

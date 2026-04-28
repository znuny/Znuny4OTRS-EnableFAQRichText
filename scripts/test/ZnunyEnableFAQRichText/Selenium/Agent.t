# --
# Copyright (C) 2012 Znuny GmbH, https://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

# get the Znuny Selenium object
my $SeleniumObject = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

# store test function in variable so the Selenium object can handle errors/exceptions/dies etc.
my $SeleniumTest = sub {

    # initialize Znuny Helpers and other needed objects
    my $HelperObject = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

    $HelperObject->ConfigSettingChange(
        Key   => 'Frontend::RichText',
        Value => 0,
        Valid => 1,
    );
    $HelperObject->ConfigSettingChange(
        Key   => 'FAQ::Item::HTML',
        Value => 1,
        Valid => 1,
    );

    my %TestUser = $SeleniumObject->AgentLogin(
        Groups => [ 'admin', 'users' ],
    );

    $SeleniumObject->AgentInterface(
        Action      => 'AgentFAQAdd',
        WaitForAJAX => 0,
    );

    $SeleniumObject->WaitFor(
        JavaScript => <<'EOF',
return typeof($) === "function"
    && typeof(Core) === "object"
    && typeof(Core.Config) === "object"
    && Core.Config.Get("Action") === "AgentFAQAdd"
    && parseInt(Core.Config.Get("RichTextSet"), 10) === 1
    && $("#Field1.RichText").length === 1
    && $("#Field2.RichText").length === 1
    && $("#Field3.RichText").length === 1
    && $("#Field6.RichText").length === 1;
EOF
    );

    $SeleniumObject->PageContains(
        String  => 'ckeditor-znuny.js',
        Message => 'Agent Interface includes CKEditor assets'
    );
};

$SeleniumObject->RunTest($SeleniumTest);

1;

# --
# Copyright (C) 2012-2018 Znuny GmbH, http://znuny.com/
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

# get the Znuny4OTRS Selenium object
my $SeleniumObject = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

# store test function in variable so the Selenium object can handle errors/exceptions/dies etc.
my $SeleniumTest = sub {

    # initialize Znuny4OTRS Helpers and other needed objects
    my $HelperObject      = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
    my $ZnunyHelperObject = $Kernel::OM->Get('Kernel::System::ZnunyHelper');
    my $FAQObject         = $Kernel::OM->Get('Kernel::System::FAQ');

    $HelperObject->ConfigSettingChange(
        Key   => 'Frontend::RichText',
        Value => 0,
        Valid => 1,
    );

    # Check AgentInterface

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

    # Check CustomerInterface

    my $RandomID    = $HelperObject->GetRandomID();
    my $HTMLContent = "<b>Some <i>FAQ</i> text about $RandomID</b>";

    my $Title  = 'FAQ ' . $RandomID;
    my $ItemID = $FAQObject->FAQAdd(
        Title       => $Title,
        CategoryID  => 1,
        StateID     => 1,
        LanguageID  => 1,
        Keywords    => 'None',
        Field1      => $HTMLContent,
        Field2      => $HTMLContent,
        Field3      => $HTMLContent,
        Approved    => 1,
        ValidID     => 1,
        UserID      => 1,
        ContentType => 'text/html',
    );

    $SeleniumObject->CustomerUserLogin();

    $SeleniumObject->CustomerRequest(
        Action => 'CustomerFAQZoom',
        ItemID => $ItemID,
    );

    # verify FAQ is created
    $SeleniumObject->PageContains(
        String  => $Title,
        Message => 'FAQ Title found'
    );

    # Selenium won't switch to a frame if it's not loaded yet
    sleep 3;

    $SeleniumObject->switch_to_frame('IframeFAQField1');

    # the HTML markup would be stripped out if RichText is disabled
    $SeleniumObject->PageContains(
        String  => $HTMLContent,
        Message => 'Customer Interface RichText CKEditor initialized'
    );
};

$SeleniumObject->RunTest($SeleniumTest);

1;

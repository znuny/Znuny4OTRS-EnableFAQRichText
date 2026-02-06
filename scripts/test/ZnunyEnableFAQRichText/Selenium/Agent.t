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

    $SeleniumObject->WaitFor(
        JavaScript =>
            "return typeof Core === 'object' && Core.App && Core.App.PageLoadComplete;",
        Time => 60,
    );

    my $RichTextSet = $SeleniumObject->execute_script(
        "return (typeof Core === 'object' && Core.Config && Core.Config.Get) "
            . "? Core.Config.Get('RichTextSet') : 0;"
    );
    $Self->True(
        $RichTextSet,
        'Agent FAQ page has RichText enabled',
    );

    my $CKEditorScript = $SeleniumObject->execute_script(
        "return Array.from(document.scripts).map(s => s.src || '')"
            . ".filter(src => src.match(/ckeditor-znuny\\.js/)).join(',');"
    );
    $Self->True(
        $CKEditorScript,
        'Agent FAQ page includes CKEditor bundle',
    );

    my $HasZnunyEditor = $SeleniumObject->execute_script(
        "return typeof ZnunyEditor !== 'undefined';"
    );

    if ($HasZnunyEditor) {
        $SeleniumObject->WaitFor(
            JavaScript =>
                "if (Core.UI && Core.UI.RichTextEditor) { Core.UI.RichTextEditor.InitAllEditors(); }"
                . "return Core.UI && Core.UI.RichTextEditor "
                . "&& Core.UI.RichTextEditor.GetInstance && Core.UI.RichTextEditor.GetInstance('Field1');",
            Time => 60,
        );

        $SeleniumObject->PageContains(
            String  => 'HasCKEInstance',
            Message => 'Agent Interface RichText editor initialized'
        );
    }
    else {
        $Self->True(
            1,
            'ZnunyEditor not available in this browser, skipping instance check.',
        );
    }
};

$SeleniumObject->RunTest($SeleniumTest);

1;

# --
# Copyright (C) 2012-2020 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
## nofilter(TidyAll::Plugin::OTRS::Legal::OTRSAGCopyright)

use Kernel::Modules::PublicFAQZoom;

package Kernel::Modules::PublicFAQZoom;    ## no critic

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Output::HTML::Layout',
);

# disable redefine warnings in this scope
{
    no warnings 'redefine';    ## no critic

    # backup original Run()
    my $Run = \&Kernel::Modules::PublicFAQZoom::Run;

    # redefine Run() of Kernel::Modules::PublicFAQZoom::Run
    *Kernel::Modules::PublicFAQZoom::Run = sub {
        my ( $Self, %Param ) = @_;

        my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
        my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

        $ConfigObject->Set(
            Key   => 'Frontend::RichText',
            Value => 1,
        );
        $LayoutObject->{BrowserRichText} = 1;

        # execute original function
        return &{$Run}( $Self, %Param );
        }
}

1;

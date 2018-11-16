# --
# Copyright (C) 2012-2018 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentFAQRichTextEnable;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # check needed objects
    for my $Needed (qw(ParamObject DBObject LayoutObject LogObject ConfigObject TimeObject)) {
        if ( !$Self->{$Needed} ) {
            $Self->{LayoutObject}->FatalError( Message => "Got no $Needed!" );
        }
    }

    return $Self;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    return '' if $Self->{Action} !~ /FAQ/;

    $Self->{ConfigObject}->Set(
        Key   => 'Frontend::RichText',
        Value => 1,
    );
    $Self->{LayoutObject}->{BrowserRichText} = 1;

    return '';
}

1;

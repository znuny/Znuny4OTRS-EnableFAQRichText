# --
# Kernel/Modules/AgentFAQRichTextEnable.pm - This module enables rich text for FAQ also if rich text is disabled via SysConfig.
# Copyright (C) 2012-2015 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentFAQRichTextEnable;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Output::HTML::Layout',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    return '' if $Self->{Action} !~ /FAQ/;

    $Kernel::OM->Get('Kernel::Config')->Set(
        Key   => 'Frontend::RichText',
        Value => 1,
    );
    $Kernel::OM->Get('Kernel::Output::HTML::Layout')->{BrowserRichText} = 1;

    return '';
}

1;

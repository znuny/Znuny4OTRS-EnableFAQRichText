# --
# Kernel/Language/de_Znuny4OTRSEnableFAQRichText.pm - the german translation of the texts of Znuny4OTRSEnableFAQRichText
# Copyright (C) 2012-2015 Znuny GmbH, http://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::de_Znuny4OTRSEnableFAQRichText;

use strict;
use warnings;

use utf8;

sub Data {
    my $Self = shift;

    $Self->{Translation}->{'This configuration registers a PreApplication module that.'} = '';
    $Self->{Translation}->{"This module enables rich text for FAQ also if rich text is disabled via SysConfig."} = "Mit Hilfe dieses Moduls aktiviert man RichText in der FAQ auch wenn RichText im System deaktiviert ist.";

    return 1;
}

1;

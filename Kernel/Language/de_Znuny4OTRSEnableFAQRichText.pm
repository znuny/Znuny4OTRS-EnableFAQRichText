# --
# Copyright (C) 2012-2021 Znuny GmbH, http://znuny.com/
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

    $Self->{Translation}->{"Registers a PreApplication module that re-enables FAQ RichText even if disabled via SysConfig."} = "Registriert ein PreApplication-Modu, dass die RichText-Funktion der FAQ aktiviert, auch wenn diese im System global deaktiviert wurde.";

    return 1;
}

1;

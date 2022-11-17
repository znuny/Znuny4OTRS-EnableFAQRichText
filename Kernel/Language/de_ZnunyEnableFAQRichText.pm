# --
# Copyright (C) 2012-2022 Znuny GmbH, https://znuny.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::de_ZnunyEnableFAQRichText;

use strict;
use warnings;

use utf8;

sub Data {
    my $Self = shift;

    $Self->{Translation}->{"Pre-application module that re-enables richtext for FAQ even if richtext is disabled via SysConfig."} = "Pre-Application-Modul, das Richtext für FAQ aktiviert, auch wenn Richtext im System deaktiviert wurde.";
    $Self->{Translation}->{"Autoloading of ZnunyEnableFAQRichText extension."} = "Autoloading für Modul ZnunyEnableFAQRichText.";

    return 1;
}

1;

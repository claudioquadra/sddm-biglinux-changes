#!/bin/bash

cat <<'EOF' > /usr/share/sddm/themes/breeze/components/Clock.qml
/*
 *   Copyright 2016 David Edmundson <davidedmundson@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.8
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.plasma.core 2.0

ColumnLayout {
    readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    Label {
        text: Qt.formatTime(timeSource.data["Local"]["DateTime"])
        color: ColorScope.textColor
        style: softwareRendering ? Text.Outline : Text.Normal
        styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        font.pointSize: 36
        Layout.alignment: Qt.AlignHCenter
    }
    Label {
EOF


if [ -e "/usr/share/games/fortunes/biglinux-ptbr" ]; then
    echo "text: \"$(/usr/games/fortune biglinux-ptbr | sed "s|\"|'|g")\"" >> /usr/share/sddm/themes/breeze/components/Clock.qml
else
    echo 'text: Qt.formatDate(timeSource.data["Local"]["DateTime"], Qt.DefaultLocaleLongDate)' >> /usr/share/sddm/themes/breeze/components/Clock.qml
fi





cat <<'EOF' >> /usr/share/sddm/themes/breeze/components/Clock.qml
        color: ColorScope.textColor
        style: softwareRendering ? Text.Outline : Text.Normal
        styleColor: softwareRendering ? ColorScope.backgroundColor : "transparent" //no outline, doesn't matter
        font.pointSize: 18
        Layout.alignment: Qt.AlignHCenter
    }
    DataSource {
        id: timeSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 1000
    }
}
EOF

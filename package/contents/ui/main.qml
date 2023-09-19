/*
*    SPDX-FileCopyrightText: %{CURRENT_YEAR} %{AUTHOR} <%{EMAIL}>
*    SPDX-License-Identifier: LGPL-2.1-or-later
*/

import QtQuick 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

Item {
	id: root
	property string mainIconName: plasmoid.configuration.mainIconName
	property string iconNewNotification: plasmoid.configuration.iconNewNotification
	property bool newMessage: false;
	
	Plasmoid.compactRepresentation: CompactRepresentation {}
	Plasmoid.fullRepresentation: FullRepresentation {}
}
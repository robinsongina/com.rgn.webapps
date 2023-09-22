import QtQuick 2.3
import QtQuick.Layouts 1.0
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid 2.0

Item {
	id: compactRep
	RowLayout {
		anchors.fill: parent
	
		Kirigami.Icon {
			Layout.fillWidth: true
			Layout.fillHeight: true
			source: root.newNotification && root.iconNewNotification != '' ? root.iconNewNotification : root.mainIconName
			smooth: true

			MouseArea {
				anchors.fill: parent
				onClicked: {
					plasmoid.expanded = !plasmoid.expanded
					if (root.newNotification) {
						root.newNotification = false;
					}
				}
			}
		}
	}
}
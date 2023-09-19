import QtQuick 2.3
import QtQuick.Layouts 1.0
import org.kde.notification 1.0
import org.kde.plasma.plasmoid 2.0

Component {
	id: notificationComponent
	Notification {
		componentName: "plasma_workspace"
		eventId: "notification"
		iconName: root.mainIconName;
		autoDelete: true
		defaultAction: "Default Action"
		onDefaultActivated: {
			if (!plasmoid.expanded){
				plasmoid.expanded = !plasmoid.expanded;
				root.newMessage = false;
			} 
		}
	}
}
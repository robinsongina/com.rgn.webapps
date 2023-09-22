import QtQuick 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasmoid 2.0
import QtWebEngine

import "components" as Components

Item {
    id: fullRep
	Layout.minimumWidth: 790 * 1
	Layout.minimumHeight:  555 * 1
	Layout.preferredWidth: plasmoid.configuration.width * 1
	Layout.preferredHeight: plasmoid.configuration.height * 1

    
    ColumnLayout {
        anchors.fill: parent

		//-----------------------------  Helpers ------------------
		Connections {
			target: plasmoid
			// function onActivated() {
			// 	console.log("Plasmoid revealed to user")
			// }
			// function onStatusChanged() {
			// 	console.log("Plasmoid status changed "+plasmoid.status)
			// }
			// function hideOnWindowDeactivateChanged() {
			// 	console.log("Plasmoid hideOnWindowDeactivateChanged changed")
			// }
			function onExpandedChanged() {
				if(webAppWebView && plasmoid.expanded) {
					if(webAppWebView.LoadStatus == WebEngineView.LoadFailedStatus) webAppWebView.reload();
				}
				// console.log("Plasmoid onExpandedChanged: "+plasmoid.expanded )
			}
		}

		//------------------------------------- UI -----------------------------------------
		Column {
			anchors {
				right: parent.right;
				left: parent.left;
				top: parent.top;
			}
			height: 24 * 1
			spacing: 2 * 1

			Row {
				anchors {
					right: pinButton.left;
					left: parent.left;
					top: parent.top;
					bottom: parent.bottom
				}
				spacing: 2 * 1
				Kirigami.Icon {
					height: parent.height
					width: height
					source: root.mainIconName
            		smooth: true
				}
			}
      		Row {
				anchors {
					right: parent.right;
					top: parent.top;
				}
				spacing: 2 * 1
				PlasmaComponents3.ToolButton {
					id:pinButton
					height:24 * 1
					width:height
					checkable: true
					tooltip: i18n("Pin window")
					iconSource: "window-pin"
					checked: plasmoid.configuration.pin
					onCheckedChanged: plasmoid.configuration.pin = checked
				}
				PlasmaComponents3.ToolButton {
					id: pinbutton
					height: 24 * 1
					width: height
					tooltip: i18n("Reload")
					iconSource: "view-refresh"
					onClicked: {
						webAppWebView.reload();
					}
				}
				PlasmaComponents3.ToolButton {
					height: 24 * 1
					width: height
					tooltip: i18n("Debug console")
					visible: Qt.application.arguments[0] == "plasmoidviewer" || plasmoid.configuration.debugConsole
					enabled:visible
					iconSource: "debug-step-over"
					onClicked: {
						webAppWebViewInspector.visible = !webAppWebViewInspector.visible;
						webAppWebViewInspector.enabled = visible || webAppWebViewInspector.visible
					}
				}
   			}

			//-------------------- Connections  -----------------------
			Binding {
				target: plasmoid
				property: "hideOnWindowDeactivate"
				value: !plasmoid.configuration.pin
			}

			Binding {
				target: plasmoid
				property: "title"
				value: plasmoid.configuration.name != "" ? plasmoid.configuration.name : plasmoid.title
			}
		}
		RowLayout {
			Layout.fillHeight:true
			Layout.fillWidth:true
			
			Components.AppEngineView {
				id: webAppWebView
				profile.storageName: "webApp-" + plasmoid.configuration.name
			}
	
		}

		WebEngineView {
			id: webAppWebViewInspector
			Layout.fillWidth: true
			Layout.alignment: Qt.AlignBottom
			height: parent.height / 2
			visible: false
			enabled: false
			z: 100
			inspectedView: enabled ? webAppWebView : null	
		}
	}
}
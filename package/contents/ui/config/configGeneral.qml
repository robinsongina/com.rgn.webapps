import QtQml 2.0
import QtQuick 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.5 as QQC2
import org.kde.kirigami 2.4 as Kirigami
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

Kirigami.FormLayout {
  id: page

  property alias cfg_width: width.value
  property alias cfg_height: height.value
  property alias cfg_mainIconName: mainIconName.icon.name
  property alias cfg_iconNewNotification: iconNewNotification.icon.name
  property alias cfg_url: url.text
  // property alias cfg_userAgent: userAgent.text
  property alias cfg_allowClipboardAccess: allowClipboardAccess.checked
  property alias cfg_notificationsAccess: notificationsAccess.checked
  property alias cfg_mediaVideoCapture: mediaVideoCapture.checked
  property alias cfg_mediaAudioCapture: mediaAudioCapture.checked
  property alias cfg_mediaAudioVideoCapture: mediaAudioVideoCapture.checked

	
  Layout.fillHeight:true

  // Used to select icons
  KQuickAddons.IconDialog {
    id: iconDialog
    property var iconObj
    
    onIconNameChanged: iconObj.name = iconName    
  }

  RowLayout {
    QQC2.Label {
      text: i18n("Icon")
    }
    QQC2.Button {
      id: mainIconName
      icon.height: PlasmaCore.Units.iconSizes.medium
      icon.width: icon.height
      
      onClicked: {
        iconDialog.open()
        iconDialog.iconObj = mainIconName.icon
      }
    }
  }

  RowLayout {
    QQC2.Label {
      text: i18n("Icon new notification")
    }
    QQC2.Button {
      id: iconNewNotification
      icon.height: PlasmaCore.Units.iconSizes.medium
      icon.width: icon.height
      
      onClicked: {
        iconDialog.open()
        iconDialog.iconObj = iconNewNotification.icon
      }
    }
  }
  
  QQC2.Slider {
    Kirigami.FormData.label:i18n("Window Width: %1px",width.value );
    id: width
    from: 790
    stepSize: 5
    value: 790
    to: 1920
    live: true
  }

  QQC2.Slider {
    Kirigami.FormData.label:i18n("Window Height: %1px",height.value );
    id: height
    from: 555
    stepSize: 5
    value: 555
    to: 1080
    live: true
  }

  QQC2.TextField {
	  id: url
    Kirigami.FormData.label: i18n("Url:")
	  placeholderText: "Url"
  }

  // QQC2.TextField {
	//   id: userAgent
  //   Kirigami.FormData.label: i18n("UserAgent:")
	//   placeholderText: "UserAgent for browser"
  // }

  // QQC2.Label {
  //  font.pixelSize: 10
  //  font.italic: true
  //  text:i18n("It is necessary to ignore the message Whatsapp works with Google Chrome 60+");
  // }


	QQC2.CheckBox {
    id: allowClipboardAccess
    text: i18n("Allow system clipboard access")
  }

  QQC2.Label {
		font.pixelSize: 8
		font.italic: true
		text:i18n("This is enabled by default to allow for quick code/recipe/etc but can be disabled if you are worried about examining your system clipboard");
	}

  QQC2.CheckBox {
    id: notificationsAccess
    text: i18n("Allow notifications")
  }

  QQC2.CheckBox {
    id: mediaVideoCapture
    text: i18n("Video devices, such as cameras.")
  }

  QQC2.CheckBox {
    id: mediaAudioCapture
    text: i18n("Audio capture devices, such as microphones.")
  }

  QQC2.CheckBox {
    id: mediaAudioVideoCapture
    text: i18n("Both audio and video capture devices.")
  }
  
}

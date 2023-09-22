import QtQml 2.0
import QtQuick 2.3
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.5 as QQC2
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

Kirigami.FormLayout {
  id: page

  property alias cfg_mainIconName: mainIconName.icon.name
  property alias cfg_iconNewNotification: iconNewNotification.icon.name
  property alias cfg_url: url.text
  property alias cfg_name: name.text
  property alias cfg_showUserAgent: showUserAgent.checked
  property alias cfg_userAgent: userAgent.text
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

  QQC2.TextField {
    id: name
    Kirigami.FormData.label: i18n("Name:")
    placeholderText: "Website name"
  }

  QQC2.TextField {
    id: url
    Kirigami.FormData.label: i18n("Url:")
    placeholderText: "https://www.website.com"
  }

  RowLayout {
    spacing: 5
    QQC2.Label {
      text: i18n("Icon:")
    }
    QQC2.Button {
      id: mainIconName
      icon.height: Kirigami.Units.iconSizes.medium
      icon.width: icon.height
      
      onClicked: {
        iconDialog.open()
        iconDialog.iconObj = mainIconName.icon
      }
    }
    QQC2.Label {
      text: i18n("Icon new notification:")
    }
    QQC2.Button {
      id: iconNewNotification
      icon.height: Kirigami..Units.iconSizes.medium
      icon.width: icon.height
      
      onClicked: {
        iconDialog.open()
        iconDialog.iconObj = iconNewNotification.icon
      }
    }
  }

  QQC2.CheckBox {
    id: showUserAgent
    text: i18n("UserAgent")
  }

  QQC2.TextField {
	  id: userAgent
	  placeholderText: "UserAgent for browser"
    enabled: showUserAgent.checked
  }

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
    text: i18n("Allow Video devices, such as cameras.")
  }

  QQC2.CheckBox {
    id: mediaAudioCapture
    text: i18n("Allow Audio capture devices, such as microphones.")
  }

  QQC2.CheckBox {
    id: mediaAudioVideoCapture
    text: i18n("Allow Both audio and video capture devices.")
  }
}

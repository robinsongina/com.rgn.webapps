import QtQuick 2.3
import QtQuick.Layouts 1.0
import QtWebEngine
import org.kde.plasma.plasmoid 2.0

WebEngineView {
	id: webAppWebview
	url: plasmoid.configuration.url
	settings.javascriptCanAccessClipboard: plasmoid.configuration.allowClipboardAccess
	Layout.fillHeight: true
	Layout.fillWidth: true

	NotificationMsg{
        id: notificationMsg
    }

	NotificationDownload {
		id: notificationDownload
	}

	profile: WebEngineProfile {
		id: webAppProfile
		offTheRecord: false
		httpUserAgent: plasmoid.configuration.showUserAgent ? plasmoid.configuration.userAgent : ''
		httpCacheType: WebEngineProfile.DiskHttpCache
		persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
		userScripts: [
			WebEngineScript {
				injectionPoint: WebEngineScript.DocumentCreation
				name: "helperFunctions"
				worldId: WebEngineScript.MainWorld
				sourceUrl: "../js/helper_functions.js"
			}
		]

		//This signal is emitted whenever there is a newly created user notification. The notification argument holds the WebEngineNotification instance to query data and interact with.
		onPresentNotification: {
			if (!plasmoid.expanded) root.newNotification = true;
			sendNotification('msg', { title: notification.title, text: notification.message });
		}
		onDownloadRequested: {
			download.accept();
		}
		onDownloadFinished: {
			if(download.state === WebEngineDownloadItem.DownloadCompleted){
				sendNotification('download', { 
					title: "Download Complete", 
					text: download.downloadFileName,
					directory: download.downloadDirectory,
					actions: ['Open', 'Folder']
				})
			}else if (download.state === WebEngineDownloadItem.DownloadInterrupted){
				sendNotification('download', {
					title: "Download interrupted", 
					text: download.interruptReasonString
				})	
			}
		}
	}

	onFullScreenRequested: {
		request.accept()
	}

	//This signal is emitted when the web site identified by securityOrigin requests to make use of the resource or device identified by feature.
	onFeaturePermissionRequested: {
		if( (plasmoid.configuration.notificationsAccess && feature == WebEngineView.Notifications) ||
			(plasmoid.configuration.mediaVideoCapture && feature == WebEngineView.MediaVideoCapture) ||
			(plasmoid.configuration.mediaAudioCapture && feature == WebEngineView.MediaAudioCapture) ||
			(plasmoid.configuration.mediaAudioVideoCapture && feature == WebEngineView.MediaAudioVideoCapture)){
			webAppWebview.grantFeaturePermission(securityOrigin, feature, true)
		}
	}

	//This signal is emitted when request is issued to load a page in a separate web engine view. 
	onNewViewRequested: {
		Qt.openUrlExternally(request.requestedUrl)
	}

	//This signal is emitted when a page load begins, ends, or fails.
	onLoadingChanged:  {
		if(WebEngineView.LoadSucceededStatus === loadRequest.status) {
			//Permanently allow notifications
			// webAppWebview.grantFeaturePermission(url, WebEngineView.Notifications, true)
		}
	}

    //This signal is emitted when a JavaScript program tries to print a message to the web browser's console.
    onJavaScriptConsoleMessage : if (Qt.application.arguments[0] == "plasmoidviewer") {
    	// console.log("Browser: " + message);
    }

	function sendNotification(typeNotification, options) {
		let notify;
		if(typeNotification === 'msg'){
			notify = notificationMsg.createObject(parent, options);
		}else{
			notify = notificationDownload.createObject(parent, options);
		}
		notify.sendEvent();
	}
}
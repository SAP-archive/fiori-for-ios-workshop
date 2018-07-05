//
// AppDelegate.swift
// TravelExpenses
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 09/06/18
//

import SAPCommon
import SAPFiori
import SAPFioriFlows
import SAPFoundation
import SAPOData
import SAPOfflineOData
import UserNotifications

let APPLICATIONID: String = "com.sap.expense"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate, OnboardingManagerDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    private let logger = Logger.shared(named: "AppDelegateLogger")
    var travelexpense: Travelexpense<OfflineODataProvider> {
        return DataHandler.shared.service
    }
    private(set) var isOfflineStoreOpened = false

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Set a FUIInfoViewController as the rootViewController, since there it is none set in the Main.storyboard
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = FUIInfoViewController.createSplashScreenInstanceFromStoryboard()

        do {
            // Attaches a LogUploadFileHandler instance to the root of the logging system
            try SAPcpmsLogUploader.attachToRootLogger()
        } catch {
            self.logger.error("Failed to attach to root logger.", error: error)
        }

        UINavigationBar.applyFioriStyle()

        OnboardingManager.shared.delegate = self
        OnboardingManager.shared.onboardOrRestore()

        return true
    }

    // To only support portrait orientation during onboarding
    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        switch OnboardingFlowController.presentationState {
        case .onboarding, .restoring:
            return .portrait
        default:
            return .allButUpsideDown
        }
    }

    // Delegate to OnboardingManager.
    func applicationDidEnterBackground(_: UIApplication) {
        OnboardingManager.shared.applicationDidEnterBackground()
        self.closeOfflineStore()
    }

    // Delegate to OnboardingManager.
    func applicationWillEnterForeground(_: UIApplication) {
        OnboardingManager.shared.applicationWillEnterForeground()
        self.openOfflineStore(false)
    }

    func onboardingContextCreated(onboardingContext: OnboardingContext, onboarding: Bool) {
        let configurationURL = URL(string: "https://hcpms-i826181trial.hanatrial.ondemand.com/" + APPLICATIONID)!
        self.configureOData(onboardingContext.sapURLSession, configurationURL, onboarding)
    }

    func onboarded(onboardingContext: OnboardingContext) {
        self.uploadLogs(onboardingContext.sapURLSession, onboardingContext.sapcpmsSettingsParameters!)
        self.registerForRemoteNotification(onboardingContext.sapURLSession, onboardingContext.sapcpmsSettingsParameters!)
        self.openOfflineStore(true)
    }

    private func setRootViewController() {
        DispatchQueue.main.async {
            let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
            if let rootViewController = rootViewController as? UITabBarController {
                if let items = rootViewController.tabBar.items, items.count == 3 {
                    items[0].image = FUIIconLibrary.docType.table.withRenderingMode(.alwaysTemplate)
                    items[1].image = FUIIconLibrary.system.calendar.withRenderingMode(.alwaysTemplate)
                    items[2].image = FUIIconLibrary.system.listView.withRenderingMode(.alwaysTemplate)
                }
            }
            self.window!.rootViewController = rootViewController
        }
    }

    // MARK: - Split view

    func splitViewController(_: UISplitViewController, collapseSecondary _: UIViewController, onto _: UIViewController) -> Bool {
        // The first Collection will be selected automatically, so we never discard showing the secondary ViewController
        return false
    }

    // MARK: - Remote Notification handling

    private var deviceToken: Data?

    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        UIApplication.shared.registerForRemoteNotifications()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            // Enable or disable features based on authorization.
        }
        center.delegate = self
        return true
    }

    // Called to let your app know which action was selected by the user for a given notification.
    func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.logger.info("App opened via user selecting notification: \(response.notification.request.content.body)")
        // Here is where you want to take action to handle the notification, maybe navigate the user to a given screen.
        completionHandler()
    }

    // Called when a notification is delivered to a foreground app.
    func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        self.logger.info("Remote Notification arrived while app was in foreground: \(notification.request.content.body)")
        // Currently we are presenting the notification alert as the application were in the background.
        // If you have handled the notification and do not want to display an alert, call the completionHandler with empty options: completionHandler([])
        completionHandler([.alert, .sound])
    }

    func registerForRemoteNotification(_ urlSession: SAPURLSession, _ settingsParameters: SAPcpmsSettingsParameters) {
        guard let deviceToken = self.deviceToken else {
            // Device token has not been acquired
            return
        }

        let remoteNotificationClient = SAPcpmsRemoteNotificationClient(sapURLSession: urlSession, settingsParameters: settingsParameters)
        remoteNotificationClient.registerDeviceToken(deviceToken) { error in
            if let error = error {
                self.logger.error("Register DeviceToken failed", error: error)
                return
            }
            self.logger.info("Register DeviceToken succeeded")
        }
    }

    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.deviceToken = deviceToken
    }

    func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.logger.error("Failed to register for Remote Notification", error: error)
    }

    // MARK: - Log uploading

    // This function is invoked on every application start, but you can reuse it to manually triger the logupload.
    private func uploadLogs(_ urlSession: SAPURLSession, _ settingsParameters: SAPcpmsSettingsParameters) {
        SAPcpmsLogUploader.uploadLogs(sapURLSession: urlSession, settingsParameters: settingsParameters) { error in
            if let error = error {
                self.logger.error("Error happened during log upload.", error: error)
                return
            }
            self.logger.info("Logs have been uploaded successfully.")
        }
    }

    // MARK: - Configure Offline OData

    private func configureOData(_ urlSession: SAPURLSession, _ serviceRoot: URL, _ onboarding: Bool) {
        var offlineParameters = OfflineODataParameters()
        offlineParameters.customHeaders = ["X-SMP-APPID": "com.sap.expense"]
        offlineParameters.enableRepeatableRequests = true
        // Setup an instance of delegate. See sample code below for definition of OfflineODataDelegateSample class.
        let delegate = OfflineODataDelegateSample()
        let offlineODataProvider = try! OfflineODataProvider(serviceRoot: serviceRoot, parameters: offlineParameters, sapURLSession: urlSession, delegate: delegate)
        // Although it is not the best practice, we are defining this query limit as top=20.
        // If the service supports paging, then paging should be used instead of top!
        let queryLimit = DataQuery().selectAll().top(20)
        if onboarding {
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.payment.localName, query: "/\(TravelexpenseMetadata.EntitySets.payment.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.reservation.localName, query: "/\(TravelexpenseMetadata.EntitySets.reservation.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.expense.localName, query: "/\(TravelexpenseMetadata.EntitySets.expense.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.expenseItem.localName, query: "/\(TravelexpenseMetadata.EntitySets.expenseItem.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.tripItem.localName, query: "/\(TravelexpenseMetadata.EntitySets.tripItem.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.reservationItem.localName, query: "/\(TravelexpenseMetadata.EntitySets.reservationItem.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.expenseReportItem.localName, query: "/\(TravelexpenseMetadata.EntitySets.expenseReportItem.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.currency.localName, query: "/\(TravelexpenseMetadata.EntitySets.currency.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.reportStatus.localName, query: "/\(TravelexpenseMetadata.EntitySets.reportStatus.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
        }
        DataHandler.shared.service = Travelexpense(provider: offlineODataProvider)
    }

    private func openOfflineStore(_ sync: Bool = false) {
        if sync {
            DispatchQueue.main.async {
                let openingOfflineInfoVC = FUIInfoViewController.createSplashScreenInstanceFromStoryboard()
                openingOfflineInfoVC.informationTextView.text = "Opening Offline Store."
                openingOfflineInfoVC.informationTextView.textColor = UIColor.black
                openingOfflineInfoVC.informationTextView.isHidden = false
                openingOfflineInfoVC.loadingIndicatorView.dismiss()
                self.window!.rootViewController = openingOfflineInfoVC
            }
            if !self.isOfflineStoreOpened {
                // The OfflineODataProvider needs to be opened before performing any operations.
                self.travelexpense.open { error in
                    if let error = error {
                        self.logger.error("*** Could not open offline store.", error: error)
                        DispatchQueue.main.async(execute: {
                            let errorOfflineInfoVC = FUIInfoViewController.createSplashScreenInstanceFromStoryboard()
                            errorOfflineInfoVC.informationTextView.text = "Opening Offline Store failed: \(error)"
                            errorOfflineInfoVC.informationTextView.textColor = UIColor.black
                            errorOfflineInfoVC.informationTextView.isHidden = false
                            errorOfflineInfoVC.loadingIndicatorView.dismiss()
                            self.window!.rootViewController = errorOfflineInfoVC
                        })
                        return
                    }
                    self.isOfflineStoreOpened = true
                    self.setRootViewController()
                    self.logger.info("*** Offline store opened.")
                    if sync {
                        self.uploadOfflineStore()
                        self.downloadOfflineStore()
                    }
                }
            }
        }
    }

    private func closeOfflineStore() {
        if self.isOfflineStoreOpened {
            do {
                // the Offline store should be closed when it is no longer used.
                try self.travelexpense.close()
                self.isOfflineStoreOpened = false
            } catch {
                self.logger.error("*** Offline Store closing failed.")
            }
        }
        self.logger.info("*** Offline Store closed.")
    }

    private func downloadOfflineStore() {
        if !self.isOfflineStoreOpened {
            self.logger.error("*** Offline Store still closed")
            return
        }
        // the download function updates the client’s offline store from the backend.
        self.travelexpense.download { error in
            if let error = error {
                self.logger.error("*** Offline Store download failed.", error: error)
                return
            }
            self.logger.info("*** Offline Store is downloaded.")
        }
    }

    private func uploadOfflineStore() {
        if !self.isOfflineStoreOpened {
            self.logger.error("*** Offline Store still closed")
            return
        }
        // the upload function updates the backend from the client’s offline store.
        self.travelexpense.upload { error in
            if let error = error {
                self.logger.error("*** Offline Store upload failed.", error: error)
                return
            }
            self.logger.info("*** Offline Store is uploaded.")
        }
    }
}

class OfflineODataDelegateSample: OfflineODataDelegate {
    private let logger = Logger.shared(named: "AppDelegateLogger")

    public func offlineODataProvider(_: OfflineODataProvider, didUpdateDownloadProgress progress: OfflineODataProgress) {
        self.logger.info("downloadProgress: \(progress.bytesSent)  \(progress.bytesReceived)")
    }

    public func offlineODataProvider(_: OfflineODataProvider, didUpdateFileDownloadProgress progress: OfflineODataFileDownloadProgress) {
        self.logger.info("downloadProgress: \(progress.bytesReceived)  \(progress.fileSize)")
    }

    public func offlineODataProvider(_: OfflineODataProvider, didUpdateUploadProgress progress: OfflineODataProgress) {
        self.logger.info("downloadProgress: \(progress.bytesSent)  \(progress.bytesReceived)")
    }

    public func offlineODataProvider(_: OfflineODataProvider, requestDidFail request: OfflineODataFailedRequest) {
        self.logger.info("requestFailed: \(request.httpStatusCode)")
    }

    // The OfflineODataStoreState is a Swift OptionSet. Use the set operation to retrieve each setting.
    private func storeState2String(_ state: OfflineODataStoreState) -> String {
        var result = ""
        if state.contains(.opening) {
            result = result + ":opening"
        }
        if state.contains(.open) {
            result = result + ":open"
        }
        if state.contains(.closed) {
            result = result + ":closed"
        }
        if state.contains(.downloading) {
            result = result + ":downloading"
        }
        if state.contains(.uploading) {
            result = result + ":uploading"
        }
        if state.contains(.initializing) {
            result = result + ":initializing"
        }
        if state.contains(.fileDownloading) {
            result = result + ":fileDownloading"
        }
        if state.contains(.initialCommunication) {
            result = result + ":initialCommunication"
        }
        return result
    }

    public func offlineODataProvider(_: OfflineODataProvider, stateDidChange newState: OfflineODataStoreState) {
        let stateString = storeState2String(newState)
        self.logger.info("stateChanged: \(stateString)")
    }
}

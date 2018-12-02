//
// AppDelegate.swift
// TravelExpenses
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 09/06/18
//

import UIKit
import UserNotifications

import SAPCommon
import SAPFiori
import SAPFioriFlows
import SAPFoundation
import SAPOData
import SAPOfflineOData


// -----------------------------------------------------------------------------

// Customize these for your Mobile Services application.

enum MobileServicesConfiguration {
    static let trialAccountName: String = <#SAP Cloud Platform account name#>
    static let applicationID: String = <#Application ID in Mobile Services#>
    static let destinationName: String = <#Destination name#>
}

// -----------------------------------------------------------------------------


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate, OnboardingManagerDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    private let logger = Logger.shared(named: "AppDelegateLogger")
    var travelexpense: Travelexpense<OfflineODataProvider> {
        return DataHandler.shared.service
    }
    private(set) var isOfflineStoreOpened = false

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Set a FUIInfoViewController as the rootViewController, since there it is none set in the Main.storyboard
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = FUIInfoViewController.createSplashScreenInstanceFromStoryboard()

        do {
            // Attaches a LogUploadFileHandler instance to the root of the logging system
            try SAPcpmsLogUploader.attachToRootLogger()
        } catch {
            self.logger.error("Failed to attach to root logger.", error: error)
        }

        //NUISettings.initWithStylesheet(name: "Palette")
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
        let configurationURL = URL(string: "https://hcpms-\(MobileServicesConfiguration.trialAccountName).hanatrial.ondemand.com/" + MobileServicesConfiguration.destinationName)!
        self.configureOData(onboardingContext.sapURLSession, configurationURL, onboarding)
        
        ImageHandler.createInstance(sapUrlSession: onboardingContext.sapURLSession, baseUrl: configurationURL)
    }

    func onboarded(onboardingContext: OnboardingContext) {
//        self.uploadLogs(onboardingContext.sapURLSession, onboardingContext.sapcpmsSettingsParameters!)
//        self.registerForRemoteNotification(onboardingContext.sapURLSession, onboardingContext.sapcpmsSettingsParameters!)
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

    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
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
        offlineParameters.customHeaders = ["X-SMP-APPID": MobileServicesConfiguration.applicationID]
        offlineParameters.enableRepeatableRequests = true
        // Setup an instance of delegate. See sample code below for definition of OfflineODataDelegateSample class.
        let delegate = OfflineODataDelegateSample()
        let offlineODataProvider = try! OfflineODataProvider(serviceRoot: serviceRoot, parameters: offlineParameters, sapURLSession: urlSession, delegate: delegate)
        let queryLimit = DataQuery().selectAll()
        if onboarding {
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.payments.localName, query: "/\(TravelexpenseMetadata.EntitySets.payments.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.reservations.localName, query: "/\(TravelexpenseMetadata.EntitySets.reservations.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.expenses.localName, query: "/\(TravelexpenseMetadata.EntitySets.expenses.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.expenseItems.localName, query: "/\(TravelexpenseMetadata.EntitySets.expenseItems.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.tripItems.localName, query: "/\(TravelexpenseMetadata.EntitySets.tripItems.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.reservationItems.localName, query: "/\(TravelexpenseMetadata.EntitySets.reservationItems.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.expenseReports.localName, query: "/\(TravelexpenseMetadata.EntitySets.expenseReports.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.currencies.localName, query: "/\(TravelexpenseMetadata.EntitySets.currencies.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.reportStati.localName, query: "/\(TravelexpenseMetadata.EntitySets.reportStati.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
            try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(name: TravelexpenseMetadata.EntitySets.expenseItemAttachments.localName, query: "/\(TravelexpenseMetadata.EntitySets.expenseItemAttachments.localName)\(queryLimit)", automaticallyRetrievesStreams: false))
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

    public func offlineODataProvider(_: OfflineODataProvider, stateDidChange newState: OfflineODataStoreState) {
        // See OfflineODataStoreState+Description.swift for the extension that
        // provides human-readable descriptions for offline store states.
        self.logger.info("stateChanged: \(newState)")
    }
}

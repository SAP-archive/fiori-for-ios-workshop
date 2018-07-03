# fiori-for-ios-workshop
Reference iOS application for SAP Fiori for iOS 2018 workshop series.

# Requirements
Use of the reference application is dependent upon the following:
 
 1. [SAP Cloud Platform SDK for iOS](https://www.sap.com/developer/trials-downloads/additional-downloads/sap-cloud-platform-sdk-for-ios-14485.html), version 2.0 SP02 or higher
 2. SAP Cloud Platform account ([trial](https://account.hanatrial.ondemand.com/cockpit#/home/trialhome) or production), with Mobile Services [Development & Operations](https://account.hanatrial.ondemand.com/cockpit#/home/service/mobileplatform2/overview) service
     - The application is validated on 'Neo' landscape, but should behave normally on Cloud Foundry landscape as well
 3. SAP Cloud Platform database (HANA MDC)
 4. Apple Xcode 9.3 
     - New versions of Xcode, including 10-beta will be supported on a rolling basis
 5. iOS 10 or 11
     - iOS 12-beta will be supported with Xcode 10-beta support

# License
Use of the code is governed by the terms of the SAP Developer License Agreement (see **LICENSE**, and **NOTICE**).

# Download and installation

## Tools installation
Developers should download the **SAP Cloud Platform SDK for iOS** ("the SDK"), and install the **SAP Cloud Plaform SDK for iOS Assistant** Mac application ("the Assistant").  From the Assistant, a developer can generate a new application, or **Export Frameworks** to access the SDK frameworks to link into an existing project.

Developers should have **Apple Xcode** ("Xcode") installed on the same machine as the Assistant, with the desired iOS simulators.

## Setup local repository
Clone the repository at TODO.

## Project setup
To run the reference app as-is, do the following:

 1. From the *SAP Cloud Platform SDK for iOS Assistant* menu, choose the *Export Frameworks* item to install the SDK frameworks to the `/frameworks` directory in the local repository.  
 
 2. Complete the "Install Database package" instructions below.

 3.  Create a new application in your Mobile Services instance, with app ID:  `com.sap.expense`.  Or, do a find-replace in the project for this ID, to match your preferred app ID.

 4. Do a find-replace of the host `hcpms-i826181trial.hanatrial.ondemand.com` in the project, substituting your own Mobile Services host.  (These are in **ConfigurationProvider.plist**, and **AppDelegate.swift**).

 //TODO: add screenshot of where to find this


### Install database package
Please follow the guide [here](https://github.com/SAP/fiori-for-ios-workshop/wiki/Install-Database-Package) to install the DatabasePackage.tgz found in the root of the repository.  This db will function as the backend of the mobile application.

### Create Mobile Application configuration in SAP Cloud Platform mobile services
Please follow the guide [here](https://github.com/SAP/fiori-for-ios-workshop/wiki/Create-Mobile-Application-in-SAP-Cloud-Platform-mobile-services-with-Assistant) to create a new application in mobile services, using the Assistant.

### Run the reference app

Ensure that all references to the app ID `com.sap.expense` that you used when creating the scaffolding app & destination on mobile services are consistent in the reference app project.  Also, ensure that all references to the host are correctly pointing to your SAP Cloud Platform host.

Then, you should be able to build & run.

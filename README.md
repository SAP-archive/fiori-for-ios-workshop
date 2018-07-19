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
Clone the repository at `https://github.com/SAP/fiori-for-ios-workshop.git`.

## Project setup

### Install backend service
Please follow the guide [here](https://github.com/SAP/fiori-for-ios-workshop/wiki/Install-SAPTravelExpense-war) to install the SAPTravelExpense.war found in the root of the repository.  This service will function as the backend of the mobile application.

### Create Mobile Application configuration in SAP Cloud Platform mobile services
To run the reference app in the repository, you will need a corresponding application configuration on SAP Cloud Platform Mobile Services.  Follow this procedure to create that application configuration.

Please follow the guide [here](https://github.com/SAP/fiori-for-ios-workshop/wiki/Create-Mobile-Application-in-SAP-Cloud-Platform-mobile-services-with-Assistant) to create a new application in mobile services, using the Assistant.

### Export Frameworks to the Reference App
Launch the Assistant.  From the *SAP Cloud Platform SDK for iOS Assistant* menu, choose the *Export Frameworks* item to install the SDK frameworks to the `/frameworks` directory in the local repository.  

### Run the Reference App
To point the reference application to the newly-created configuration, edit the following properties in `AppDelegate.swift`.

```swift
let TRIALACCOUNT: String = <#My Trial Account Name#> // e.g.: "i826181trial"
let APPLICATIONID: String = <#My Application ID#> // "com.sap.expense"
let DESTINATION: String = <#My Destination Name#> // "com.sap.expense" (does not need to match APPLICATIONID)
```

Then, you should be able to build & run.

# Limitations

 - Trips view controller does not navigate to trip details
 - Unable to edit properties on existing Expense Items
 - Attachment images are not stored to Expense Items

# Known Issues
None
# How to obtain support
Official support is not provided under the terms of the SAP Developer License Agreement.  For questions, please open an Issue on the project.
# Contributing
If you would like to contribute ideas or code to the project, please open an Issue, or a Pull Request.
> Project Administrators do not commit to integrating any contributions to the project.  Contributors acknowledge that by submitting the contribution, they waive all rights to any  Intellectual Property associated with the contribution, and that any contributions which are integrated to the project will be redistributed under the terms of the SAP Developer License Agreement, under copyright by SAP.
# To-Do (upcoming changes)

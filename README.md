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

To connect the **TravelExpenses** app target in the repository to the database you just setup, the last step is to configure the mobile application in SAP Cloud Platform mobile services.  You may login to the mobile services cockpit directly for the setup, but it is also informative to use the Assistant to create the configuration, while generating the scaffolding code for a new app on the service.

#### Add mobile services account to Assistant

You can always access **Accounts** by clicking on the 'gear' icon in the home screen of the Assistant to get to the **Settings** menu.  But, it is much simpler to setup the account by launching a link from the Mobile Services cockpit **Important Links** page.   

Login to SAP Cloud Platform, and navigate to the Mobile Services cockpit.  

![screen shot 2018-07-02 at 9 16 28 pm](https://user-images.githubusercontent.com/377404/42200041-69758664-7e46-11e8-9df3-ef2235aa1da7.png)

![screen shot 2018-07-02 at 9 16 35 pm](https://user-images.githubusercontent.com/377404/42200063-7d63ae76-7e46-11e8-82f5-4062f264c689.png)

![screen shot 2018-07-02 at 9 16 58 pm](https://user-images.githubusercontent.com/377404/42200064-7d7f02d4-7e46-11e8-9303-1c2818decaa8.png)

In the bottom left of the page, click on the **Important Links** tab.  

![screen shot 2018-07-02 at 9 17 08 pm](https://user-images.githubusercontent.com/377404/42200065-7d9832a4-7e46-11e8-9869-b5cf6d362bf7.png)

In section of the page entitled **SAP Cloud Platform SDK Tools**, click the link named **Importing URLs directly (only supported by iOS Assistant)**.  

You'll be prompted by a modal: "Do you want to allow this page to open "SAP Cloud Platform SDK for iOS Assistant?". 

![screen shot 2018-07-02 at 9 17 13 pm](https://user-images.githubusercontent.com/377404/42200066-7db1476c-7e46-11e8-8a57-ba52c8424e5b.png)

Click **Allow**, and the connection URLs will be imported into a new Account form in the Assistant.  

![](https://user-images.githubusercontent.com/377404/42200219-1259c97a-7e47-11e8-973e-e81c8dac3983.png)

Give the new account a name:  **Neo Trial**, and choose either *Basic Authentication* or *SAML*. 

![](https://user-images.githubusercontent.com/377404/42200220-127571ac-7e47-11e8-8bc5-4c38e7717b05.png)

If you choose Basic, supply the username & password that you use to authenticate to SAP Cloud Platform.  If you choose SAML, you'll be prompted to enter credentials later, when interacting with the SAP Cloud Platform services.

#### Create new Xcode project in Assistant

In the home screen of the Assistant, click the '+' button in the upper right to start a new xcode project.  On the **Project Properties** screen, select a product name:  **TE Scaffolding**, and click **Next**.

![](https://user-images.githubusercontent.com/377404/42200222-12a9464e-7e47-11e8-8d72-185717f56732.png)

On the **Cloud Configuration** screen, select the target Mobile Services Account from the dropdown.  In the **Create** form below, pick an Application Name: **Travel Expense Scaffolding**, and Application Identifier:  **com.sap.expense**.  Select Authentication Type:  **No Authentication**.

![](https://user-images.githubusercontent.com/377404/42200230-1386feee-7e47-11e8-9f4b-7f2efcbcca6e.png)

On the **OData Services** screen, click the '+' button to add a **New Destination**.  In the **Create New Destination** form on the **General** tab, select a Destination name:  **expensedb**. 

Enter the Backend URL of the `travelexpense.xsodata` service, that was validated above:  

    https://<database name><hana trial name>.hanatrial.ondemand.com/codejam/saptravelexpense/services/travelexpense.xsodata/

    e.g.:
    https://expensedbi826181trial.hanatrial.ondemand.com/codejam/saptravelexpense/services/travelexpense.xsodata/


![](https://user-images.githubusercontent.com/377404/42200224-12dc4daa-7e47-11e8-8faf-3b04bdc4b42c.png)

Explore the **Advanced destination options**, and ensure that the Proxy type is set to **Internet**, and URL rewrite mode is set to **Rewrite URL**.

***Before*** clicking OK, switch to the **Authentication** tab.  Pick **Basic Authentication** from the Authentication Type drop-down, and enter the username & password of the *Developer user* of the database (USER1).  

![](https://user-images.githubusercontent.com/377404/42200225-12f3c278-7e47-11e8-8f05-a7b3d77cbdd4.png)

Now, it is ok to click **OK**, then click **Next** on the OData Services screen.

On the **Optional Features** screen, leave the default options checked, except:  switch the OData Provider to **User Offline OData**.

![](https://user-images.githubusercontent.com/377404/42200226-1310909c-7e47-11e8-8cbf-536becc09fac.png)
![](https://user-images.githubusercontent.com/377404/42200227-133027cc-7e47-11e8-94ad-5a3a6dfa520b.png)

Click **Finish**.  An activity indicator will spin for several seconds, then a new Xcode application project will launch.

![](https://user-images.githubusercontent.com/377404/42200228-1348f112-7e47-11e8-96b5-bc05179f8421.png)

#### Run the generated project

To run the generated project, select a simulator, or, to run on device, select a **Development Team** in the target **Signing** settings.

![](https://user-images.githubusercontent.com/377404/42200381-d0978256-7e47-11e8-8106-23864ffb15ca.png)

You should go through the generated onboarding screens, then see a table view listing the collections in the travel expense schema.

![](https://user-images.githubusercontent.com/377404/42200447-1dc68fcc-7e48-11e8-9151-33090acf4716.png)

### Run the reference app

Ensure that all references to the app ID `com.sap.expense` that you used when creating the scaffolding app & destination on mobile services are consistent in the reference app project.  Also, ensure that all references to the host are correctly pointing to your SAP Cloud Platform host.

Then, you should be able to build & run.

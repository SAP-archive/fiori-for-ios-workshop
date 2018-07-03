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

#### Create Database
In [SAP Cloud Platform Cockpit](https://account.hanatrial.ondemand.com), **Neo Trial**, select **SAP HANA / SAP ASE > Database & Schemas**.  Click **New** to create a new Database.  

![](https://user-images.githubusercontent.com/377404/39138253-660b6538-46d4-11e8-9b41-74dbb286c8ec.png)

Enter name `expensedb` for the database, and create a **SYSTEM** user password.  Note that the system user password must be 15 char with lower/upper-cased characters.  ***Write this down, as you will need it in a later step***

Existing settings may be left as-is.  Click **Create** to create.

![](https://user-images.githubusercontent.com/377404/39138254-663f9416-46d4-11e8-9d20-7443e9d5091a.png)

You'll be navigated to the Events window, where you can monitor the creation status for the few minutes it will take to create the db.  

You may safely navigate from the Events window.  When completed, an Event will be created named `"Tenant DB creation finished successfully (created and configured)"`.

![](https://user-images.githubusercontent.com/377404/39138256-66822b46-46d4-11e8-9764-4b1ff5323f79.png)

#### Create DB Developer user, and grant permissions
The SYSTEM user should not be used for developing on the database, so you'll need to create a developer user which will have rights to import and publish the database package.

While on the **Database: expensesdb - Overview** page, click on the **Overview tab**, click on the **Administration Tools: SAP HANA Cockpit** link, and log-in with the SYSTEM user and password you created above.  

![](https://user-images.githubusercontent.com/377404/39138259-66a626ea-46d4-11e8-8d65-8e6304a88d41.png)

You'll be informed that you do not yet have the requisite privileges; click "OK", and they will be granted to you.  

![](https://user-images.githubusercontent.com/377404/39138260-66c68f5c-46d4-11e8-9283-050c12bcc23f.png)

When completed, you will land the **SAP HANA Database Administration** dashboard.

![](https://user-images.githubusercontent.com/377404/39138261-66fa1c6e-46d4-11e8-95ba-6d943e90397c.png)

Select **Manage Roles and Users**.

Navigate in the explorer to  **Security > Users > SYSTEM**, and CTRL+Click on **SYSTEM**.  Click on **Copy User**.  

![](https://user-images.githubusercontent.com/377404/39138263-6740b034-46d4-11e8-8654-44843724aa31.png)

A new userID will be proposed, and you need to supply a user password.  When submitted, the Job Log will indicate that they copy is in state "To be reviewed", and you can close the log box.

![](https://user-images.githubusercontent.com/377404/39138264-67647a1e-46d4-11e8-901c-d3f2b7d1a1af.png)

> Note:  the console may indicate that a number of privilege grants have failed due to insufficent privileges.  For the purpose of this project, you may ignore these warnings.

Switch to the newly created user (**USER1** by default) in **Security > Users**, switch to the **Granted Roles** tab, and click the TODO: add plus button icon)() button to add privileges.  

![](https://user-images.githubusercontent.com/377404/39138266-67b098f4-46d4-11e8-8948-453e6962738e.png)

Your developer user should have Administration and Developer privileges.  For convenience, we'll add all of both category.

Search for the string `ADMIN`, select all results, and click "OK".  

![](https://user-images.githubusercontent.com/377404/39138267-67d975d0-46d4-11e8-9fca-0f76f9ee425e.png)

Repeat this process for the search string: `Developer`.  'Command+S' to save the changes to your new user.

#### Switch to new user, and import Delivery Unit

Make sure you remember your passwords for both **SYSTEM** and your new developer user (**USER1**).  You'll need to switch between them.  

Click the 'power' button in the upper right to log-out as **SYSTEM**, so that you can log back in as **USER1** (or your own Developer user ID).

After logging out as **SYSTEM**, enter the user ID and password of your Developer user to log in as your Developer (**USER1**).  You'll immediately be prompted to change the Developer user's password.

![](https://user-images.githubusercontent.com/377404/39138268-67fb9188-46d4-11e8-932e-cf01ac7606d4.png)

Once successful, you can close this window, and return to the SAP Cloud Platform Cockpit > Database Overview page from above.  Now, navigate to **Administration Tools: SAP HANA Cockpit**.  Scroll down on the dashboard, and select **SAP HANA Application Lifecycle Management > Manage Products and Delivery Units**.

![](https://user-images.githubusercontent.com/377404/39138273-68919304-46d4-11e8-8ef3-9b8416e1533d.png)

Switch to the **Products > Delivery Units** tab, and click **Import**.  Click the **Browse** button to locate and select the Delivery Unit file named **DatabasePackage.tgz** in the root of the repository.  Click through the **Confirm Import** page.  When successful, the view will refresh momentarily, and you should see a new Delivery Unit named **SAPDEVS_expensedb**, and it should own a set of Packages with prefix of **`codejam.saptravelexpense`**.

![](https://user-images.githubusercontent.com/377404/39151086-158437d2-46f9-11e8-8b8c-9f9e41b014d6.png)

#### Grant codejam privileges to USER1

Log out again, and log back in as **SYSTEM** user.  

> If you get a 403 error, close the current window, and switch back to the **SAP HANA Cockpit** page.  Try logout from this page.  In some cases, upon logging out as USER1, the cookie state in the browser will immediately log you back in correctly as SYSTEM, in which case you can proceed.

In the **SAP HANA Database Administration** dashboard, select **Manage Roles and Users**.  In the **SAP HANA Web-based Developent Workbench: Security** tool, select **USER1**, and switch to the **Granted Roles** tab.  

![](https://user-images.githubusercontent.com/377404/39138274-68b0debc-46d4-11e8-9d30-fc33f16fb726.png)

Click the 'plus' button, and search for the string `codejam`.  

![](https://user-images.githubusercontent.com/377404/39138275-68cffd42-46d4-11e8-8ab4-04aa3c0011e8.png)

Select the available role, and click "OK".  Save.

Log out of **SYSTEM** user (for the last time), and back-in as **USER1** (or your userID)

#### Verify connectivity via OData
At this point, your user should be able to access the database via OData.  To verify this try the following URL:

```
https://<database name><hana trial name>.hanatrial.ondemand.com/codejam/saptravelexpense/services/travelexpense.xsodata/expensereport

//e.g.:
https://expensedbi826181trial.hanatrial.ondemand.com/codejam/saptravelexpense/services/travelexpense.xsodata/expensereport
```

You should see a regular OData response, with one or more expense report entries.

![](https://user-images.githubusercontent.com/377404/39138356-95ea81b2-46d4-11e8-8899-92a4a0e93085.png)

You may also use a REST client, such as Postman, which can provide Basic auth headers.

> If you receive an authorization error (403), make sure you have logged out as SYSTEM, and are logged in as USER1 (or your own Developer userID)

> If you receive privileges error (258), go back to the USER1 role granting for "codejam", and ensure it was properly added.

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

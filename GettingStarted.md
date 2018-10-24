# Getting Started

This guide will help you setup all necessary components to run our reference application. 

## Install Sample Expense Data

We're using a predefined Java Application Backend you can host in your Neo Trial Cloud landscape. You can connect whatever application you're building against this backend service if you want to.

Open a browser window to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome

Click on **Neo Trial** to enter the **Neo Trial landscape** on the SAP Cloud Platform.

![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/NeoTrial.png)

Next, click on **Applications** and then **Java Applications**.

![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/JavaApplications_deploy.png)

To deploy a new Java application, click on **Deploy Application**. A new Pop-up should appear.

![Backend-setup-cloud](https://user-images.githubusercontent.com/28980634/47416270-9f62d500-d775-11e8-87ce-af6c32d44012.png)

From here click on **Browse** and navigate to your local version of the cloned repository. Select the **SAPTravelExpense.war** file and click **Choose**.

![Backend-setup-cloud](https://user-images.githubusercontent.com/28980634/47416042-18156180-d775-11e8-9e28-4341ec0c254e.png)

Now you have to select a Runtime where your backend should run on. For this sample Java Backend we're using the **Java Web Tomcat 8** runtime.
Under the **Runtime Name** dropdown menu, select the **Java Web Tomcat 8** runtime and leave the rest as it is.

![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/UpdateApplication.png)

Click the **Deploy** button at the bottom of the window to start the deployment of the .war file.

After the deployment finishes you have to start your application by clicking the **Start** button at the bottom of the window.

![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/UpdateApplication_success.png)

Now the SAP Cloud Platform starts the Java Application so you can use it as a backend.

Once the application transitions from **Starting** to **Started** your application is up and running.


![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/JavaApplications_started.png)

To verify the services data click on the name **saptravelexpense** and click on the link under **Applications URLs** to open the **Service Document** of the OData Service.

![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/JavaApplication_overview.png)
![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/ServiceRoot.png)

Copy the URL for use as the **Backend URL** in the following steps.

## Generate an Travel Expense Application

After deploying and starting the Travel Expense backend we could setup the reference application and the **Mobile Services, std** configuration now. As we want to develop our own application later on we will use the **SAP Cloud Platform SDK for iOS Assistant** to create the **Mobile Services, std** configuration and an Entity Viewer Application. This generated application you can use later on to build your own Travel Expense app.

### Enable Mobile Services

First you have to activate the **Mobile Services, std** in your Neo Trial Cloud landscape. For that open a browser window to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome and select **Neo Trial**.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/47416873-f4531b00-d776-11e8-940e-082b2ba73563.png)

Next click on **Services** in the left navigation panel.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/47416872-f4531b00-d776-11e8-9e06-b2dfb809211b.png)

Use the search field to search for **Mobile** on this page.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/47416871-f4531b00-d776-11e8-9d5f-dca8bbd8cc36.png)


Click on **Mobile Services, std** and if not enabled yet, click on **Enable**.

> Note: This may take a while so no worries!

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/47416870-f4531b00-d776-11e8-9088-c616695b659f.png)

After enabling the service or if already enabled, click on **Go to Service** to open **SAP Cloud Platform Mobile Services**.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200064-7d7f02d4-7e46-11e8-9303-1c2818decaa8.png)

### Configure the SAP Cloud Platform SDK for iOS Assistant

To configure the **SAP Cloud Platform SDK for iOS Assistant** go to **Important Links** and click **Importing URLs directly**.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200065-7d9832a4-7e46-11e8-9869-b5cf6d362bf7.png)

The **SAP Cloud Platform SDK for iOS Assistant** will launch and prompt you to complete the entry of your account information.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200066-7db1476c-7e46-11e8-8a57-ba52c8424e5b.png)

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/46350397-f7b22580-c654-11e8-9e3e-1caa99baf740.png)
Enter the following information:

| Field | Information |
| --- | --- |
| Name | *Mobile Services on Neo Trial*  |
| Authentication | *SAML* |

For Authentication choose SAML and click **Save**.



Click **Back** to return to the main page of the assistant.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/46350396-f7b22580-c654-11e8-8313-283eec510d0a.png)

### Create your first Xcode Project

Click the **Create new** button.

![Entity-Viewer]()

To create a new application, click **Create New Application**.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/47417490-5d875e00-d778-11e8-914d-897504ea3d41.png)

Select **Mobile Services on Neo Trial** for the **Account** and click **Next**.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/46350624-8030c600-c655-11e8-8694-bf3bb2c16efe.png)

The next configuration will create a **SAP Cloud Platform Mobile Services** application for you.

Enter the following information:

| Field | Information |
| --- | --- |
| Name | *TE Scaffolding*  |
| Identifier | *com.sap.expense* |

Select **None** from the **Authentication** dropdown menu and click **Next**.

> Note: The identifier is important to get the reference Application working later.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/46354829-d6a30200-c65f-11e8-9d2d-93a0414821a7.png)

In the next step you need to define a **Destination** to your backend. As we just started our backend in the previous section we have to create a new destination here.

Click **Add new**

Enter the following information in the corresponding fields:

| Field | Information |
| --- | --- |
| Name | *expensedb*  |
| Backend URL | *Paste in the URL from the previous section* |

Choose **No Authentication** from the **Authentication Type** dropdown and click **Save**.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/46355123-7b254400-c660-11e8-8fe3-68c6b14bd736.png)

To continue with the project creation click **Next**.


![Entity-Viewer](https://user-images.githubusercontent.com/28980634/46355518-3ea61800-c661-11e8-8a91-bdbc6ef5e413.png)


On the Features screen, leave the default options checked, except: switch the OData Provider to Use Offline OData. Than click **Next**.

This step will have all the information for your Xcode Project later on, so please enter the following information:

| Field | Information |
| --- | --- |
| Product Name | *TravelExpense*  |
| Organization Name | *Your Company* |
| Organization Identifier | *Your Company* |

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/46355697-9fcdeb80-c661-11e8-9383-fc64002459ee.png)

Select a path where you want to create your Xcode project and click **Finish**.

> Note: You could set those fields to whatever you want.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200228-1348f112-7e47-11e8-96b5-bc05179f8421.png)

### Run your generated application

Xcode should automatically open with your just created project.

To run your application on a simulator, choose the **iPhone X** scheme and click the **Run** button.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200381-d0978256-7e47-11e8-8106-23864ffb15ca.png)

After the Simulator has started your application should be visible. The first steps to explore the life data in your application is to go through the on-boarding process. Click **Start** to begin.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/47418834-367e5b80-d77b-11e8-8873-f5a28a1ca370.png)

After the on-boarding process you can now explore the life data from your deployed backend.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200447-1dc68fcc-7e48-11e8-9151-33090acf4716.png)

## Configure the Travel Expense Application

In the previous steps you did all necessary steps to now configure our reference app.

In the **Finder**, navigate to the local directory where you placed the cloned version of the **Travel Expense** project.

Open the Xcode project file titled **TravelExpenses.xcodeproj**.

### Export Frameworks to the Xcode Project

Open the **SAP Cloud Platform SDK for iOS Assistant**.

![Reference-App](https://user-images.githubusercontent.com/28980634/47417490-5d875e00-d778-11e8-914d-897504ea3d41.png)

From the **SAP Cloud Platform SDK for iOS Assistant** menu, select the **Export Frameworks...** menu item.

![Reference-App](https://user-images.githubusercontent.com/28980634/47419433-798cfe80-d77c-11e8-8d34-49039ff1332a.png)

Select the **frameworks** directory inside the **Travel Expense** folder and click **Export**.

![Reference-App](https://user-images.githubusercontent.com/28980634/47424847-ec03db80-d788-11e8-9837-488c3e8bec7c.png)

### Replace the placeholder values

Click on the **AppDelegate.swift** file in the Xcode project navigator.

Scroll to the configuration value placeholders.

![Reference-App](https://user-images.githubusercontent.com/28980634/47419837-5747b080-d77d-11e8-9b85-baa4cdd00c6e.png)

Set the value of the **TRIALACCOUNT** string to your account name.

This value is displayed after navigating to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome and clicking on **Neo Trial**. The name should look something like **p1942218264trial**



Set the value of the **APPLICATIONID** string to "com.sap.expense".

Set the value of the **DESTINATION** string to "expensedb".

> Note: If you have chosen your own names in the previous sections you have to make sure to set the correct values here.

![Reference-App](https://user-images.githubusercontent.com/28980634/47419949-96760180-d77d-11e8-88d8-5ff7c7b9275d.png))

Click the **Run** button in Xcode to run your copy of the *TravelExpense* app.

![Reference-App](https://user-images.githubusercontent.com/28980634/47420435-b659f500-d77e-11e8-893e-018cfe152999.png)

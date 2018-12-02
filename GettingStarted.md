# Getting Started

This guide will help you set up all necessary components to explore OData, generate a minimal app with the Assistant, and run the reference app in this repository.

This page is broken into the following sections:

1. Clone this Repository
2. Install Sample Expense Data
3. Generate a Minimal Entity Viewer App for Expense Data
4. Configure Pre-built Travel Expense App

## Clone this Repository

In order to complete the steps outlined below, you’ll want to have a copy of this repository dowloaded to your Mac. To clone this repository, open Xcode and choose **Clone…** from the **Source Control** menu. Paste in the URL for this repository and click **Clone**. After you’ve cloned this repository, you can close the Xcode project and continue with the following steps.

![Clone-repository](https://user-images.githubusercontent.com/9074514/48091264-1066ab80-e1be-11e8-9ea1-db7e3fe4a938.png)

## Install Sample Expense Data

To provide a database for our app, we’re using a predefined Java Application backend you can host in your Neo Trial Cloud landscape.

Open a browser window to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome

Click on **Neo Trial** to enter the **Neo Trial landscape** on the SAP Cloud Platform.

![Backend-setup-cloud](https://user-images.githubusercontent.com/9074514/48112076-9825d780-e209-11e8-8727-61e66f444b36.png)

Next, click on **Applications** and then **Java Applications**.

![Backend-setup-cloud](https://user-images.githubusercontent.com/9074514/48163954-fb5d4b80-e295-11e8-8a16-02e271538b21.png)

To deploy a new Java application, click on **Deploy Application**. A new form should appear.

![Backend-setup-cloud](https://user-images.githubusercontent.com/9074514/48111954-f1413b80-e208-11e8-8034-e3b885fd7fd4.png)

From here click on **Browse** and navigate to your local version of the cloned repository. Select the **SAPTravelExpense.war** file and click **Choose**.

![Backend-setup-cloud](https://user-images.githubusercontent.com/28980634/47416042-18156180-d775-11e8-9e28-4341ec0c254e.png)

Next you’ll select a Runtime where your backend should run. For this sample Java Backend we're using the **Java Web Tomcat 8** runtime. Under the **Runtime Name** dropdown menu, select the **Java Web Tomcat 8** runtime and leave the rest as it is.

![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/UpdateApplication.png)

Click the **Deploy** button at the bottom of the window to start the deployment of the .war file.

After the deployment finishes, start your backend application by clicking the **Start** button at the bottom of the window.

![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/UpdateApplication_success.png)

The SAP Cloud Platform will now start the Java Application so you can use it as a backend. This may take a few minutes.

![Backend-setup-cloud](https://user-images.githubusercontent.com/9074514/48111928-c9ea6e80-e208-11e8-86d4-f7bcf0eea6ec.png)

Once the application transitions from **Starting** to **Started** your backend is up and running.

![Backend-setup-cloud](https://user-images.githubusercontent.com/9074514/48111976-10d86400-e209-11e8-875e-f4410bda8ec8.png)

To verify the service data, click on the name **saptravelexpense** and click on the link under **Application URLs** to open the **Service Document** of the OData Service.

![Backend-setup-cloud](https://user-images.githubusercontent.com/9074514/48112003-40876c00-e209-11e8-9577-45c94aae1e86.png)

Here you can review the structure of the backend data model and alter the service URL in the browser to explore the data.

![Backend-setup-cloud](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/ServiceRoot.png)

Finally, copy the browser URL for use as the **Backend URL** in the following steps.

## Generate a Minimal Entity Viewer App for Expense Data

Now that you have a backend service, you will need to create an application configuration in **Mobile Services** to enable access for iOS apps. Since you will be developing your own Travel Expense app later on, you can use the **SAP Cloud Platform SDK for iOS Assistant** to create a new app, which will also create the Mobile Services configuration for you. You can then extend the generated app to build your own full-featured Travel Expense app.

### Enable Mobile Services

First, you will need to activate **Mobile Services** in your Neo Trial Cloud landscape. Open a browser window to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome and select **Neo Trial**.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48112076-9825d780-e209-11e8-8727-61e66f444b36.png)

Next click on **Services** in the left navigation panel.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48112094-b8ee2d00-e209-11e8-8a5f-05b8478f48c3.png)

Use the search field to search for **Mobile** on this page.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48112123-e3d88100-e209-11e8-8ed2-03e62d9ddfb8.png)

Click on **Mobile Services, std**, and if it is not enabled yet, click on **Enable**. Note that this may take a few minutes to start up.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48112152-0ff40200-e20a-11e8-8441-53d0b577aff9.png)

Once the service is enabled, click on **Go to Service** to open the **SAP Cloud Platform Mobile Services** window.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200064-7d7f02d4-7e46-11e8-9303-1c2818decaa8.png)

### Configure the SAP Cloud Platform SDK for iOS Assistant

To configure the **SAP Cloud Platform SDK for iOS Assistant**, go to **Important Links** and click on the **Importing URLs directly** link.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200065-7d9832a4-7e46-11e8-9869-b5cf6d362bf7.png)

The **SAP Cloud Platform SDK for iOS Assistant** will launch and prompt you to complete the entry of your account information.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200066-7db1476c-7e46-11e8-8a57-ba52c8424e5b.png)

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48164253-d1585900-e296-11e8-9470-90932d744b3a.png)
Enter the following information:

| Field          | Information                     |
| -------------- | ------------------------------- |
| Name           | *Mobile Services on Neo Trial*  |
| Authentication | *SAML*                          |

Click **Back** to return to the main page of the assistant.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48164334-082e6f00-e297-11e8-8610-92de6fd36549.png)

### Create your first Xcode Project

Click the **Create new** button.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/47417490-5d875e00-d778-11e8-914d-897504ea3d41.png)

To create a new application, click **Create New Application**.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48164443-5c395380-e297-11e8-9eaa-d3f2201d0dca.png)

Select **Mobile Services on Neo Trial** for the **Account** and click **Next**.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48112200-4b8ecc00-e20a-11e8-87c9-4d06011a2777.png)

The next configuration step will create a **SAP Cloud Platform Mobile Services** application configuration for you.

Enter the following information:

| Field      | Information                                   |
| ---------- | --------------------------------------------- |
| Name       | *MyMobileCloudServiceApplication*             |
| Identifier | *com.example.MyMobileCloudServiceApplication* |

Select **No Authentication** from the **Authentication** pop-up menu and click **Next**. Take note of the identifier; it is important to get the Travel Expense app in this repository working later.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48091993-3f7e1c80-e1c0-11e8-8908-174569e1aee1.png)

In the next step you need to define a **Destination** to your backend. As you just started your new backend in the previous section, you need to create a new destination to the backend here.

Click **Add new**.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48164520-973b8700-e297-11e8-97e5-5886518be575.png)

Enter the following information in the corresponding fields:

| Field       | Information                                  |
| ----------- | -------------------------------------------- |
| Name        | *ExpenseDestination*                         |
| Backend URL | *Paste in the URL from the previous section* |

Choose **No Authentication** from the **Authentication Type** pop-up menu and click **Save**.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48092068-748a6f00-e1c0-11e8-89f3-ebb8c40eca6d.png)

To continue with the project creation click **Next**.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48092197-e1056e00-e1c0-11e8-96e4-b6371307405d.png)

For this step select **Enable Offline Data**, keep all the other defaults, and click **Next**.

![Entity-Viewer](https://user-images.githubusercontent.com/28980634/46355518-3ea61800-c661-11e8-8a91-bdbc6ef5e413.png)

This step populates the information in your Xcode project. Enter the following:

| Field                   | Information           |
| ----------------------- | --------------------- |
| Product Name            | *MyTravelExpense*     |
| Organization Name       | *Your Company Name*   |
| Organization Identifier | *com.yourcompanyname* |

Select a path where you want to create your Xcode project and click **Finish**.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48112381-18990800-e20b-11e8-978d-20b9a5a3fb15.png)

### Run your generated application

Xcode should automatically open your newly created project.

To run your application in the iOS simulator, choose the **iPhone XR** simulator from the device list at the top of the window, and click the **Run** button.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48112636-2307d180-e20c-11e8-8607-24b55a99674a.png)

To log on, enter your SAP Cloud Platfrom account username and password.

![Entity-Viewer](https://user-images.githubusercontent.com/9074514/48092356-4bb6a980-e1c1-11e8-8201-f0e82ade7753.png)

The onboarding screens will now be presented. You will be prompted to set a passcode for your app.

> **Note:** To bypass requests for your passcode with every launch, turn on biometric authentication by selecting both **Face ID > Enrolled** and **Face ID > Matching Face** from the **Hardware** menu in the **Simulator** app, before you set your passcode.

Once you have set a passcode, you’ll land on the main app screen, where you can explore the data on your deployed backend.

![Entity-Viewer](https://user-images.githubusercontent.com/377404/42200447-1dc68fcc-7e48-11e8-9151-33090acf4716.png)

Because this minimal iOS app has all the sample code required to query, create, and modify expense entities, you can use it as the base for implementing your own views leveraging Fiori for iOS controls.

## Configure Pre-built Travel Expense App

You can leverage the backend data and cloud application created in the previous steps to configure the pre-built Travel Expense sample in this repository.

In the **Finder**, navigate to the local folder where you placed the cloned version of the **Travel Expense** repository.

Open the Xcode project file titled **TravelExpenses.xcodeproj**.

### Replace the placeholder values

Click on the **AppDelegate.swift** file in the Xcode project navigator.

Scroll to the configuration value placeholders.

![Reference-App](https://user-images.githubusercontent.com/9074514/48164684-129d3880-e298-11e8-9f97-2aeec0db03fc.png)

Set the value of the **trialAccountName** string to your account name.

This value is displayed after navigating to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome and clicking on **Neo Trial**. The name should look something like **p1987654321trial**

![Reference-App](https://user-images.githubusercontent.com/9074514/48092778-79e8b900-e1c2-11e8-8904-2ce5f9139b1f.png)

Set the value of the **applicationID** string to `"com.example.MyMobileCloudServiceApplication"`.

Set the value of the **destinationName** string to `"ExpenseDestination"`.

> **Note:** If you have chosen your own names in the previous sections, be sure to set the correct values here.

![Reference-App](https://user-images.githubusercontent.com/9074514/48092884-bd432780-e1c2-11e8-8197-ac497999caf2.png)

### Export Frameworks to the Xcode Project

Open the **SAP Cloud Platform SDK for iOS Assistant**.

![Reference-App](https://user-images.githubusercontent.com/28980634/47417490-5d875e00-d778-11e8-914d-897504ea3d41.png)

From the **SAP Cloud Platform SDK for iOS Assistant** menu, select the **Export Frameworks...** menu item.

![Reference-App](https://user-images.githubusercontent.com/9074514/48164756-48dab800-e298-11e8-92b9-44d291b266c4.png)

Select the **frameworks** folder inside the **Travel Expense** folder and click **Export**.

![Reference-App](https://user-images.githubusercontent.com/28980634/47424847-ec03db80-d788-11e8-9837-488c3e8bec7c.png)

Click the **Run** button in Xcode to run your copy of the *TravelExpense* app.

![Reference-App](https://user-images.githubusercontent.com/9074514/48164802-745da280-e298-11e8-83b4-ffa7e9990d6f.png)

After the Simulator has started, the TravelExpense app will launch. Click **Start** to begin.

![Reference-App](https://user-images.githubusercontent.com/9074514/48164885-c0a8e280-e298-11e8-9783-3af29df235c0.png)

You’re done! Tap through the on-boarding screens, enter a passcode, and review the TravelExpense sample app.  Like the minimal app you created in the previous section, this app demonstrates query and expense creation and modification techniques. This sample goes further, however, in that it also includes code examples demonstrating how to implement Fiori controls and connect them to the backend expense data.

![Reference-App](https://user-images.githubusercontent.com/28980634/47420435-b659f500-d77e-11e8-893e-018cfe152999.png)

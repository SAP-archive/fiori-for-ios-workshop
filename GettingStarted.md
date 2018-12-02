# Getting Started

This guide will help you set up all necessary components to explore OData, generate a minimal app with the Assistant, and run the reference app in this repository.

This page is broken into the following sections:

1. Clone this Repository
2. Install Sample Expense Data
3. Generate a Minimal Entity Viewer App for Expense Data
4. Configure Pre-built Travel Expense App

## Clone this Repository

In order to complete the steps outlined below, you’ll want to have a copy of this repository dowloaded to your Mac. To clone this repository, open Xcode and choose **Clone…** from the **Source Control** menu. Paste in the URL for this repository and click **Clone**. After you’ve cloned this repository, you can close the Xcode project and continue with the following steps.

![Cloning from GitHub](https://user-images.githubusercontent.com/9074514/48091264-1066ab80-e1be-11e8-9ea1-db7e3fe4a938.png)

## Install Sample Expense Data

To provide a database for our app, we’re using a predefined Java Application backend you can host in your Neo Trial Cloud landscape.

Open a browser window to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome

Click on **Neo Trial** to enter the **Neo Trial landscape** on the SAP Cloud Platform.

![SAP Cloud Platform Cockpit](https://user-images.githubusercontent.com/9074514/48112076-9825d780-e209-11e8-8727-61e66f444b36.png)

Next, click on **Applications** and then **Java Applications**.

![Java Applications](https://user-images.githubusercontent.com/9074514/48163954-fb5d4b80-e295-11e8-8a16-02e271538b21.png)

To deploy a new Java application, click on **Deploy Application**. A new form should appear.

![Deploy Application form](https://user-images.githubusercontent.com/9074514/48111954-f1413b80-e208-11e8-8034-e3b885fd7fd4.png)

From here click on **Browse** and navigate to your local version of the cloned repository. Select the **SAPTravelExpense.war** file and click **Choose**.

![Browse for WAR file](https://user-images.githubusercontent.com/28980634/47416042-18156180-d775-11e8-9e28-4341ec0c254e.png)

Next you’ll select a Runtime where your backend should run. For this sample Java Backend we're using the **Java Web Tomcat 8** runtime. Under the **Runtime Name** dropdown menu, select the **Java Web Tomcat 8** runtime and leave the rest as it is.

![Runtime set to Tomcat 8](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/UpdateApplication.png)

Click the **Deploy** button at the bottom of the window to start the deployment of the .war file.

After the deployment finishes, start your backend application by clicking the **Start** button at the bottom of the window.

![Successful deployment dialog](https://raw.githubusercontent.com/wiki/SAP/fiori-for-ios-workshop/images/UpdateApplication_success.png)

The SAP Cloud Platform will now start the Java Application so you can use it as a backend. This may take a few minutes.

![Starting Java Application](https://user-images.githubusercontent.com/9074514/48111928-c9ea6e80-e208-11e8-86d4-f7bcf0eea6ec.png)

Once the application transitions from **Starting** to **Started** your backend is up and running.

![Started Java Application](https://user-images.githubusercontent.com/9074514/48111976-10d86400-e209-11e8-875e-f4410bda8ec8.png)

To verify the service data, click on the name **saptravelexpense** and click on the link under **Application URLs** to open the **Service Document** of the OData Service.

![Java Application Overview page](https://user-images.githubusercontent.com/9074514/48112003-40876c00-e209-11e8-9577-45c94aae1e86.png)

Here you can review the structure of the backend data model and alter the service URL in the browser to explore the data.

![OData service XML](https://user-images.githubusercontent.com/9074514/49339338-11241d80-f656-11e8-9d72-aa290ab55b26.png)

Finally, copy the browser URL for use as the **Backend URL** in the following steps.

## Generate a Minimal Entity Viewer App for Expense Data

Now that you have a backend service, you will need to create an application configuration in **Mobile Services** to enable access for iOS apps. Since you will be developing your own Travel Expense app later on, you can use the **SAP Cloud Platform SDK for iOS Assistant** to create a new app, which will also create the Mobile Services configuration for you. You can then extend the generated app to build your own full-featured Travel Expense app.

### Enable Mobile Services

First, you will need to activate **Mobile Services** in your Neo Trial Cloud landscape. Open a browser window to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome and select **Neo Trial**.

![SAP Cloud Platform Cockpit](https://user-images.githubusercontent.com/9074514/48112076-9825d780-e209-11e8-8727-61e66f444b36.png)

Next click on **Services** in the left navigation panel.

![Services for trial account](https://user-images.githubusercontent.com/9074514/48112094-b8ee2d00-e209-11e8-8a5f-05b8478f48c3.png)

Use the search field to search for **Mobile** on this page.

![Searching for mobile services](https://user-images.githubusercontent.com/9074514/48112123-e3d88100-e209-11e8-8ed2-03e62d9ddfb8.png)

Click on **Mobile Services, std**, and if it is not enabled yet, click on **Enable**. Note that this may take a few minutes to start up.

![Mobile Services enabled](https://user-images.githubusercontent.com/9074514/48112152-0ff40200-e20a-11e8-8441-53d0b577aff9.png)

Once the service is enabled, click on **Go to Service** to open the **SAP Cloud Platform Mobile Services** window.

![Mobile Services Home](https://user-images.githubusercontent.com/377404/42200064-7d7f02d4-7e46-11e8-9303-1c2818decaa8.png)

### Configure the SAP Cloud Platform SDK for iOS Assistant

To configure the **SAP Cloud Platform SDK for iOS Assistant**, go to **Important Links** and click on the **Importing URLs directly** link.

![Mobile Services Important Links](https://user-images.githubusercontent.com/377404/42200065-7d9832a4-7e46-11e8-9869-b5cf6d362bf7.png)

The **SAP Cloud Platform SDK for iOS Assistant** will launch and prompt you to complete the entry of your account information.

![Open URL in Assistant dialog](https://user-images.githubusercontent.com/377404/42200066-7db1476c-7e46-11e8-8a57-ba52c8424e5b.png)

![Add Mobile Services Account dialog in Assistant](https://user-images.githubusercontent.com/9074514/48164253-d1585900-e296-11e8-9470-90932d744b3a.png)

Enter the following information:

| Field          | Information                     |
| -------------- | ------------------------------- |
| Name           | *Mobile Services on Neo Trial*  |
| Authentication | *SAML*                          |

Click **Save**, and then click **Back** to return to the main page of the assistant.

![Manage Accounts view in Assistant](https://user-images.githubusercontent.com/9074514/48164334-082e6f00-e297-11e8-8610-92de6fd36549.png)

### Create your first Xcode Project

Click the **Create new** button.

![First Steps view of Assistant](https://user-images.githubusercontent.com/28980634/47417490-5d875e00-d778-11e8-914d-897504ea3d41.png)

To create a new application, click **Create New Application**.

![Create New Application button](https://user-images.githubusercontent.com/9074514/48164443-5c395380-e297-11e8-9eaa-d3f2201d0dca.png)

Select **Mobile Services on Neo Trial** for the **Account** and click **Next**.

![Select Mobile Services account](https://user-images.githubusercontent.com/9074514/48112200-4b8ecc00-e20a-11e8-87c9-4d06011a2777.png)

The next configuration step will create a **SAP Cloud Platform Mobile Services** application configuration for you.

Enter the following information:

| Field      | Information                                   |
| ---------- | --------------------------------------------- |
| Name       | *MyMobileCloudServiceApplication*             |
| Identifier | *com.example.MyMobileCloudServiceApplication* |

Select **No Authentication** from the **Authentication** pop-up menu and click **Next**. Take note of the identifier; it is important to get the Travel Expense app in this repository working later.

![Configure Application Details](https://user-images.githubusercontent.com/9074514/48091993-3f7e1c80-e1c0-11e8-8908-174569e1aee1.png)

In the next step you need to define a **Destination** to your backend. As you just started your new backend in the previous section, you need to create a new destination to the backend here.

Click **Add new**.

![Destination list](https://user-images.githubusercontent.com/9074514/48164520-973b8700-e297-11e8-97e5-5886518be575.png)

Enter the following information in the corresponding fields:

| Field       | Information                                  |
| ----------- | -------------------------------------------- |
| Name        | *ExpenseDestination*                         |
| Backend URL | *Paste in the URL from the previous section* |

Choose **No Authentication** from the **Authentication Type** pop-up menu and click **Save**.

![Add Destination dialog](https://user-images.githubusercontent.com/9074514/48092068-748a6f00-e1c0-11e8-89f3-ebb8c40eca6d.png)

To continue with the project creation click **Next**.

![Destination list with new destination](https://user-images.githubusercontent.com/9074514/48092197-e1056e00-e1c0-11e8-96e4-b6371307405d.png)

For this step select **Enable Offline Data**, keep all the other defaults, and click **Next**.

![Configure Features](https://user-images.githubusercontent.com/28980634/46355518-3ea61800-c661-11e8-8a91-bdbc6ef5e413.png)

This step populates the information in your Xcode project. Enter the following:

| Field                   | Information           |
| ----------------------- | --------------------- |
| Product Name            | *MyTravelExpense*     |
| Organization Name       | *Your Company Name*   |
| Organization Identifier | *com.yourcompanyname* |

Select a path where you want to create your Xcode project and click **Finish**.

![Edit Project Properties](https://user-images.githubusercontent.com/9074514/48112381-18990800-e20b-11e8-978d-20b9a5a3fb15.png)

### Run your generated application

Xcode should automatically open your newly created project.

To run your application in the iOS simulator, choose the **iPhone XR** simulator from the device list at the top of the window, and click the **Run** button.

![Generated project in Xcode](https://user-images.githubusercontent.com/9074514/48112636-2307d180-e20c-11e8-8607-24b55a99674a.png)

After the Simulator has started, the generated app will launch. Click **Start** to begin the onboarding process. After a few screens that demonstrate an onboarding agreement flow, you will be prompted to set a passcode for your app.

![Generated app Start button](https://user-images.githubusercontent.com/9074514/49339330-0a95a600-f656-11e8-8d47-3bbe6b02b12f.png)

> **Note:** To bypass requests for your passcode with every launch, turn on biometric authentication by selecting both **Face ID > Enrolled** and **Face ID > Matching Face** from the **Hardware** menu in the **Simulator** app, before you set your passcode.

Once you have set a passcode, you’ll land on the main app screen, where you can explore the data on your deployed backend.

![Generated app Collections view](https://user-images.githubusercontent.com/9074514/49339328-036e9800-f656-11e8-9e76-097172d0a15b.png)

Because this minimal iOS app has all the sample code required to query, create, and modify expense entities, you can use it as the base for implementing your own views leveraging Fiori for iOS controls.

## Configure Pre-built Travel Expense App

You can leverage the backend data and cloud application created in the previous steps to configure the pre-built Travel Expense sample in this repository.

In the **Finder**, navigate to the local folder where you placed the cloned version of the **Travel Expense** repository.

Open the Xcode project file titled **TravelExpenses.xcodeproj**.

### Replace the placeholder values

Click on the **AppDelegate.swift** file in the Xcode project navigator.

Scroll to the configuration value placeholders.

![Reference app configuration placeholders](https://user-images.githubusercontent.com/9074514/49339335-108b8700-f656-11e8-8dda-f2af30fc3d14.png)

Set the value of the **trialAccountName** string to your account name.

This value is displayed after navigating to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome and clicking on **Neo Trial**. The name should look something like **p1234567890trial**

![Account name in Cloud Platform Cockpit](https://user-images.githubusercontent.com/9074514/48092778-79e8b900-e1c2-11e8-8904-2ce5f9139b1f.png)

Set the value of the **applicationID** string to `"com.example.MyMobileCloudServiceApplication"`.

Set the value of the **destinationName** string to `"ExpenseDestination"`.

> **Note:** If you have chosen your own names in the previous sections, be sure to set the correct values here.

![Reference app configuration completed](https://user-images.githubusercontent.com/9074514/49339336-108b8700-f656-11e8-95b6-a61dc9bf48d8.png)

### Export Frameworks to the Xcode Project

Open the **SAP Cloud Platform SDK for iOS Assistant**.

![Assistant main view](https://user-images.githubusercontent.com/28980634/47417490-5d875e00-d778-11e8-914d-897504ea3d41.png)

From the **SAP Cloud Platform SDK for iOS Assistant** menu, select the **Export Frameworks...** menu item.

![Export Frameworks menu item](https://user-images.githubusercontent.com/9074514/48164756-48dab800-e298-11e8-92b9-44d291b266c4.png)

Select the **frameworks** folder inside the **Travel Expense** folder and click **Export**.

![Select export destination dialog](https://user-images.githubusercontent.com/28980634/47424847-ec03db80-d788-11e8-9837-488c3e8bec7c.png)

Click the **Run** button in Xcode to run your copy of the *TravelExpense* app.

![Reference app with frameworks in place](https://user-images.githubusercontent.com/9074514/49339339-11241d80-f656-11e8-98e2-a17d45b66066.png)

After the Simulator has started, the TravelExpense app will launch. Click **Start** to begin.

![Reference app Start button](https://user-images.githubusercontent.com/9074514/49339334-0ff2f080-f656-11e8-985f-296d8982b946.png)

You’re done! Tap through the on-boarding screens, enter a passcode, and review the TravelExpense sample app.  Like the minimal app you created in the previous section, this app demonstrates query and expense creation and modification techniques. This sample goes further, however, in that it also includes code examples demonstrating how to implement Fiori controls and connect them to the backend expense data.

![Reference app report list](https://user-images.githubusercontent.com/9074514/49339337-11241d80-f656-11e8-97b9-53ccdbedbe3e.png)

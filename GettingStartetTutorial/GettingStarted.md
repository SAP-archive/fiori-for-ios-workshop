# Getting Started

This guide will help you setup all necessary components to run our reference application. 

## Install Sample Expense Data

We're using a predefined Java Application Backend you can host in your Neo Trial Cloud landscape. You can connect whatever application you're building against this backend service if you want to.

Open a browser window to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome

Click on **Neo Trial** to enter the **Neo Trial landscape** on the SAP Cloud Platform.

![Backend-setup-cloud](/images/install-backend/backend-1.png)

Next, click on **Applications** and then **Java Applications**.

![Backend-setup-cloud](/images/install-backend/backend-2.png)

To deploy a new Java application, click on **Deploy Application**. A new Pop-up should appear.

![Backend-setup-cloud](/images/install-backend/backend-3.png)

From here click on **Browse** and navigate to your local version of the cloned repository. Select the **SAPTravelExpense.war** file and click **Choose**.

![Backend-setup-cloud](/images/install-backend/backend-4.png)

Now you have to select a Runtime where your backend should run on. For this sample Java Backend we're using the **Java Web Tomcat 8** runtime.
Under the **Runtime Name** dropdown menu, select the **Java Web Tomcat 8** runtime and leave the rest as it is.

![Backend-setup-cloud](/images/install-backend/backend-5.png)

Click the **Deploy** button at the bottom of the window to start the deployment of the .war file.

After the deployment finishes you have to start your application by clicking the **Start** button at the bottom of the window.

![Backend-setup-cloud](/images/install-backend/backend-6.png)

Now the SAP Cloud Platform starts the Java Application so you can use it as a backend.

![Backend-setup-cloud](/images/install-backend/backend-7.png)

Once the application transitions from **Starting** to **Started** your application is up and running.

![Backend-setup-cloud](/images/install-backend/backend-8.png)

To verify the services data click on the name **saptravelexpense** and click on the link under **Applications URLs** to open the **Service Document** of the OData Service.

![Backend-setup-cloud](/images/install-backend/backend-9.png)
![Backend-setup-cloud](/images/install-backend/backend-10.png)

Copy the URL for use as the **Backend URL** in the following steps.

## Generate an Entity Viewer Application

After deploying and starting the Travel Expense backend we could setup the reference application and the **Mobile Services, std** configuration now. As we want to develop our own application later on we will use the **SAP Cloud Platform SDK for iOS Assistant** to create the **Mobile Services, std** configuration and an Entity Viewer Application. This generated application you can use later on to build your own Travel Expense app.

### Enable Mobile Services

First you have to activate the **Mobile Services, std** in your Neo Trial Cloud landscape. For that open a browser window to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome and select **Neo Trial**.

![Backend-setup-cloud](/images/install-backend/backend-1.png)

Next click on **Services** in the left navigation panel.

![Entity-Viewer](/images/entity-viewer/entity-viewer-1.png)

Use the search field to search for **Mobile** on this page.

![Entity-Viewer](/images/entity-viewer/entity-viewer-2.png)

Click on **Mobile Services, std** and if not enabled yet, click on **Enable**.

> Note: This may take a while so no worries!

![Entity-Viewer](/images/entity-viewer/entity-viewer-3.png)

After enabling the service or if already enabled, click on **Go to Service** to open **SAP Cloud Platform Mobile Services**.

![Entity-Viewer](/images/entity-viewer/entity-viewer-4.png)

### Configure the SAP Cloud Platform SDK for iOS Assistant

To configure the **SAP Cloud Platform SDK for iOS Assistant** go to **Important Links** and click **Importing URLs directly**.

![Entity-Viewer](/images/entity-viewer/entity-viewer-5.png)

The **SAP Cloud Platform SDK for iOS Assistant** will launch and prompt you to complete the entry of your account information.

![Entity-Viewer](/images/entity-viewer/entity-viewer-7.png)

Enter the following information:

| Field | Information |
| --- | --- |
| Name | *Mobile Services on Neo Trial*  |
| Authentication | *Basic Authentication* |

For **Username** and **Password** enter your **SAP Cloud Platform** credentials and click **Save**.

![Entity-Viewer](/images/entity-viewer/entity-viewer-8.png)

Click **Back** to return to the main page of the assistant.

![Entity-Viewer](/images/entity-viewer/entity-viewer-9.png)

### Create your first Xcode Project

Click the **Create new** button.

![Entity-Viewer](/images/entity-viewer/entity-viewer-9-1.png)

To create a new application, click **Create New Application**.

![Entity-Viewer](/images/entity-viewer/entity-viewer-10.png)

Select **Mobile Services on Neo Trial** for the **Account** and click **Next**.

![Entity-Viewer](/images/entity-viewer/entity-viewer-11.png)

The next configuration will create a **SAP Cloud Platform Mobile Services** application for you.

Enter the following information:

| Field | Information |
| --- | --- |
| Name | *EntityViewer*  |
| Identifier | *com.example.entityviewer* |

Select **None** from the **Authentication** dropdown menu and click **Next**.

> Note: You could enter whatever *Name* and *Identifier* you want.

![Entity-Viewer](/images/entity-viewer/entity-viewer-12.png)

In the next step you need to define a **Destination** to your backend. As we just started our backend in the previous section we have to create a new destination here.

Click **Add new**

![Entity-Viewer](/images/entity-viewer/entity-viewer-13.png)

Enter the following information in the corresponding fields:

| Field | Information |
| --- | --- |
| Name | *ExpenseDestination*  |
| Backend URL | *Paste in the URL from the previous section* |

Choose **No Authentication** from the **Authentication Type** dropdown and click **Save**.

![Entity-Viewer](/images/entity-viewer/entity-viewer-14.png)

To continue with the project creation click **Next**.

![Entity-Viewer](/images/entity-viewer/entity-viewer-15.png)

For this project keep all the defaults and click **Next**.

![Entity-Viewer](/images/entity-viewer/entity-viewer-16.png)

This step will have all the information for your Xcode Project later on, so please enter the following information:

| Field | Information |
| --- | --- |
| Product Name | *EntityViewer*  |
| Organization Name | *Your Company* |
| Organization Identifier | *Your Company* |

Select a path where you want to create your Xcode project and click **Finish**.

> Note: You could set those fields to whatever you want.

![Entity-Viewer](/images/entity-viewer/entity-viewer-17.png)

### Run your generated application

Xcode should automatically open with your just created project.

To run your application on a simulator, choose the **iPhone X** scheme and click the **Run** button.

![Entity-Viewer](/images/entity-viewer/entity-viewer-18.png)

After the Simulator has started your application should be visible. The first steps to explore the life data in your application is to go through the on-boarding process. Click **Start** to begin.

![Entity-Viewer](/images/entity-viewer/entity-viewer-19.png)

To logon enter your **SAP Cloud Platform** account username and password.

![Entity-Viewer](/images/entity-viewer/entity-viewer-20.png)

After the on-boarding process you can now explore the life data from your deployed backend.

![Entity-Viewer](/images/entity-viewer/entity-viewer-21.png)

## Configure the Travel Expense Application

In the previous steps you did all necessary steps to now configure our reference app.

In the **Finder**, navigate to the local directory where you placed the cloned version of the **Travel Expense** project.

Open the Xcode project file titled **TravelExpenses.xcodeproj**.

### Replace the placeholder values

Click on the **AppDelegate.swift** file in the Xcode project navigator.

Scroll to the configuration value placeholders.

![Reference-App](/images/configure-reference-app/reference-app-1.png)

Set the value of the **TRIALACCOUNT** string to your account name.

This value is displayed after navigating to https://account.hanatrial.ondemand.com/cockpit#/home/trialhome and clicking on **Neo Trial**. The name should look something like **p1942140767trial**

![Reference-App](/images/configure-reference-app/reference-app-2.png)

Set the value of the **APPLICATIONID** string to "com.example.entityviewer".

Set the value of the **DESTINATION** string to "saptravelexpense".

> Note: If you have chosen your own names in the previous sections you have to make sure to set the correct values here.

![Reference-App](/images/configure-reference-app/reference-app-3.png)

### Export Frameworks to the Xcode Project

Open the **SAP Cloud Platform SDK for iOS Assistant**.

![Reference-App](/images/configure-reference-app/reference-app-4.png)

From the **SAP Cloud Platform SDK for iOS Assistant** menu, select the **Export Frameworks...** menu item.

![Reference-App](/images/configure-reference-app/reference-app-5.png)

Select the **frameworks** directory inside the **Travel Expense** folder and click **Export**.

![Reference-App](/images/configure-reference-app/reference-app-7.png)

![Reference-App](/images/configure-reference-app/reference-app-6.png)

Click the **Run** button in Xcode to run your copy of the *TravelExpense* app.

![Reference-App](/images/configure-reference-app/reference-app-8.png)
